import 'package:farmlink/providers/auth_provider.dart';
import 'package:farmlink/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

import '../../providers/utility/bottom_navigation_provider.dart';
import '../home_pages/product_categories.dart';
import '../home_pages/product_list.dart';
import '../home_pages/profile.dart';

class DealerMainScreen extends StatelessWidget {
  DealerMainScreen({super.key});
  final List<Widget> pages = [ProductCategories(), ProductList(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Consumer2<BottomNavigationProvider, AuthProvider>(
        builder: (context, currentPage, authProvider, child) {
      return Scaffold(
        appBar: CustomAppBar(
          leadingIcon: HeroIcon(HeroIcons.userCircle),
          title: "Welcome",
          subTitle: authProvider.userData!.firstName +
              authProvider.userData!.lastName,
          actionButtons: [
            IconButton(
              onPressed: () {},
              icon: HeroIcon(
                HeroIcons.bell,
              ),
            )
          ],
        ),
        body: pages[currentPage.selectedIndex],
        bottomNavigationBar: Material(
          elevation: 10,
          child: BottomNavigationBar(
            elevation: 25,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentPage.selectedIndex,
            onTap: (value) {
              currentPage.changeCurrentPage(value);
            },
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.secondary,
            items: [
              BottomNavigationBarItem(
                icon: HeroIcon(HeroIcons.buildingOffice2),
                label: "Product",
              ),
              BottomNavigationBarItem(
                icon: HeroIcon(HeroIcons.userGroup),
                label: "Market",
              ),
              BottomNavigationBarItem(
                icon: HeroIcon(HeroIcons.user),
                label: "Profile",
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: HeroIcon(HeroIcons.plus),
        ),
      );
    });
  }
}
