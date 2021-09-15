import 'package:city_petro/widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart' as _picker;
import 'package:intl/intl.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime _startDate = DateTime.now();
    DateTime _endDate = DateTime.now().add(const Duration(days: 1));
    int _value = 1;
    return Scaffold(
      appBar: AppBar(
        title: "Reports".text.make(),
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReportsHeader(),
            VxBox().make().h1(context),
            ListView.separated(

                separatorBuilder: (BuildContext context, int index) => Divider(height: 1,),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return VxBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        VStack([
                          "AUG 19, 2021".text.textStyle(context.captionStyle!).make(),
                          "10274".text.make(),
                          "Brampton".text.make(),
                        ]),
                        "\$5566.00".text.bold.color(Colors.grey[700]!).make(),
                      ],
                    ).p12().px(12)
                  ).color(context.cardColor).make();
                }).expand(),
          ],
        ),
      ),
    );
  }
}

class ReportsHeader extends StatelessWidget {
  const ReportsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            "Total Earnings".text.make(),
            1==1?"\$9,567.00".text.xl4.bold.make():
            VxBox(
              child: HStack([
              CupertinoActivityIndicator(),
              "HELLO".text.color(context.cardColor).xl4.bold.make()
              ])
            ).make(),
            Row(
               mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RawMaterialButton(
                  
                  onPressed: () {},
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      "From Date".text.textStyle(context.captionStyle!).make(),
                      "22-08-2021".text.xl.make()
                    ],),
                  ).p(5),
                ).expand(),
                RawMaterialButton(
                  
                  onPressed: () {},
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      "To Date".text.textStyle(context.captionStyle!).make(),
                      "22-08-2021".text.xl.make()
                    ],),
                  ).p(5),
                ).expand(),
                RawMaterialButton(
                  
                  onPressed: () {},
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      "SEARCH".text.color(context.accentColor).make()
                    ],),
                  ).p(5),
                ).expand(),
              ],
            )
          ],
        ),
      ).p16(),
    ).color(context.cardColor).make();
  }
}
