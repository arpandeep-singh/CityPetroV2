import 'dart:io';

import 'package:CityPetro/models/Load.dart';
import 'package:CityPetro/models/ReportConfig.dart';
import 'package:CityPetro/models/Site.dart';
import 'package:CityPetro/screens/admin-panel/upload_screen_overlay.dart';
import 'package:CityPetro/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:velocity_x/velocity_x.dart';

class AddLoad extends StatefulWidget {
  final Load load;
  const AddLoad({Key? key, required this.load}) : super(key: key);

  @override
  _AddLoadState createState() => _AddLoadState();
}

class _AddLoadState extends State<AddLoad> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  List<Site> sites = [];
  Load load = new Load(date: DateTime.now());
  Site site = new Site();
  bool loading = false;
  ReportConfig config = new ReportConfig();
  List<XFile> files = [];
  List<File> filesForUpt = [];
  String pdfFileForCp = "";

  bool submitting = false;

  String formatWaitingTime(int minutes) {
    Duration duration = new Duration(minutes: minutes);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours);
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));

    return '$twoDigitHours:$twoDigitMinutes';
  }

  void showMessage(String message, MaterialColor color) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(message),
      duration: Duration(milliseconds: 1500),
    ));
  }

  Future addFile(ImageSource source) async {
    String fileSource = source == ImageSource.camera ? 'camera' : 'image';
    scanDocument(fileSource);

    final ImagePicker _picker = ImagePicker();
    XFile? file = await _picker.pickImage(source: source);
    if (file != null) {
      setState(() {
        files.add(file);
      });
    }
  }

  void scanDocument(String source) {
    // FlutterGeniusScan.scanWithConfiguration({
    //   'source': 'camera',
    //   'multiPage': true,
    // }).then((result) {
    //   this.pdfFileForCp = trimFilePath(result['pdfUrl']);
    //   List<Map<String, dynamic>> images = result['scans'];
    //   this.filesForUpt = images.map((img) {
    //     String imagePath = trimFilePath(img['enhancedUrl']);
    //     return new File(imagePath);
    //   }).toList();
    //   // OpenFile.open(pdfFileForCp).then((result) => debugPrint(result.message),
    //   //     onError: (error) => displayError(context, error));
    // }, onError: (error) => displayError(context, error));
  }

  String trimFilePath(String path) => path.replaceAll("file://", '');

  void displayError(BuildContext context, PlatformException error) {
    showMessage(error.message!, Colors.grey);
  }

  void _submitForm() async {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      showMessage('Please fill out the missing details', Colors.red);
      return;
    } else if (!load.validate()) {
      showMessage('Please select STATION ID', Colors.red);
      return;
    }

    form.save();
    print('Load Data: ${load.toString()}');
    load.waitingCost = double.parse(
        ((load.waitingTime * config.waitingRate) / 60).toStringAsFixed(2));
    load.splitCost = (load.splitLoads * config.splitRate);

    showUploadScreen();
  }

  // Future<String> saveDataToDb() async {
  //   return "";
  //   //return await _firebaseService.submitLoad(this.load, this.files);
  // }

  void showUploadScreen() {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 0),
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => UploadOverlayScreen(
              load: this.load,
              files: this.files,
            )));
  }

  @override
  void initState() {
    // setState(() {
    //   if(widget.load!=null){
    //      this.load = widget.load;
    //   }
      
    // });
    super.initState();

    fetchAllCities();
  }

  void fetchAllCities() {
    setState(() => loading = true);
    Future.delayed(Duration(milliseconds: 10)).then((_) => {
          _firebaseService.getDailyReportConfig().then((configData) {
            _firebaseService.getAllSites().then((list) {
              setState(() {
                //load = this.widget.load;
                sites = list;
                config = configData;
                loading = false;
              });
            });
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: "Add Load".text.make(),
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: loading
            ? Container(
                alignment: Alignment.center,
                child: CupertinoActivityIndicator())
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      VxBox(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  "STATION ".text.textStyle(_style()).make(),
                                  Container(
                                    child: Material(
                                      child: InkWell(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.arrow_drop_down),
                                            (load.stationId.isEmpty
                                                    ? "SELECT"
                                                    : load.stationId)
                                                .text
                                                .xl
                                                .bold
                                                .color(Colors.grey[700]!)
                                                .make()
                                                .px(10)
                                                .py(0)
                                          ],
                                        ),
                                        onTap: () {
                                          SelectDialog.showModal<Site>(
                                            context,
                                            label: "Select Station",
                                            //titleStyle: TextStyle(color: Colors.black),

                                            showSearchBox: true,
                                            searchBoxDecoration:
                                                InputDecoration(
                                              hintText: 'Search',
                                              prefixIcon: Icon(Icons.search),
                                            ),
                                            //backgroundColor: Colors.white,
                                            items: sites,
                                            itemBuilder: (BuildContext context,
                                                Site item, bool isSelected) {
                                              return Container(
                                                //color: Colors.grey[100],
                                                //margin:
                                                //  EdgeInsets.only(bottom: 5),
                                                //decoration: BoxDecoration(borderRadius: Radius.circular(10)),
                                                child: ListTile(
                                                  enabled: false,
                                                  selected: isSelected,
                                                  title: Text(item.stationID),
                                                  trailing: item.city.text
                                                      .textStyle(_style())
                                                      .coolGray500
                                                      .make(),
                                                ),
                                              );
                                            },
                                            onChange: (Site selected) {
                                              setState(() {
                                                load.setup(selected);
                                                site = selected;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ).cornerRadius(10),
                                ],
                              ),
                              VxBox().make().h(10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  "CITY ".text.textStyle(_style()).make(),
                                  "RATE".text.xl.textStyle(_style()).make()
                                ],
                              ),
                              //VxBox().make().h(10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  (load.city.isEmpty ? "******" : load.city)
                                      .text
                                      .xl
                                      .bold
                                      .color(Colors.grey[700]!)
                                      .make(),
                                  '\$${((load.baseRate != -1 ? load.baseRate : 0) + (load.splitLoads * config.splitRate)).toStringAsFixed(1)}'
                                      .text
                                      .xl
                                      .bold
                                      .color(Colors.grey[700]!)
                                      .make()
                                ],
                              ),
                              VxBox().make().h(10),
                              Column(
                                children: [
                                  "TERMINAL ".text.textStyle(_style()).make(),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                      child: HStack([
                                    new Radio(
                                      value: site.rateT,
                                      groupValue: load.baseRate,
                                      onChanged: (int? value) {
                                        if (value != 0) {
                                          setState(() {
                                            load.terminal = "Toronto";
                                            load.baseRate = value ?? 0;
                                          });
                                        }
                                      },
                                    ),
                                    "TORONTO"
                                        .text
                                        .textStyle(_style())
                                        .bold
                                        .color(Colors.grey[600]!)
                                        .make(),
                                  ])).expand(),
                                  Container(
                                      child: HStack([
                                    new Radio(
                                      value: site.rateO,
                                      groupValue: load.baseRate,
                                      onChanged: (int? value) {
                                        if (value != 0) {
                                          setState(() {
                                            load.terminal = "Oakville";
                                            load.baseRate = value ?? 0;
                                          });
                                        }
                                      },
                                    ),
                                    "OAKVILLE"
                                        .text
                                        .textStyle(_style())
                                        .bold
                                        .color(Colors.grey[600]!)
                                        .make(),
                                  ])).expand(),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                      child: HStack([
                                    new Radio(
                                      value: site.rateH,
                                      groupValue: load.baseRate,
                                      onChanged: (int? value) {
                                        if (value != 0) {
                                          setState(() {
                                            load.terminal = "Hamilton";
                                            load.baseRate = value ?? 0;
                                          });
                                        }
                                      },
                                    ),
                                    "HAMILTON"
                                        .text
                                        .textStyle(_style())
                                        .bold
                                        .color(Colors.grey[600]!)
                                        .make(),
                                  ])).expand(),
                                  Container(
                                      child: HStack([
                                    new Radio(
                                      value: site.rateN,
                                      groupValue: load.baseRate,
                                      onChanged: (int? value) {
                                        if (value != 0) {
                                          setState(() {
                                            load.terminal = "Nanticoke";
                                            load.baseRate = value ?? 0;
                                          });
                                        }
                                      },
                                    ),
                                    "NANTICOKE"
                                        .text
                                        .textStyle(_style())
                                        .bold
                                        .color(Colors.grey[600]!)
                                        .make(),
                                  ])).expand(),
                                ],
                              ),
                              VxBox().make().h(10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  VxBox(
                                      child: HStack([
                                    "SPLIT LOADS"
                                        .text
                                        .textStyle(_style())
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          if (config.maxSplits != -1 &&
                                              load.splitLoads ==
                                                  config.maxSplits) {
                                            showMessage(
                                                "Admin has set a max limit of ${config.maxSplits} splits",
                                                Colors.red);
                                          } else {
                                            setState(() {
                                              load.splitLoads += 1;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: Colors.green,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          if (load.splitLoads > 0) {
                                            setState(() {
                                              load.splitLoads -= 1;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: Colors.green,
                                        ))
                                  ])).make(),
                                  '${load.splitLoads}'.text.bold.make(),
                                ],
                              )
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  "DATE ".text.textStyle(_style()).make(),
                                  RawMaterialButton(
                                    onPressed: () async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                              helpText: "SELECT LOAD DATE",
                                              context: context,
                                              initialDate: load.date,
                                              firstDate: DateTime(2015, 8),
                                              lastDate: DateTime(2101));
                                      if (picked != null)
                                        setState(() {
                                          load.date = picked;
                                        });
                                    },
                                    child: Container(
                                        //color: Colors.grey[100],
                                        child: load.date.myDateFormat.text.bold
                                            .color(context.accentColor)
                                            .make()
                                            .px12()
                                            .py(5)),
                                  )
                                ],
                              ),
                              VxBox().make().h(10),
                              "TRUCK NUMBER".text.textStyle(_style()).make(),
                              Container(
                                color: Colors.grey[100],
                                child: TextFormField(
                                  onChanged: (value) => load.truck = value,
                                  validator: (val) {
                                    if (config.truckNumberRequired) {
                                      if (val.isEmptyOrNull) {
                                        return "Required*";
                                      }
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    fillColor: Color(0xff1b66a9),
                                  ),
                                ),
                              ).cornerRadius(10)
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  VxBox(
                                      child: HStack([
                                    "WAITING TIME"
                                        .text
                                        .textStyle(_style())
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          if (config.maxWaiting != -1 &&
                                              load.waitingTime ==
                                                  config.maxWaiting) {
                                            showMessage(
                                                "Admin has set a max limit of ${config.maxWaiting} minutes",
                                                Colors.red);
                                          } else {
                                            setState(() {
                                              load.waitingTime +=
                                                  config.waitingTimeStep;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: Colors.green,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          if (load.waitingTime > 0) {
                                            setState(() {
                                              load.waitingTime -=
                                                  config.waitingTimeStep;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: Colors.green,
                                        ))
                                  ])).make(),
                                  '${this.formatWaitingTime(load.waitingTime)}'
                                      .text
                                      .xl
                                      .make(),
                                ],
                              ),
                              VxBox().make().h(10),
                              "COMMENTS".text.textStyle(_style()).make(),
                              Container(
                                color: Colors.grey[100],
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    fillColor: Color(0xff1b66a9),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      load.comments = val;
                                    });
                                  },
                                ),
                              ).cornerRadius(10),
                              VxBox().make().h(15),
                              "UPT LINK".text.textStyle(_style()).make(),
                              Container(
                                color: Colors.grey[100],
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    fillColor: Color(0xff1b66a9),
                                  ),
                                  onChanged: (val) => load.uptLink = val,
                                  validator: (val) {
                                    if (config.uptLinkRequired) {
                                      if (val.isEmptyOrNull) {
                                        return "Required*";
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ).cornerRadius(10),
                              VxBox().make().h(15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Material(
                                      child: InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(Icons.attach_file),
                                                files.isEmpty
                                                    ? Text(
                                                        'SELECT IMAGE(S)',
                                                        style: _style(),
                                                      )
                                                    : Text(
                                                        'SELECT MORE',
                                                        style: _style(),
                                                      ),
                                              ],
                                            ),
                                          ),
                                          onTap: () =>
                                              openBottomSheet(context)),
                                      color: Colors.grey[100],
                                    ),
                                  ).cornerRadius(10),
                                  files.isEmpty
                                      ? Text(
                                          '0 Documents',
                                          style: _style(),
                                        )
                                      : Text(
                                          '${files.length} Document(s)',
                                          style: _style(),
                                        )
                                ],
                              ).pOnly(bottom: 20),
                              //LinearProgressIndicator(color: Colors.green,backgroundColor: Colors.green[200],).cornerRadius(5).py12(),
                              // HStack([
                              //   //Icon(Icons.picture_as_pdf,color: Colors.red,),
                              //   LinearProgressIndicator()
                              // ]).py16(),

                              CupertinoButton.filled(
                                pressedOpacity: 0.8,
                                borderRadius: BorderRadius.circular(0),
                                disabledColor: context.accentColor,
                                child: submitting
                                    ? CupertinoActivityIndicator()
                                    : "SUBMIT".text.make(),
                                onPressed: _submitForm,
                              ).cornerRadius(10).wFull(context)
                            ],
                          ).p20(),
                        ).px12(),
                      ).color(context.cardColor).make().cornerRadius(10)
                    ],
                  ).px12().pOnly(top: 12),
                ),
              ),
      ),
    );
  }

  TextStyle _style() => TextStyle(fontSize: 14);
  openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camera"),
                  onTap: () => addFile(ImageSource.camera).then((_) {
                        Navigator.pop(context);
                      })),
              ListTile(
                  leading: Icon(Icons.photo),
                  title: Text("Photos"),
                  onTap: () => addFile(ImageSource.gallery).then((_) {
                        Navigator.pop(context);
                      })),
              SizedBox(
                height: 40,
              )
            ],
          );
        });
  }
}
