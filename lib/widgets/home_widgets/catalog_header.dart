import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogHedaer extends StatelessWidget {
  const CatalogHedaer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Hello, Arpan!".text.xl4.bold.gray100.make()
      ],
    );
  }
}