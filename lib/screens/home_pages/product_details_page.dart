import 'package:farmlink/configs/api/api_credentials.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

import '../../providers/products/products_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final int productIndex;

  const ProductDetailPage({super.key, required this.productIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
        builder: (context, productProvider, child) {
      final product = productProvider.productsResponse.data[productIndex];
      return Scaffold(
        appBar: AppBar(
          title: Text(
            product.name,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.green.shade700,
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: HeroIcon(
                HeroIcons.arrowLeft,
                color: Colors.white,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product images (Hero Carousel)
                SizedBox(
                  height: 250,
                  child: PageView.builder(
                    itemCount: product.media.length,
                    itemBuilder: (_, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          mediaUrl + product.media[index].mediaPath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Product Title and Price
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      '\$${"${product.pricePerUnit}/${product.unitMeasure}"}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // if (product['discount'] != null) ...[
                    //   Text(
                    //     '\$${product['discount']}',
                    //     style: TextStyle(
                    //       fontSize: 18,
                    //       color: Colors.red,
                    //       decoration: TextDecoration.lineThrough,
                    //     ),
                    //   ),
                    //   const SizedBox(width: 10),
                    // ],
                    Text(
                      'In Stock: ${product.inStockAmount}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Rating Section (Stars and Reviews Count)
                // Row(
                //   children: [
                //     Row(
                //       children: List.generate(
                //         5,
                //         (index) => Icon(
                //           Icons.star,
                //           color: index < product['rating']
                //               ? Colors.amber
                //               : Colors.grey,
                //           size: 20,
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 10),
                //     Text(
                //       '(${product['reviews']} reviews)',
                //       style: TextStyle(
                //         fontSize: 14,
                //         color: Colors.grey.shade600,
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 20),

                // Product Details Card (Category, Location, Producer)
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category
                        Row(
                          children: [
                            Icon(Icons.category, color: Colors.green.shade700),
                            const SizedBox(width: 10),
                            Text(
                              'Category: ${product.category}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Location
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.green.shade700),
                            const SizedBox(width: 10),
                            Text(
                              'Location: ${product.description}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Producer
                        Row(
                          children: [
                            Icon(Icons.business, color: Colors.green.shade700),
                            const SizedBox(width: 10),
                            Text(
                              'Producer: ${product.owner.firstName + product.owner.lastName}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Minimum Quantity
                        Row(
                          children: [
                            Icon(Icons.add_shopping_cart,
                                color: Colors.green.shade700),
                            const SizedBox(width: 10),
                            Text(
                              'Minimum Quantity: ${product.unitMeasure}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Product Description
                Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),

                // Sticky Add to Cart Button
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle Add to Cart or other action
                    },
                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                    label: Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
