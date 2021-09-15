import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogHedaer extends StatelessWidget {
  const CatalogHedaer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "City Petro".text.xl2.bold.color(context.theme.canvasColor).make(),
        "Hello, Arpan!".text.xl4.bold.gray100.make()
      ],
    );
  }
}