import 'package:flutter/material.dart';

import 'farm_link_app.dart';
import 'providers/providers_list.dart';

void main() {
  runApp(
    multiProvider(
      child: FarmLinkApp(),
    ),
  );
}
