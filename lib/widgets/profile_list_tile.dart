import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

Widget buildListTile({
  //  required BuildContext context,
  required HeroIcons icon,
  required String title,
  TextStyle? titleStyle,
  Color? iconColor,
  required String subtitle,
  VoidCallback? onTap,
  HeroIcons? trailingIcon,
}) {
  return Column(
    children: [
      ListTile(
        leading: HeroIcon(
          icon,
          color: iconColor,
        ),
        title: Text(title),
        titleTextStyle: titleStyle,
        subtitle: Text(subtitle),
        trailing: trailingIcon != null
            ? IconButton(onPressed: onTap, icon: HeroIcon(trailingIcon))
            : null,
        onTap: onTap,
      ),
      Divider(
        thickness: 0.2,
        //color: Theme.of(context).colorScheme.primary,
      ),
    ],
  );
}

Widget buildListTile2({
  required HeroIcons icon,
  Color? iconColor,
  required String title,
  required String subtitle,
  VoidCallback? onTap,
  Widget? trailingIcon,
}) {
  return Column(
    children: [
      ListTile(
        leading: HeroIcon(
          icon,
          color: iconColor,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: trailingIcon,
        onTap: onTap,
      ),
      Divider(thickness: 0.2),
    ],
  );
}
