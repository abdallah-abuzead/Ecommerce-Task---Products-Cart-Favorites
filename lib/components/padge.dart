import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

Widget badge(
  context, {
  required String content,
  required Icon icon,
  required Function() onPressed,
}) {
  return Badge(
    position: BadgePosition.bottomEnd(bottom: 1, end: 3),
    badgeColor: Colors.white,
    borderRadius: BorderRadius.circular(3),
    borderSide: BorderSide(color: Colors.black, width: 1),
    badgeContent: Text(content),
    child: IconButton(
      onPressed: onPressed,
      icon: icon,
    ),
  );
}
