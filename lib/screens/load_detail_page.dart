import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoadDetailPage extends StatelessWidget {
  const LoadDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: "Load Detail".text.make(),),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SectionThree()
            ],
          ).px12().pOnly(top: 12),
        ),
      ),
    );
  }
}

class SectionThree extends StatelessWidget {
  const SectionThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "SUMMARY".text.xl.bold.color(Colors.grey[700]!).make(),
            "TRUCK NO.".text.make(),
            Container(
              color: Colors.grey[200],
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0xff1b66a9),
                ),
              ),
            ),
            VxBox().make().h(10),
            //HStack([children])
            "COMMENTS".text.make(),
            Container(
              color: Colors.grey[200],
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0xff1b66a9),
                ),
              ),
            ),
            VxBox().make().h(10),
            "UPT LINK".text.make(),
            Container(
              color: Colors.grey[200],
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0xff1b66a9),
                ),
              ),
            ),
            VxBox().make().h(15),
          ],
        ).p20(),
      ).px12(),
    ).color(context.cardColor).make();
  }
}
