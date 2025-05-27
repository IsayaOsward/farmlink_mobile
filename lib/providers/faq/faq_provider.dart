import 'package:farmlink/services/graphql_service_call.dart';
import 'package:flutter/material.dart';

import '../../graphql/mutations/create_faq_mutation.dart';
import '../../graphql/queries/faq_queries.dart';
import '../../models/defaults/default_response_model.dart';
import '../../models/faq/faq_data_model.dart';
import '../../services/graphql_operation.dart';

class FaqProvider extends ChangeNotifier {
  final service = GraphQLCallService();
  GetAllFaqsResponse _faqData = GetAllFaqsResponse.error();
  DefaultResponseModel? _createFaqResponse;
  DefaultResponseModel? get createFaqResponse => _createFaqResponse;
  int _currentPage = 1;
  bool _hasMore = true;
  bool get hasMore => _hasMore;
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  GetAllFaqsResponse get faqData => _faqData;

  Future<void> fetchAllFaq({bool isLoadMore = false}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadMore) _isLoadingMore = true;
      notifyListeners();
    });

    final response = await service.performGraphQLOperation(
      operationString: fetchFaqQueryString,
      operationType: OperationType.query,
      responseKey: "getAllFaqs",
      variables: {
        "filtering": {"pageNumber": _currentPage}
      },
      fromJson: GetAllFaqsResponse.fromJson,
    );

    if (response!.response.status) {
      if (isLoadMore) {
        _faqData.data.addAll(response.data);
        _isLoadingMore = false;
        if (response.data.isEmpty) _hasMore = false;
      } else {
        _faqData = response;
        _currentPage = response.page.number;
        _hasMore = response.page.hasNextPage;
      }
    } else {
      _faqData = response;
    }

    notifyListeners();
  }

  Future<void> createFaq(String question, String answer) async {
    final result = await service.performGraphQLOperation(
      operationString: createFaqMutationString,
      operationType: OperationType.mutation,
      variables: {
        "input": {"answer": answer, "question": question}
      },
      responseKey: "createFaqMutation.response",
      fromJson: DefaultResponseModel.fromJson,
    );

    _createFaqResponse = result;

    // Refetch FAQs
    _currentPage = 1;
    await fetchAllFaq();
    notifyListeners();
  }

  void loadNextPage() {
    if (_hasMore && !_isLoadingMore) {
      _currentPage++;
      fetchAllFaq(isLoadMore: true);
    }
  }
}
