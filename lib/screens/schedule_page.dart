import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Bi Weekly Schedule".text.make(),
      ),
      body: Column(
        children: [
          ScheduleHeader(),
          VxBox().make().h1(context),
          1==2?CupertinoActivityIndicator(radius: 15,).centered().expand():
          ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(
                    height: 1,
                  ),
              itemCount: 15,
              itemBuilder: (context, index) {
                return 
                VxBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VStack([
                        "AUG 19, 2021".text.textStyle(context.captionStyle!).make(),                   
                        "P155, T80".text.make(),
                      ]),
                      VxBox(child: "AM".text.make().px12() ).color(Color(0xffD6E4FF)).make(),

                    ],
                  ).p12().px(12)
                ).color(context.cardColor).make();
              }).expand(),
        ],
      ),
    );
  }
}

class ScheduleHeader extends StatelessWidget {
  const ScheduleHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "SCHEDULE".text.xl2.bold.color(Colors.grey[700]!).make(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "From Date".text.textStyle(context.captionStyle!).make(),
                      "22-08-2021".text.xl.make()
                    ],
                  ),
                ).p(5).expand(),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "To Date".text.textStyle(context.captionStyle!).make(),
                      "22-08-2021".text.xl.make()
                    ],
                  ),
                ).p(5).expand(),
              ],
            )
          ],
        ),
      ).p16(),
    ).color(context.cardColor).make();
  }
}
