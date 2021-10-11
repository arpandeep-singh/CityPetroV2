import 'package:city_petro/models/Shift.dart';
import 'package:city_petro/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:city_petro/models/Load.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  ScheduleReport schedule = new ScheduleReport();
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadResults();
  }

  void loadResults() {
    Future.delayed(new Duration(milliseconds: 200)).then((value) {
      schedule.refreshData().then((_) {
        setState(() => loading = false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            "Bi Weekly Schedule".text.textStyle(TextStyle(fontSize: 14)).make(),
      ),
      body: Column(
        children: [
          scheduleHeader(),
          VxBox().make().h1(context),
          loading
              ? CupertinoActivityIndicator(
                      //radius: 10,
                      )
                  .centered()
                  .expand()
              : ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 10,),
                      // Divider(
                      //   height: 0,
                      // ),
                  itemCount: schedule.shifts.length,
                  // schedule.toDate.difference(schedule.fromDate).inDays,
                  itemBuilder: (context, index) {
                    Shift shift = schedule.shifts[index];
                    return buildShiftItem(shift);
                  }).expand(),
        ],
      ),
    );
  }

  Widget buildShiftItem(item) {
    Shift shift = item as Shift;

    return VxBox(
            child: Row(

      children: [
        VStack([
       shift.date.myDateFormatWithWeekDay.text.textStyle(context.captionStyle!).make(),
         
          shift.isOff?
            VxBox(child: 'DAY OFF'.text.textStyle(style()).make().px(10)).make().backgroundColor(Color(0xffDB3147).withOpacity(0.2)).cornerRadius(5):
           HStack([
            VxBox(child: '${shift.truck}'.text.textStyle(style()).make().px(10)).make().backgroundColor(Colors.green.withOpacity(0.2)).cornerRadius(5),
            // VxBox().width(5).make(),
             VxBox(child: '${shift.trailer}'.text.textStyle(style()).make().px(10)).make().backgroundColor(context.accentColor.withOpacity(0.2)).cornerRadius(5).px(5),
             VxBox(child: '${shift.time}'.text.textStyle(style()).make().px(10)).make().backgroundColor(Color(0xB78A0A).withOpacity(0.2)).cornerRadius(5),
          ]),
        ]),
      ],
    ).p12().px(8))
        .color(context.cardColor)
        .make().cornerRadius(10).px(10);
  }

   TextStyle style() => TextStyle(fontSize: 12);

  Widget scheduleHeader() {
    return VxBox(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "SCHEDULE".text.xl.bold.color(Colors.grey[700]!).make(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "From Date".text.textStyle(context.captionStyle!).make(),
                      loading
                          ? "********".text.make()
                          : schedule.fromDate.myDateFormat.text.make()
                    ],
                  ),
                ).p(5),
                SizedBox(
                  width: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "to".text.textStyle(context.captionStyle!).make(),
                    ],
                  ),
                ).p(5),
                SizedBox(
                  width: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "To Date".text.textStyle(context.captionStyle!).make(),
                      loading
                          ? "********".text.make()
                          : schedule.toDate.myDateFormat.text.make()
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
