import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<String>? titles;
  final String? subTitle;
  final List<String>? subTitles;
  final int? selectedIndex;
  final Widget? leadingIcon;
  final List<Widget>? actionButtons;
  final bool hasTabBar;
  final List<String>? tabs;

  CustomAppBar({
    super.key,
    this.title,
    this.titles,
    this.subTitle,
    this.subTitles,
    this.selectedIndex,
    this.leadingIcon,
    this.actionButtons,
    this.hasTabBar = false,
    this.tabs,
  })  : assert((title != null && titles == null) ||
            (title == null && titles != null) ||
            (title == null && titles == null)),
        assert((subTitle != null && subTitles == null) ||
            (subTitle == null && subTitles != null) ||
            (subTitle == null && subTitles == null)),
        assert(!hasTabBar || (hasTabBar && tabs != null && tabs.isNotEmpty),
            'Tabs must be provided when hasTabBar is true');

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leadingIcon ??
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: HeroIcon(
              HeroIcons.userCircle,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
          ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titles != null ? titles![selectedIndex ?? 0] : title ?? "",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          if (subTitle != null || subTitles != null)
            Text(
              subTitles != null
                  ? subTitles![selectedIndex ?? 0]
                  : subTitle ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
        ],
      ),
      centerTitle: false,
      actions: (actionButtons != null && actionButtons!.isNotEmpty)
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: titles != null
                    ? actionButtons![
                        selectedIndex ?? 0] // Use selected index if multiple
                    : actionButtons!.first, // Use first item if single
              ),
            ]
          : null,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      shadowColor: Theme.of(context).colorScheme.primary,
      elevation: 0.2,
      bottom: hasTabBar && tabs != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(kMinInteractiveDimension),
              child: TabBar(
                tabs: tabs!.map((tabData) => Tab(text: tabData)).toList(),
                indicatorColor: Theme.of(context).colorScheme.primary,
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Theme.of(context).colorScheme.secondary,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (hasTabBar ? kMinInteractiveDimension : 0),
      );
}
