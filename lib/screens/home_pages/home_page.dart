import 'package:farmlink/configs/base_url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/farms/farm_provider.dart';
import 'all_farms_page.dart';
import 'farm_details.dart';
import 'similar_farms_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, String>> similarFarms = const [
    {
      'farmName': 'Lakeview Farm',
      'mainCrop': 'Tomatoes',
      'region': 'Arusha',
      'district': 'Arusha City',
      'ward': 'Ilboru',
      'street': 'Farm Road',
      'productionPeriod': 'March - August',
      'farmerName': 'Daniel Joseph',
      'phone': '+255716543210',
      'email': 'daniel.joseph@example.com',
    },
    {
      'farmName': 'Majengo Organics',
      'mainCrop': 'Avocados',
      'region': 'Kilimanjaro',
      'district': 'Moshi',
      'ward': 'Majengo',
      'street': 'Green St',
      'productionPeriod': 'January - May',
      'farmerName': 'Emily Massawe',
      'phone': '+255717654321',
      'email': 'emily.massawe@example.com',
    },
    {
      'farmName': 'GreenSprout Co.',
      'mainCrop': 'Onions',
      'region': 'Dodoma',
      'district': 'Dodoma Urban',
      'ward': 'Kikuyu South',
      'street': 'Onion Lane',
      'productionPeriod': 'April - September',
      'farmerName': 'Peter Msofe',
      'phone': '+255718765432',
      'email': 'peter.msofe@example.com',
    },
    {
      'farmName': 'Carrot Bros Farm',
      'mainCrop': 'Carrots',
      'region': 'Morogoro',
      'district': 'Morogoro Urban',
      'ward': 'Kihonda',
      'street': 'Carrot Ave',
      'productionPeriod': 'February - July',
      'farmerName': 'Neema Juma',
      'phone': '+255719876543',
      'email': 'neema.juma@example.com',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Consumer<FarmProvider>(builder: (context, farmProvider, child) {
              return Column(
                children: [
                  // Header
                  SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("My Farms"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AllFarmsPage(),
                              ),
                            );
                          },
                          child: const Text("View All"),
                        ),
                      ],
                    ),
                  ),

                  // Farms Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        farmProvider.userSpecificFarmsResponseData.data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final data = farmProvider
                          .userSpecificFarmsResponseData.data[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FarmDetailPage(
                                isMine: true,
                                farm: data,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.network(
                                    "$baseUrl/media${data.media[0].mediaPath}",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  data.location,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                  // Similar Farms Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("From Similar Category",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  SimilarFarmsPage(similarFarms: similarFarms),
                            ),
                          );
                        },
                        child: const Text("View All"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Similar Farms List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: farmProvider.allFarmsResponseData.data.length > 5
                        ? 5
                        : farmProvider.allFarmsResponseData.data.length,
                    itemBuilder: (_, index) {
                      final farm = similarFarms[index];
                      final similarFarm =
                          farmProvider.allFarmsResponseData.data[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FarmDetailPage(
                                isMine: false,
                                farm: similarFarm,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.green.shade100),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    similarFarm.name,
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
                                    'From: ${similarFarm.location}',
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
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
