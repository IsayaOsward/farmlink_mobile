import 'package:farmlink/configs/api/api_credentials.dart';
import 'package:farmlink/providers/categories/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

class ListCategories extends StatelessWidget {
  const ListCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const HeroIcon(
            HeroIcons.arrowLeft,
          ),
        ),
        title: const Text(
          "All Categories",
        ),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          return ListView.builder(
            itemCount: categoryProvider.allCategoryResponseData.data.length,
            itemBuilder: (context, index) {
              final category =
                  categoryProvider.allCategoryResponseData.data[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    mediaUrl + category.media.mediaPath,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(category.name),
                subtitle: Text(
                  category.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: PopupMenuButton<String>(
                  icon: const HeroIcon(HeroIcons.ellipsisVertical),
                  onSelected: (String result) async {
                    if (result == 'edit') {
                      // await categoryProvider.udpateCategory(u);
                    } else if (result == 'delete') {
                      // Implement delete functionality
                      // For example: categoryProvider.deleteCategory(category.id);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
