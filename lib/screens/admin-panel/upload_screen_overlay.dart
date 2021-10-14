import 'dart:io';

import 'package:CityPetro/models/Load.dart';
import 'package:CityPetro/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class UploadOverlayScreen extends StatefulWidget {
  final Load load;
  final List<XFile> files;
  //final String pdfPath;
  const UploadOverlayScreen(
      {Key? key,
      required this.load,
      required this.files,
      //required this.pdfPath
      })
      : super(key: key);

  @override
  _UploadOverlayScreenState createState() => _UploadOverlayScreenState();
}

class _UploadOverlayScreenState extends State<UploadOverlayScreen> {
  FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  bool loading = false;
  bool success = false;
  @override
  void initState() {
    super.initState();
    submitLoad();
  }

  void submitLoad() async {
    print('Load Recived: ${this.widget.load}');
    try {
      setState(() => loading = true);
      String savedDocId = await saveDataToDb();
      print('Doc Id :$savedDocId');
      setState(() => success = savedDocId.isNotEmpty);
    } on Exception catch (e) {
      setState(() => success = false);
      print('Load Status: Something Went wrong');
    }
    setState(() => loading = false);
  }

  Future<String> saveDataToDb() async {
    return await _firebaseService.submitLoad(
        this.widget.load, this.widget.files);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            loading
                ? LinearProgressIndicator().cornerRadius(10).h(8).px16()
                : success
                    ? Lottie.asset(
                        'assets/files/done.json',
                        repeat: false,
                      )
                    : Lottie.asset("assets/files/failed.json", repeat: false),
            !loading
                ? OutlinedButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: "Okay!".text.make())
                    .centered()
                : Container()
          ],
        ).centered().px32(),
      ),
    );
  }
}
