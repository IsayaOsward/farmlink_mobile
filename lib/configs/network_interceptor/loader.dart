import 'package:flutter/material.dart';

import '../../utils/custom_loading_indicator.dart';

class NetworkLoader {
  static final NetworkLoader _instance = NetworkLoader._internal();
  OverlayEntry? _overlayEntry;

  factory NetworkLoader() => _instance;

  NetworkLoader._internal();

  void show(BuildContext context) {
    if (_overlayEntry != null) return;

    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          ModalBarrier(color: Colors.transparent, dismissible: false),
          ModalBarrier(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
            dismissible: false,
          ),
          Center(
            child: CustomLoadingIndicator(),
          ),
        ],
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
