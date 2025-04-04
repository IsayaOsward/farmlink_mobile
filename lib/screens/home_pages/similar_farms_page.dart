import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'farm_details.dart';

class SimilarFarmsPage extends StatelessWidget {
  final List<Map<String, String>> similarFarms;
  const SimilarFarmsPage({super.key, required this.similarFarms});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: HeroIcon(
            HeroIcons.arrowLeft,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Similar Farms',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search Similar Farms...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.green.shade300),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Similar farms list
            Expanded(
              child: ListView.builder(
                itemCount: similarFarms.length,
                itemBuilder: (context, index) {
                  final farm = similarFarms[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FarmDetailPage(
                            farmName: farm['farmName']!,
                            mainCrop: farm['mainCrop']!,
                            region: farm['region']!,
                            district: farm['district']!,
                            ward: farm['ward']!,
                            street: farm['street']!,
                            productionPeriod: farm['productionPeriod']!,
                            farmerName: farm['farmerName']!,
                            phone: farm['phone']!,
                            email: farm['email']!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.green.shade100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.shade100,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                farm['farmName']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Crop: ${farm['mainCrop']}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Region: ${farm['region']}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
