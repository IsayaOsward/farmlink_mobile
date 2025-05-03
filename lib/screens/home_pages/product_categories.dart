import 'package:farmlink/screens/home_pages/list_categories.dart';
import 'package:farmlink/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

import '../../configs/base_url.dart';
import '../../providers/categories/category_provider.dart';
import 'category_items.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
          return Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                label: "Search categories",
                prefix: HeroIcon(
                  HeroIcons.magnifyingGlass,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Agriculture categories",
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ListCategories())),
                    child: Text(
                      "View All",
                    ),
                  ),
                ],
              ),
              // Category Grid
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: categoryProvider.allCategoryResponseData.data.length,
                itemBuilder: (context, index) {
                  var category =
                      categoryProvider.allCategoryResponseData.data[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryItems(
                            categoryName: category.name,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Category image
                            Image.network(
                              "$baseUrl/media${category.media.mediaPath}",
                              fit: BoxFit.cover,
                            ),
                            // Category overlay and title
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withAlpha(80),
                                    Colors.black.withAlpha(90),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                category.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black.withAlpha(
                                        120,
                                      ),
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
