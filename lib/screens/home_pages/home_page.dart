import 'package:flutter/material.dart';
import 'all_farms_page.dart';
import 'farm_details.dart';
import 'similar_farms_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map<String, String>> items = [
    {
      'image':
          'https://img.freepik.com/free-photo/sunny-meadow-landscape_1112-134.jpg',
      'farmName': 'Green Valley Farm',
      'mainCrop': 'Tomatoes',
      'region': 'Arusha',
      'district': 'Arusha City',
      'ward': 'Ilboru',
      'street': 'Old Moshi Rd',
      'productionPeriod': 'March - August',
      'farmerName': 'John Mollel',
      'phone': '+255712345678',
      'email': 'john.mollel@example.com',
    },
    {
      'image':
          'https://img.freepik.com/free-photo/beautiful-shot-cornfield-with-blue-sky_181624-20783.jpg',
      'farmName': 'Hillside Avocados',
      'mainCrop': 'Avocados',
      'region': 'Kilimanjaro',
      'district': 'Moshi',
      'ward': 'Majengo',
      'street': 'Kibo Street',
      'productionPeriod': 'January - May',
      'farmerName': 'Maria Lema',
      'phone': '+255713456789',
      'email': 'maria.lema@example.com',
    },
    {
      'image':
          'https://img.freepik.com/free-photo/so-many-vegetables-this-field_181624-18619.jpg',
      'farmName': 'Red Gold Farm',
      'mainCrop': 'Onions',
      'region': 'Dodoma',
      'district': 'Dodoma Urban',
      'ward': 'Kikuyu North',
      'street': 'Mlimani Road',
      'productionPeriod': 'April - September',
      'farmerName': 'Frank Mwinuka',
      'phone': '+255714567890',
      'email': 'frank.mwinuka@example.com',
    },
    {
      'image':
          'https://img.freepik.com/free-photo/farm-worker-happy-see-non-gmo-vegetable-plantation-crop-yields_482257-64599.jpg',
      'farmName': 'Organic Roots',
      'mainCrop': 'Carrots',
      'region': 'Morogoro',
      'district': 'Morogoro Urban',
      'ward': 'Kihonda',
      'street': 'Tanesco Street',
      'productionPeriod': 'February - July',
      'farmerName': 'Asha Ndunguru',
      'phone': '+255715678901',
      'email': 'asha.ndunguru@example.com',
    },
  ];

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
            child: Column(
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
                              builder: (_) => AllFarmsPage(farms: items),
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
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FarmDetailPage(
                              farmName: item['farmName']!,
                              mainCrop: item['mainCrop']!,
                              region: item['region']!,
                              district: item['district']!,
                              ward: item['ward']!,
                              street: item['street']!,
                              productionPeriod: item['productionPeriod']!,
                              farmerName: item['farmerName']!,
                              phone: item['phone']!,
                              email: item['email']!,
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
                                  item['image']!,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item['farmName']!,
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
                                '${item['district']} - ${item['ward']}',
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
                  itemCount: similarFarms.length,
                  itemBuilder: (_, index) {
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
              ],
            ),
          ),
        );
      },
    );
  }
}
