import 'package:city_petro/models/Load.dart';
import 'package:city_petro/models/PdfDoc.dart';
import 'package:city_petro/screens/pdf_view_page.dart';
import 'package:city_petro/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:velocity_x/velocity_x.dart';

class LoadDetailPage extends StatefulWidget {
  final String id;
  const LoadDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _LoadDetailPageState createState() => _LoadDetailPageState();
}

class _LoadDetailPageState extends State<LoadDetailPage> {
  FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  Load load = new Load(date: DateTime.now());
  bool loading = false;

  @override
  void initState() {
    super.initState();
    fetchLoadDetail();
  }

  void fetchLoadDetail() {
    setState(() => loading = true);
    Future.delayed(Duration(milliseconds: 300)).then((_) {
      _firebaseService.getSingleLoad(this.widget.id).then((data) {
        setState(() 
        {
          load = data;
          loading = false;
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Load Detail".text.textStyle(TextStyle(fontSize: 14)).make(),
      ),
      body: SafeArea(
        child: loading
            ? Container(
                alignment: Alignment.center,
                child: CupertinoActivityIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [DataSection(load: load)],
                ).px12().pOnly(top: 12),
              ),
      ),
    );
  }
}

class PaymentDataBox extends StatelessWidget {
  final String title;
  final String value;
  const PaymentDataBox({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            children: <Widget>[
              Container(
                //alignment: Alignment.centerRight,
                child: title.text.textStyle(TextStyle(fontSize: 12)).make(),
              ).expand(),
              VxBox(
                      child: value.text
                          .textStyle(TextStyle(fontSize: 12))
                          .align(TextAlign.right)
                          .make()
                          .px(10))
                  .make()
                  .backgroundColor(Colors.green.withOpacity(0.2))
                  .cornerRadius(5)
                  .px(5)
            ],
          ),
        ),
        VxBox().make().h(10),
        Divider(
          height: 2,
        ),
        VxBox().make().h(10),
        // VxBox().make().h(15),
      ],
    );
  }
}

class DataSection extends StatefulWidget {
  final Load load;
  const DataSection({Key? key, required this.load}) : super(key: key);

  @override
  _DataSectionState createState() => _DataSectionState();
}

class _DataSectionState extends State<DataSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VxBox(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "LOAD SUMMARY"
                        .text
                        .bold
                        .color(Colors.grey[700]!)
                        .textStyle(TextStyle(fontSize: 14))
                        .make()
                        .py12(),
                    '${widget.load.date.myDateFormat}'
                        .text
                        .textStyle(TextStyle(fontSize: 14))
                        .make(),
                  ],
                ),
                PaymentDataBox(
                  title: "City",
                  value: widget.load.city,
                ),
                PaymentDataBox(
                  title: "Station",
                  value: widget.load.stationId,
                ),
                PaymentDataBox(
                  title: "Terminal",
                  value: widget.load.terminal,
                ),
                PaymentDataBox(
                  title: "Split Loads",
                  value: '${widget.load.splitLoads}',
                ),
                PaymentDataBox(
                  title: "Waiting Time",
                  value: '${widget.load.waitingTime}',
                ),
                PaymentDataBox(
                  title: "Comments",
                  value: widget.load.comments.isEmpty
                      ? "NA"
                      : widget.load.comments,
                ),
                widget.load.cpPdfLink.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  //alignment: Alignment.centerRight,
                                  child: "Paperwork"
                                      .text
                                      .textStyle(TextStyle(fontSize: 12))
                                      .make(),
                                ).expand(),
                                VxBox(
                                    child: IconButton(
                                  icon: Icon(Icons.arrow_forward_rounded),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        SwipeablePageRoute(
                                            canSwipe: false,
                                            builder: (context) => PdfViewerPage(
                                                  doc: PdfDoc(
                                                      name: "Paperwork",
                                                      url: widget
                                                          .load.cpPdfLink),
                                                )));
                                  },
                                )).make().px(5)
                              ],
                            ),
                          ),
                          VxBox().make().h(10),
                          // VxBox().make().h(15),
                        ],
                      )
                    : Container(),
              ],
            ).p20(),
          ).px12(),
        ).color(context.cardColor).make().cornerRadius(10),
        VxBox().make().h(10),
        VxBox(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "EARNINGS"
                    .text
                    .bold
                    .color(Colors.grey[700]!)
                    .textStyle(TextStyle(fontSize: 14))
                    .make()
                    .py12(),
                PaymentDataBox(
                  title: "GROSS",
                  value: "\$${widget.load.baseRate}",
                ),
                widget.load.splitLoads > 0
                    ? PaymentDataBox(
                        title: "Splits Cost",
                        value: '\$${widget.load.splitCost}',
                      )
                    : Container(),
                widget.load.waitingTime > 0
                    ? PaymentDataBox(
                        title: "Waiting Cost",
                        value: '\$${widget.load.waitingCost}',
                      )
                    : Container(),
                PaymentDataBox(
                  title: "HST",
                  value: '\$${widget.load.HST.toStringAsFixed(2)}',
                ),
                PaymentDataBox(
                  title: "Total Pay",
                  value: '\$${widget.load.totalCostWithHST.toStringAsFixed(2)}',
                ),
              ],
            ).p20(),
          ).px12(),
        ).color(context.cardColor).make().cornerRadius(10),
        VxBox().make().h(10),
        //  CupertinoButton(
        //              color: Colors.red.withOpacity(1),
        //             pressedOpacity: 0.8,
        //             borderRadius: BorderRadius.circular(10),
        //             child: "DELETE".text.make(),
        //             onPressed: () async {

        //             })
        //         .wFull(context)
      ],
    );
  }
}
