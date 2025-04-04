import 'package:flutter/material.dart';

class ProductCategories extends StatelessWidget {
  ProductCategories({super.key});
  // Mock data for agricultural categories (replace with real data from your API or database)
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Seeds',
      'image':
          'https://img.freepik.com/free-photo/sunny-meadow-landscape_1112-134.jpg',
    },
    {
      'name': 'Fertilizers',
      'image':
          'https://img.freepik.com/free-photo/beautiful-shot-cornfield-with-blue-sky_181624-20783.jpg',
    },
    {
      'name': 'Farm Tools',
      'image':
          'https://img.freepik.com/free-photo/so-many-vegetables-this-field_181624-18619.jpg',
    },
    {
      'name': 'Irrigation Equipment',
      'image':
          'https://img.freepik.com/free-photo/sunny-meadow-landscape_1112-134.jpg',
    },
    {
      'name': 'Pesticides',
      'image':
          'https://img.freepik.com/free-photo/beautiful-shot-cornfield-with-blue-sky_181624-20783.jpg',
    },
    {
      'name': 'Plants & Saplings',
      'image':
          'https://img.freepik.com/free-photo/so-many-vegetables-this-field_181624-18619.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Agricultural Product Categories",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.filter_list,
                      color: Colors.green.shade700,
                    ),
                    onPressed: () {
                      // Filter button action
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Search Bar
            TextField(
              decoration: InputDecoration(
                labelText: "Search Categories",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
            SizedBox(height: 20),
            // Category Grid
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                var category = categories[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to category detail page or similar action
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
                            category['image'],
                            fit: BoxFit.cover,
                          ),
                          // Category overlay and title
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.5),
                                  Colors.black.withOpacity(0.3),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              category['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black.withOpacity(0.7),
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
        ),
      ),
    );
  }
}
