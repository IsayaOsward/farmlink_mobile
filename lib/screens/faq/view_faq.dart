import 'package:farmlink/widgets/custom_button.dart';
import 'package:farmlink/widgets/toasts.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

import '../../providers/faq/faq_provider.dart';
import '../../utils/custom_loading_indicator.dart';
import '../../widgets/custom_app_bar.dart';
import 'create_faq.dart';

class ViewFaq extends StatefulWidget {
  const ViewFaq({super.key});
  @override
  State<ViewFaq> createState() => _ViewFaqState();
}

class _ViewFaqState extends State<ViewFaq> {
  final ScrollController _scrollController = ScrollController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFaqs();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      Provider.of<FaqProvider>(context, listen: false).loadNextPage();
    }
  }

  Future<void> _loadFaqs() async {
    setState(() => isLoading = true);
    await Provider.of<FaqProvider>(context, listen: false).fetchAllFaq();
    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final faqProvider = Provider.of<FaqProvider>(context);
    final faqs = faqProvider.faqData.data;
    final response = faqProvider.faqData.response;

    return Scaffold(
      appBar: CustomAppBar(
        title: "FAQs",
        leadingIcon: HeroIcon(
          HeroIcons.questionMarkCircle,
          color: Theme.of(context).colorScheme.primary,
          size: 30,
        ),
        subTitle: "Most Asked Questions",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showCreateFaqDialog(context),
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const CustomLoadingIndicator()
          : response.status && faqs.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: _loadFaqs,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount:
                        faqs.length + (faqProvider.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == faqs.length && faqProvider.isLoadingMore) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: CustomLoadingIndicator(),
                        );
                      }
                      final faq = faqs[index];
                      return Card(
                        elevation: 0.1,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            expandedAlignment: Alignment.topLeft,
                            title: Text(faq.question),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(faq.answer),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: Text("No FAQs available at the moment.",
                      style: TextStyle(fontSize: 16)),
                ),
    );
  }
}
