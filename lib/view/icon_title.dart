

import 'package:flutter/material.dart';

class IconTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  const IconTitle({required this.icon, required this.title, required this.subTitle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(icon),
              ), Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(title),
              ),
            ],
          ),
           Text(subTitle),
        ],
      ),
    );
  }
}
