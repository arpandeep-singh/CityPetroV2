import 'package:CityPetro/models/admin/master_city.dart';
import 'package:CityPetro/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:velocity_x/velocity_x.dart';

class CitySettingsPage extends StatefulWidget {
  final MasterCity city;
  const CitySettingsPage({Key? key, required this.city}) : super(key: key);

  @override
  _CitySettingsPageState createState() => _CitySettingsPageState();
}

class _CitySettingsPageState extends State<CitySettingsPage> {
  FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  bool loading = false;
  String newDocId = "";
  String newStation = "";

  void createOrUpdateCity() async {
    if (widget.city.name.isEmpty) {
      showMessage("Name cannot be empty");
      return;
    }
    showProgressAlertDialog(context);
    bool isNew = widget.city.docId.isEmpty;
    String docId = await _firebaseService.createOrUpdateCity(this.widget.city);

    await Future.delayed(Duration(milliseconds: 300));
    context.pop();

    setState(() {
      if (widget.city.docId.isEmpty) {
        widget.city.docId = docId;
      }
      loading = false;
    });

    String message = docId.isNotEmpty
        ? isNew
            ? "City created successfuly"
            : "City updated successfuly"
        : "Something went wrong";
    
    await Future.delayed(Duration(milliseconds: 300));
    showMessage(message);
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

  void createStation() async {
    if (widget.city.docId.isEmpty) {
      showMessage("Please create a city first");
    } else if (this.newStation.isEmpty) {
      showMessage("Station cannot be empty");
    } else {
      String sId = await _firebaseService.createNewStationInCity(
          this.newStation.trim(), widget.city.docId);
      String message =
          sId.isNotEmpty ? "Station added successfuly" : "Something went wrong";

      showMessage(message);
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      backgroundColor: Colors.green,
      content: new Text(message),
      duration: Duration(milliseconds: 1000),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Create or update city"
            .text
            .textStyle(TextStyle(fontSize: 14))
            .make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            //"Create a new City".text.make().py16(),
            Container(
              color: context.cardColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  "Configure City Deatils".text.make(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Name".text.make(),
                      VxBox().make().w(10),
                      rateField("", TextInputType.text, (val) {
                        setState(() => widget.city.name = val.trim());
                      }, widget.city.name)
                          .expand()
                    ],
                  ).pOnly(top: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Level 1".text.make(),
                      VxBox().make().w(10),
                      rateField("Tor", TextInputType.number, (val) {
                        setState(
                          () => widget.city.rT1 = int.parse(val),
                        );
                      }, widget.city.rT1.toString())
                          .expand(),
                      VxBox().make().w(10),
                      rateField("Oak", TextInputType.number, (val) {
                        setState(() => widget.city.rO1 = int.parse(val));
                      }, widget.city.rO1.toString())
                          .expand(),
                      VxBox().make().w(10),
                      rateField("Ham", TextInputType.number, (val) {
                        setState(() => widget.city.rH1 = int.parse(val));
                      }, widget.city.rH1.toString())
                          .expand(),
                      VxBox().make().w(10),
                      rateField("Nan", TextInputType.number, (val) {
                        setState(() => widget.city.rN1 = int.parse(val));
                      }, widget.city.rH1.toString())
                          .expand(),
                    ],
                  ).py12(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Level 2".text.make(),
                      VxBox().make().w(10),
                      rateField("", TextInputType.number, (val) {
                        setState(() => widget.city.rT2 = int.parse(val));
                      }, widget.city.rT2.toString())
                          .expand(),
                      VxBox().make().w(10),
                      rateField("", TextInputType.number, (val) {
                        setState(() => widget.city.rO2 = int.parse(val));
                      }, widget.city.rO2.toString())
                          .expand(),
                      VxBox().make().w(10),
                      rateField("", TextInputType.number, (val) {
                        setState(() => widget.city.rH2 = int.parse(val));
                      }, widget.city.rH2.toString())
                          .expand(),
                      VxBox().make().w(10),
                      rateField("", TextInputType.number, (val) {
                        setState(() => widget.city.rN2 = int.parse(val));
                      }, widget.city.rN2.toString())
                          .expand(),
                    ],
                  ),
                  CupertinoButton.filled(
                          child: "SUBMIT".text.make(),
                          onPressed: createOrUpdateCity)
                      .py20(),
                ],
              ).p16(),
            ).cornerRadius(10).py20(),

            widget.city.docId.isEmpty
                ? Container()
                : Container(
                    color: context.cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        "Add a station".text.make(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            "Station".text.make(),
                            VxBox().make().w(10),
                            rateField("", TextInputType.text, (val) {
                              setState(() => newStation = val);
                            }, "")
                                .expand()
                          ],
                        ).pOnly(top: 20),
                        CupertinoButton.filled(
                                child: "SUBMIT".text.make(),
                                onPressed: createStation)
                            .py20()
                      ],
                    ).p16(),
                  ).cornerRadius(10).pOnly(top: 20)
          ],
        ).px20(),
      ),
    );
  }

  Widget rateField(String title, TextInputType? type,
      Function(String) onchanged, String initial) {
    return VxBox(
      child: VStack(
        [
          !title.isEmpty
              ? title.text.align(TextAlign.center).make()
              : Container(),
          Container(
            color: Colors.grey[200],
            child: TextFormField(
                initialValue: initial,
                keyboardType: type ?? TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0xff1b66a9),
                ),
                validator: (val) => val.isEmptyOrNull ? "Required*" : null,
                onChanged: onchanged),
          ).cornerRadius(10)
        ],
        alignment: MainAxisAlignment.center,
        crossAlignment: CrossAxisAlignment.center,
      ),
    ).make();
  }
}
