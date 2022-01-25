import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobiresto/constants/colors.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key,
      required this.names,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  final String names;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: secondaryDarkColor,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              names,
              style: const TextStyle(fontSize: 17, color: secondaryDarkColor, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
