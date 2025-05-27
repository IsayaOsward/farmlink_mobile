// ignore_for_file: use_build_context_synchronously

import 'package:farmlink/configs/base_url.dart';
import 'package:farmlink/models/farm_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmDetailPage extends StatelessWidget {
  final Farm farm;
  final bool isMine;
  const FarmDetailPage({
    super.key,
    required this.isMine,
    required this.farm,
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
        actions: [
          isMine
              ? IconButton(
                  onPressed: () {},
                  icon: HeroIcon(
                    HeroIcons.pencilSquare,
                    color: Colors.white,
                  ),
                )
              : SizedBox.shrink()
        ],
        title: Text(
          farm.name,
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
              'Main Crop:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Production Period: '),
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
                itemCount: farm.media.length,
                itemBuilder: (_, i) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image:
                          NetworkImage(mediaBaseUrl + farm.media[i].mediaPath),
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
            Text(
              farm.description,
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
            Text('This farm is located at ${farm.location}'),
            const SizedBox(height: 16),
            const SizedBox(height: 8),
            if (!isMine)
              Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Farmer Contact Info',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  GestureDetector(
                    onLongPress: () => Clipboard.setData(ClipboardData(
                      text: "${farm.owner.firstName}${farm.owner.lastName}",
                    )).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Copied to clipboard!'),
                        ),
                      );
                    }),
                    child: Wrap(
                      children: [
                        Text(
                          'Name: ',
                        ),
                        Text(
                          "${farm.owner.firstName}${farm.owner.lastName}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _launchPhone(farm.owner.phone),
                    onLongPress: () => Clipboard.setData(
                            ClipboardData(text: "+${farm.owner.phone}"))
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Copied to clipboard!'),
                        ),
                      );
                    }),
                    child: Wrap(children: [
                      Text(
                        'Phone: ',
                      ),
                      Text(
                        '+${farm.owner.phone}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () => _launchEmail(farm.owner.email),
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: farm.owner.email))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Copied to clipboard!'),
                          ),
                        );
                      });
                    },
                    child: Wrap(
                      children: [
                        Text(
                          'Email: ',
                        ),
                        Text(
                          farm.owner.email,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
