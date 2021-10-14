import 'package:CityPetro/models/Load.dart';
import 'package:CityPetro/models/Report.dart';
import 'package:CityPetro/screens/load_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:velocity_x/velocity_x.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<Load> loadsData = [];
  bool loading = true;

  Report summary = new Report();

  @override
  void initState() {
    super.initState();
    loadResults();
  }

  void showMessage(String message, MaterialColor color) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(message),
      duration: Duration(milliseconds: 800),
    ));
  }

  void loadResults() {
    setState(() => loading = true);
    Future.delayed(new Duration(milliseconds: 240)).then((value) {
      summary.refreshData().then((_) {
        setState(() => loading = false);
      });
    });
  }

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text("Are you sure you want to delete this load?"),
    actions: [
      TextButton(
        child: Text("Cancel"),
        onPressed: () {},
      ),
      TextButton(
        child: Text("Continue"),
        onPressed: () async {
          //showProgressAlertDialog(context);
          //await summary.deleteLoad(load);
          // setState(() => {});
          //showMessage("Deleted Successfully", Colors.black)
        },
      ),
    ],
  );

  void showDeleteDialog(Load load) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text("AlertDialog"),
          content: Text("Are you sure you want to delete this load?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              child: Text("Continue"),
              onPressed: () async {
                deleteLoad(load);
              },
            ),
          ],
        );
      },
    );
  }

  showProgressAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void deleteLoad(Load load) async {
    context.pop();
    await summary.deleteLoad(load);
    setState(() => {});

    await Future.delayed(Duration(milliseconds: 50));
    showMessage("Deleted Successfully", Colors.green);
  }

  void openDetailScreen(Load load) async {
    var result = await Navigator.push(
      context,
      SwipeablePageRoute(
          canSwipe: false,
          builder: (context) => LoadDetailPage(id: load.docId)),
    );
    if ('$result'.contains("delete")) {
      //showCancelDialog(load);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Reports".text.make(),
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VxBox(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Total Earnings"
                        .text
                        .textStyle(TextStyle(fontSize: 12))
                        .make(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        '\$${summary.totalEarnings >= 0 ? summary.totalEarnings.toStringAsFixed(2) : "0.00"}'
                            .text
                            .xl4
                            //.color(Colors.green[700]!)
                            .bold
                            .make(),
                        Container(
                          child: Row(
                            children: [
                              "HST: ".text.sm.make(),
                              '\$${summary.totalHST.toStringAsFixed(2)} '
                                  .text
                                  .bold
                                  .make(),
                              "Waiting: ".text.sm.make(),
                              '\$${summary.totalWaiting.toStringAsFixed(2)}'
                                  .text
                                  .bold
                                  .make()
                            ],
                          ),
                        )
                        //'HST: \$${summary.totalHST} WAITING: \$${summary.totalWaiting}'.text.make()
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RawMaterialButton(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                                helpText: "SHOW LOADS FROM DATE",
                                context: context,
                                initialDate: summary.fromDate,
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101));
                            if (picked != null) {
                              var toExisting = summary.fromDate;
                              if (picked.compareTo(summary.toDate) > 0) {
                                showMessage(
                                    "From Date cannot be greater than to date",
                                    Colors.red);
                                return;
                              } else if (toExisting != picked) {
                                summary.fromDate = picked;
                                await summary.refreshData();
                                setState(() {});
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.grey[200],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                "From Date"
                                    .text
                                    // .textStyle(TextStyle(fontSize: 12))
                                    .textStyle(context.captionStyle!)
                                    .make(),
                                "${summary.fromDate.myDateFormat}"
                                    //.split(' ')[0]
                                    .text
                                    .xl
                                    .make()
                              ],
                            ).py(2),
                          ).cornerRadius(10).p(5),
                        ).expand(),
                        RawMaterialButton(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                                helpText: "SHOW LOADS TO DATE",
                                context: context,
                                initialDate: summary.toDate,
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101));
                            if (picked != null) {
                              var toExisting = summary.toDate;
                              if (toExisting != picked) {
                                summary.toDate = picked;
                                await summary.refreshData();
                                setState(() {});
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.grey[200],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                "To Date"
                                    .text
                                    .textStyle(context.captionStyle!)
                                    .make(),
                                "${summary.toDate.myDateFormat}"
                                    // .split(' ')[0]
                                    .text
                                    .xl
                                    .make()
                              ],
                            ).py(2),
                          ).cornerRadius(10).p(5),
                        ).expand(),
                      ],
                    )
                  ],
                ),
              ).p16(),
            ).color(context.cardColor).make().cornerRadius(10),
            VxBox().make().h1(context),
            loading
                ? CupertinoActivityIndicator().expand()
                : summary.loads.isEmpty
                    ? "No Data".text.align(TextAlign.center).make()
                    : ListView.separated(
                        separatorBuilder: (_, index) => SizedBox(
                              height: 5,
                            ),
                        itemCount: summary.loads.length,
                        //sphysics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          //DateTime loadDate = summary.loads[index].date;
                          Load load = summary.loads[index];
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.2,
                            child: GestureDetector(
                              onTap: () =>
                                  openDetailScreen(load),
                              onLongPress: () {
                                showDeleteDialog(load);
                              },
                              child: VxBox(
                                      child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  VStack([
                                    load.date.myDateFormat.text
                                        .textStyle(context.captionStyle!)
                                        .make(),
                                    HStack([
                                      VxBox(
                                              child:
                                                  '${load.stationId}'
                                                      .text
                                                      .textStyle(style())
                                                      .make()
                                                      .px(10))
                                          .make()
                                          .backgroundColor(
                                              Colors.green.withOpacity(0.2))
                                          .cornerRadius(5),
                                      // VxBox().width(5).make(),
                                      VxBox(
                                              child:
                                                  '${load.city}'
                                                      .text
                                                      .textStyle(style())
                                                      .make()
                                                      .px(10))
                                          .make()
                                          .backgroundColor(
                                              Color(0xB78A0A).withOpacity(0.2))
                                          .cornerRadius(5)
                                          .px(5),
                                      load.isOnHold? Icon(Icons.warning, color: Colors.yellow[600],):Container()
                                    ]),
                                  ]),
                                  '\$${load.totalCostWithHST.toStringAsFixed(2)}'
                                      .text
                                      .textStyle(TextStyle(fontSize: 12))
                                      .bold
                                      //.color(Colors.green[700]!)
                                      .color(Colors.grey[700]!)
                                      .make(),
                                ],
                              ).py(10).px(20))
                                  .color(context.cardColor)
                                  .make(),
                            ).cornerRadius(0).px(10),
                            // actions: [
                            //   IconSlideAction(
                            //       caption: 'Delete',
                            //       color: Colors.yellow[700],
                            //       icon: Icons.delete,
                            //       onTap: () =>
                            //           showDeleteDialog(summary.loads[index])).cornerRadius(10),
                            // ],
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                  caption: 'Delete',
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: () =>
                                      showDeleteDialog(load)),
                            ],
                          );
                        }).expand(),
          ],
        ),
      ),
    );
  }

  TextStyle style() => TextStyle(fontSize: 12);
}
