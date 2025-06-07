import 'package:farmlink/providers/farms/farm_provider.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'farm_details.dart';

class SimilarFarmsPage extends StatelessWidget {
  const SimilarFarmsPage({super.key, });

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
      body: Consumer<FarmProvider>(builder: (context, farmProvider, child) {
        return Padding(
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
                  itemCount: farmProvider.allFarmsResponseData.data.length,
                  itemBuilder: (context, index) {
                    final farm = farmProvider.allFarmsResponseData.data[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FarmDetailPage(
                              isMine: false,
                              farm: farm,
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
                                  farm.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Crop:}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Region: ${farm.location}',
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
        );
      }),
    );
  }
}
