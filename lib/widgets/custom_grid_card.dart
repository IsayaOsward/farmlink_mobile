// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../utils/device_orientation.dart';

class CustomCard extends StatefulWidget {
  final Widget image;
  final String name;
  final int count;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.image,
    required this.name,
    required this.count,
    this.onTap,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    if (widget.onTap != null) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
      )..repeat(reverse: true);
      _animation = Tween<double>(begin: 0.0, end: 0.2).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceUtil = DeviceUtil();

    // Adjust padding and font sizes based on device type and orientation
    final double padding = deviceUtil.isTablet(context) ? 16.0 : 12.0;
    final double imagePadding = deviceUtil.isTablet(context) ? 12.0 : 8.0;
    final double spacing = deviceUtil.isTablet(context) ? 16.0 : 12.0;
    final double fontSizeTitle = deviceUtil.isTablet(context) ? 18.0 : 14.0;
    final double fontSizeCount = deviceUtil.isTablet(context) ? 16.0 : 12.0;

    // Card content widget
    Widget cardContent = Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(imagePadding),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: widget.image,
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.count.toString(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: fontSizeCount,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: widget.onTap != null
          ? AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return InkWell(
                  onTap: widget.onTap,
                  borderRadius: BorderRadius.circular(12),
                  splashColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(_animation.value),
                        width: 2,
                      ),
                    ),
                    child: cardContent,
                  ),
                );
              },
            )
          : cardContent,
    );
  }
}
