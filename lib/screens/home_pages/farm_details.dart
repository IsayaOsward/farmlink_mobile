import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmDetailPage extends StatelessWidget {
  final String farmName;
  final String mainCrop;
  final String region;
  final String district;
  final String ward;
  final String street;
  final String productionPeriod;
  final String farmerName;
  final String phone;
  final String email;

  const FarmDetailPage({
    super.key,
    required this.farmName,
    required this.mainCrop,
    required this.region,
    required this.district,
    required this.ward,
    required this.street,
    required this.productionPeriod,
    required this.farmerName,
    required this.phone,
    required this.email,
  });

  void _launchPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  void _launchEmail(String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> crops = ['Tomatoes', 'Cabbage', 'Carrots', 'Onions'];
    final List<String> images = [
      'https://img.freepik.com/free-photo/sunny-meadow-landscape_1112-134.jpg',
      'https://img.freepik.com/free-photo/beautiful-shot-cornfield-with-blue-sky_181624-20783.jpg',
      'https://img.freepik.com/free-photo/so-many-vegetables-this-field_181624-18619.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(
            context,
          ),
          child: HeroIcon(
            color: Colors.white,
            HeroIcons.arrowLeft,
          ),
        ),
        title: Text(
          farmName,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              'Main Crop: $mainCrop',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Production Period: $productionPeriod'),
            const SizedBox(height: 16),
            const Text(
              'Other Grown Crops',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            Wrap(
              spacing: 8,
              children: crops
                  .map((crop) => Chip(
                        label: Text(crop),
                        backgroundColor: Colors.green.shade100,
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Farm Images',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (_, i) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(images[i]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'About the Farm',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 8),
            const Text(
              'This farm practices organic farming with a focus on sustainability. It has been operating since 2015 and is known for high quality fresh produce.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1.5),
            const Text(
              'Farm Location',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            Text('Region: $region'),
            Text('District: $district'),
            Text('Ward: $ward'),
            Text('Street: $street'),
            const SizedBox(height: 16),
            const Text(
              'Farmer Contact Info',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 8),
            Text('Name: $farmerName'),
            GestureDetector(
              onTap: () => _launchPhone(phone),
              child: Text(
                'Phone: $phone',
                style: const TextStyle(color: Colors.green),
              ),
            ),
            GestureDetector(
              onTap: () => _launchEmail(email),
              child: Text(
                'Email: $email',
                style: const TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
