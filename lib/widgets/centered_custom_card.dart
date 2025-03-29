import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import '../utils/device_orientation.dart';

class CenteredIconCard extends StatelessWidget {
  final HeroIcons icon; // Changed to HeroIcons enum
  final String title;
  final Color iconColor;
  final double iconSize;

  const CenteredIconCard({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor = Colors.black,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final deviceUtil = DeviceUtil();

    final double padding = deviceUtil.isTablet(context) ? 16.0 : 12.0;
    final double imagePadding = deviceUtil.isTablet(context) ? 12.0 : 8.0;
    final double spacing = deviceUtil.isTablet(context) ? 8.0 : 6.0;
    final double fontSizeTitle = deviceUtil.isTablet(context) ? 20.0 : 12.0;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(imagePadding),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: HeroIcon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
            ),
            SizedBox(height: spacing),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: fontSizeTitle,
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}