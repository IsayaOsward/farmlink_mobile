import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import 'product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Tomato',
      'category': 'Vegetable',
      'location': 'Arusha',
      'producer': 'Green Valley Farms',
      'quantity': 200,
      'unitPrice': 3.5,
      'reviews': 139,
      'minQuantity': 10,
      'rating': 4.5,
      'description': 'Fresh tomatoes grown organically.',
      'images': [
        'https://img.freepik.com/free-photo/sunny-meadow-landscape_1112-134.jpg',
        'https://img.freepik.com/free-photo/beautiful-shot-cornfield-with-blue-sky_181624-20783.jpg',
        'https://img.freepik.com/free-photo/so-many-vegetables-this-field_181624-18619.jpg',
      ]..shuffle(),
    },
    {
      'name': 'Maize',
      'category': 'Grain',
      'location': 'Mbeya',
      'producer': 'Lakeview Farm',
      'quantity': 500,
      'unitPrice': 1.2,
      'reviews': 139,
      'minQuantity': 20,
      'rating': 4.8,
      'description': 'Quality maize harvested from the best fields.',
      'images': [
        'https://img.freepik.com/free-photo/sunny-meadow-landscape_1112-134.jpg',
        'https://img.freepik.com/free-photo/beautiful-shot-cornfield-with-blue-sky_181624-20783.jpg',
        'https://img.freepik.com/free-photo/so-many-vegetables-this-field_181624-18619.jpg',
      ]..shuffle(),
    },
    {
      'name': 'Rice',
      'category': 'Grain',
      'location': 'Dodoma',
      'producer': 'Hilltop Farm',
      'quantity': 300,
      'unitPrice': 2.5,
      'reviews': 139,
      'minQuantity': 15,
      'rating': 4.7,
      'description': 'High-quality rice from the hills of Dodoma.',
      'images': [
        'https://img.freepik.com/free-photo/sunny-meadow-landscape_1112-134.jpg',
        'https://img.freepik.com/free-photo/beautiful-shot-cornfield-with-blue-sky_181624-20783.jpg',
        'https://img.freepik.com/free-photo/so-many-vegetables-this-field_181624-18619.jpg',
      ]..shuffle(),
    },
    {
      'name': 'Cabbage',
      'category': 'Vegetable',
      'location': 'Moshi',
      'producer': 'Sunrise Farm',
      'quantity': 150,
      'unitPrice': 1.8,
      'minQuantity': 5,
      'rating': 4.6,
      'reviews': 139,
      'description': 'Crisp and fresh cabbage from Moshi.',
      'images': [
        'https://img.freepik.com/free-photo/sunny-meadow-landscape_1112-134.jpg',
        'https://img.freepik.com/free-photo/beautiful-shot-cornfield-with-blue-sky_181624-20783.jpg',
        'https://img.freepik.com/free-photo/so-many-vegetables-this-field_181624-18619.jpg',
      ]..shuffle(),
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // Filter products based on search query
    final filteredProducts = products.where((product) {
      return product['name']!
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          product['category']!
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          product['location']!
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          product['producer']!
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Search bar
          TextField(
            onChanged: (query) {
              setState(() {
                searchQuery = query;
              });
            },
            decoration: InputDecoration(
              labelText:
                  "Search by Product Name, Category, Location, or Producer",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.green.shade300),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Product list
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (_, index) {
                final product = filteredProducts[index];
                return Container(
                  height: 100,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green.shade100,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.shade200,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    leading:
                        Icon(Icons.local_grocery_store, color: Colors.green),
                    title: Text(
                      product['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Category: ${product['category']}',
                          style: TextStyle(color: Colors.green.shade700),
                        ),
                        Text(
                          'Location: ${product['location']}',
                          style: TextStyle(color: Colors.green.shade700),
                        ),
                        Text(
                          'Producer: ${product['producer']}',
                          style: TextStyle(color: Colors.green.shade700),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.green.shade700,
                    ),
                    onTap: () {
                      // Navigate to Product Detail Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
