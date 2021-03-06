import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';

import 'package:CityPetro/authenticate/UserInfo.dart' as UserData;
import 'package:CityPetro/authenticate/user.dart';
import 'package:CityPetro/models/City.dart';
import 'package:CityPetro/models/Load.dart';
import 'package:CityPetro/models/PdfDoc.dart';
import 'package:CityPetro/models/ReportConfig.dart';
import 'package:CityPetro/models/Shift.dart';
import 'package:CityPetro/models/Site.dart';
import 'package:CityPetro/models/Station.dart';
import 'package:CityPetro/models/admin/master_city.dart';
import 'package:CityPetro/models/migration/Doc.dart';
import 'package:CityPetro/utils/extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as fb_storage;
import 'package:image_picker/image_picker.dart';
import 'package:darq/darq.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Authentication
  Future<String> signIn(String email, String password) async {
    //"Logging in with " + email + " " + password);
    UserCredential authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    User user = authResult.user!;
    return user.uid;
  }

  Stream<LocalUser> get localUser {
    return _firebaseAuth
        .authStateChanges()
        .map((val) => _userFromFirebaseUser(val!));
  }

  LocalUser _userFromFirebaseUser(User user) =>
      LocalUser.fromFireBaseUser(user);

  // //Stream<User?>? authStateChange() => _firebaseAuth.authStateChanges();
  Stream<User?>? authStateChanges() => _firebaseAuth.authStateChanges();
  Future<void> signOut() => _firebaseAuth.signOut();

  LocalUser get myAppUser => _userFromFirebaseUser(_firebaseAuth.currentUser!);

  Future<bool> get isUserAdmin async {
    var doc =
        await _firestore.collection("Users").doc(this.myAppUser.uid).get();
    var isAdmin = doc.data()?['isAdmin'] ?? false;
    return isAdmin;
  }

  Future<bool> get isUserExist async {
    var doc =
        await _firestore.collection("Users").doc(this.myAppUser.uid).get();
    return doc.exists;
  }

  // //signout
  // Future signOut() async {
  //   return await _firebaseAuth.signOut();
  // }

  Future<List<String>> getDocsFolders(String type) async {
    //print('Type in folders: $type');
    var qds = await _firestore
        .collection("Docs")
        .doc(type)
        .collection("folders")
        .get();
    //qds.
    return qds.docs.map((e) => e.id.toString()).toList();
  }

  Future<List<PdfDoc>> getFiles(String folder, String type) async {
    List<PdfDoc> documents = [];

    if (folder == "Invoices") {
      var qd = await _firestore
          .collection("Users")
          .doc(this.myAppUser.uid)
          .collection("Invoices")
          .get();
      if (qd.docs.isNotEmpty) {
        documents = qd.docs
            .map((e) => PdfDoc(name: e.id, url: e.data()['URL']))
            .toList();
      }
    } else {
      var qds = await _firestore
          .collection("Docs")
          .doc(type)
          .collection("folders")
          .doc(folder)
          .collection("files")
          .get();
      documents = qds.docs
          .map((e) => PdfDoc(name: e.id, url: e.data()['url']))
          .toList();
    }

    return documents;
  }

  Future<List<Load>> getAllLoads(
      DateTime from, DateTime to, String? userId) async {
    String uid = userId ?? this.myAppUser.uid;
    var qds = await _firestore
        .collection("Loads")
        .where('userId', isEqualTo: uid)
        .where('date', isGreaterThanOrEqualTo: from)
        .where('date', isLessThanOrEqualTo: to)
        .get();
    List<Load> loadList =
        qds.docs.map((l) => Load.fromNewJson(l.data(), docId: l.id)).toList();
    loadList.sort((a, b) {
      int cmp = (b.date).compareTo(a.date);
      if (cmp != 0) return cmp;
      return b.dateCreated.compareTo(a.dateCreated);
    });
    return loadList;
  }

  Future<Load> getSingleLoad(String docId) async {
    var ds = await _firestore
        //.collection("Users")
        //.doc(this.myAppUser.uid)
        .collection("Loads")
        .doc(docId)
        .get();
    return Load.fromJsonFullData(ds.data()!);
  }

  Future<void> deleteSingleLoad(String docId) async {
    // String uid = this.myAppUser.uid;
    return await _firestore
        //.collection("Users")
        //.doc(uid)
        .collection("Loads")
        .doc(docId)
        .delete();
  }

  Future<void> deleteSingleCity(String cityId) async {
    return await _firestore.collection("Cities").doc(cityId).delete();
  }

  Future<void> deleteSingleStation(String cityId, String station) async {
    return await _firestore.collection("Cities").doc(cityId).update({
      "stations": FieldValue.arrayRemove([station])
    });
  }

  Future<String> createNewUser(UserData.UserInfo info) async {
    //print('User : ${info.}');
    FirebaseApp app = await Firebase.initializeApp(
        name: 'SecondaryFbApp', options: Firebase.app().options);

    try {
      //Create User
      UserCredential userInfo = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(
              email: info.email, password: info.getPassword());
      await userInfo.user?.updateDisplayName('${info.firstName.capitalize()}');
      await _firestore
          .collection("Users")
          .doc(userInfo.user?.uid)
          .set(info.toJson());

      await app.delete();
      return userInfo.user!.uid;
    } on FirebaseAuthException {
      await app.delete();
    } on FirebaseException {
      await app.delete();
    } on Exception {
      await app.delete();
    }

    return "";
  }

  Future<List<UserData.UserInfo>> getAllUsers() async {
    var qds = await _firestore.collection("Users").get();
    var list = qds.docs
        .map((d) => UserData.UserInfo.fromJson(d.data(), d.id))
        .toList();
    list.sort((a, b) => a.firstName.compareTo(b.firstName));
    return list;
  }

  Future<List<MasterCity>> getAllCities() async {
    var list = await _firestore.collection("Cities").get();
    var names = list.docs
        .map((doc) => MasterCity.fromJson(doc.data(), doc.id))
        .toList();
    return names;
  }

  Future<List<Station>> getAllStationsInCity(String cityId) async {
    var doc = await _firestore
        .collection("Cities")
        .doc(cityId)
        //.collection("Stations")
        .get();
    var names = List.castFrom(doc.data()?['stations'] as List);
    List<Station> stations =
        names.map((s) => Station(name: s, id: cityId)).toList();
    //list.docs.map((doc) => Station.fromJson(doc.data(), doc.id)).toList();
    return stations;
  }

  Future<String> getUserLevel() async {
    String level = "1";
    try {
      // print('Username: ${_firebaseAuth.currentUser?.displayName}');
      //level = _firebaseAuth.currentUser?.displayName?.split("#")[2] ?? "1";
      String uid = _firebaseAuth.currentUser!.uid;
      var doc = await _firestore.collection("Users").doc(uid).get();
      level = doc.data()?["level"] ?? "1";
    } catch (e) {
      //Exception will be thrown if user dosent have last name
      //DisplayName: Arpandeep#Singh#1 FIRST_NAME#LAST_NAME#LEVEL
      return "1";
    }
    return level;
  }

  Future<List<Site>> getAllSites() async {
    //fetch Level of user, if it dosent exist-> default=1 (Basic Driver)
    String level = await this.getUserLevel();
    var citiesList = await _firestore.collection("Cities").get();

    List<Site> siteList = [];
    List<List<Site>> siteList1 = citiesList.docs.map((c) {
      City city = City.fromJson(c.data(), level);
      return city.stations.map((sid) => Site.fromCity(city, sid)).toList();
    }).toList();

    //[[Site1, Site2],[Site3, Site4]] ---> [Site1, Site2, Site3, Site4]
    siteList = siteList1.expand((i) => i).toList();

    return siteList;
  }

  Future<ReportConfig> getDailyReportConfig() async {
    var level = await this.getUserLevel();
    var ds = await _firestore
        .collection("Settings")
        .doc("DailyReportSettings")
        .get();
    return ReportConfig.fromJson(ds.data()!, level);
  }

  Future<String> encodeBytes(XFile file) async {
    Uint8List bytes = await file.readAsBytes();
    String base64Image = "data:image/jpeg;base64," + base64Encode(bytes);
    return base64Image;
  }

  Future<UptResponse> sendToUpt(XFile file, String url) async {
    String encodedFile = await encodeBytes(file);
    Dio dio = new Dio();
    Uri postUri = Uri.parse(url.trim());
    var user = postUri.queryParameters['dn'];
    var shiftID = postUri.queryParameters['sd'];

    String postUrl = 'https://gw.upt.cloud:8081/upload?user=$user&sd=$shiftID';
    // print('postUrl: $postUrl');
    //throw new DioError(requestOptions: postUrl);
    try {
      Response response = await dio.post(postUrl, data: {"img": encodedFile});
      //print('UPt Response ${response.toString()}');
      if (response.statusCode != 200) {
        return new UptResponse(status: response.statusCode!);
      }

      Map<String, dynamic> responseJson = jsonDecode(response.toString());
      String remoteLink = responseJson["result"]["main"]["remote"];
      String localLink = responseJson["result"]["main"]["local"];
      String completeURL = 'https://gw.upt.cloud:8081/$localLink';
      return new UptResponse(
          status: response.statusCode!,
          localLink: completeURL,
          remoteLink: remoteLink);
    } on DioError catch (e) {
      return new UptResponse(
          status: -1,
          localLink: 'CP SERVER ISSUE',
          remoteLink: e.error.toString());
    }
  }

  Future<String> uploadPdfToCP(String pdfPath) async {
    if (pdfPath.isEmpty) return "";

    File pdfFile = new File(pdfPath);
    //Fb.StorageReference
    fb_storage.Reference storage = fb_storage.FirebaseStorage.instance
        .ref()
        .child('paperworkPDF')
        .child('/myDoc.pdf');
    final fb_storage.UploadTask uploadTask = storage.putFile(pdfFile);
    final fb_storage.TaskSnapshot downloadUrl = (await uploadTask);
    return (await downloadUrl.ref.getDownloadURL());
    //return storage.getDownloadURL();
  }

  Future<String> submitLoad(Load load, List<XFile> files) async {
    //Send docs to upt and store response URLs
    List<UptResponse> uploadedDocResponses = [];
    if (files.isNotEmpty) {
      try {
        uploadedDocResponses = await Future.wait(files
            .map((file) async => await sendToUpt(file, load.uptLink))
            .toList());
      } on DioError catch (err) {
        //throw err;
        //print('Paperwork not sent');
      }
    }

    load.documents = files.length;

    // Store combined pdf in firebase storage
    //load.cpPdfLink = await uploadPdfToCP(pdfPath);

    // Save data to City Petro
    DocumentReference doc = await _firestore
        //.collection("Users")
        //.doc(this.myAppUser.uid)
        .collection("Loads")
        .add(load.toJson());

    if (uploadedDocResponses.isNotEmpty) {
      uploadedDocResponses.forEach((res) async {
        var fileDoc = await doc.collection("files").add(res.toJson());
        // print('File Doc ${fileDoc.id}');
      });
    }
    return doc.id;
  }

  Future<void> migrateSiteMaps() async {
    //List<Doc> docListExisting = await _firestore.collection("SiteMaps").doc("Econo")
    var qds = await _firestore.collection("SiteMaps").get();
    List<String> docFolders = qds.docs.map((doc) => doc.id).toList();
    docFolders.forEach((folder) async {
      // print('Moving $folder');
      var qd = await _firestore
          .collection("SiteMaps")
          .doc(folder)
          .collection("maps")
          .get();
      List<Doc> docListExisting =
          qd.docs.map((file) => Doc.fromJson(file.data(), file.id)).toList();

      docListExisting.forEach((doc) async {
        await _firestore
            .collection("Docs")
            .doc("SiteMaps")
            .collection("folders")
            .doc(folder)
            .collection("files")
            .doc(doc.name)
            .set(doc.toJson());
      });
      // print('Moved $folder');
    });
  }

  Future<void> migrateData() async {
    var qds = await _firestore.collection("DipCharts").get();
    List<String> docFolders = qds.docs.map((doc) => doc.id).toList();
    docFolders.forEach((folder) async {
      //print('Moving $folder');
      var qd = await _firestore
          .collection("DipCharts")
          .doc(folder)
          .collection("charts")
          .get();
      List<Doc> docListExisting =
          qd.docs.map((file) => Doc.fromJson(file.data(), file.id)).toList();

      docListExisting.forEach((doc) async {
        await _firestore
            .collection("Docs")
            .doc("DipCharts")
            .collection("folders")
            .doc(folder)
            .collection("files")
            .doc(doc.name)
            .set(doc.toJson());
      });
      //print('Moved $folder');
    });
  }

  Future<List<Shift>> getSchedule(DateTime from, DateTime to) async {
    //'To: ${to.toLocal()}');
    // print('From: ${from.toLocal()}');
    var qds = await _firestore
        .collection("Schedule")
        .doc("report")
        .collection("shifts")
        .where('uid', isEqualTo: this.myAppUser.uid)
        //.where('uid', isEqualTo: "BZ7RjuxD1XYMnlRpuFpBCizGye82")
        .where('date', isGreaterThanOrEqualTo: from)
        .where('date', isLessThanOrEqualTo: to)
        .get();
    List<Shift> list =
        qds.docs.map((doc) => Shift.fromJson(doc.data())).toList();

    return list;
  }

  Future<Map<String, DateTime>> getSchedulePeriod() async {
    var qds = await _firestore.collection("Schedule").doc("report").get();
    DateTime fromDate = (qds.data()?["from"] as Timestamp).toDate();
    DateTime toDate = (qds.data()?["to"] as Timestamp).toDate();
    Map<String, DateTime> period = {"from": fromDate, "to": toDate};
    return period;
  }

  Future<String> createOrUpdateCity(MasterCity city) async {
    //print('City Recived : $city');
    CollectionReference citiesCol = _firestore.collection("Cities");
    if (city.docId.isEmpty) {
      var doc = await citiesCol.add(city.toJson());
      return doc.id;
    } else {
      await citiesCol
          .doc(city.docId)
          .set(city.toJson(), SetOptions(merge: true));
      return city.docId;
    }
  }

  Future<void> createNewStationInCity(String name, String cityId) async {
    return await _firestore.collection("Cities").doc(cityId).update({
      "stations": FieldValue.arrayUnion([name])
    });
  }

  Future<void> migrateRates() async {
    var qds = await _firestore.collection("Rates").get();
    List<MasterCity> list =
        qds.docs.map((doc) => MasterCity.fromExistingJson(doc.data())).toList();

    var distinctCities = list.distinct((c) => c.name).toList();

    list.forEach((city) {
      int index = distinctCities.indexWhere((m) => m.name == city.name);
      distinctCities[index].stationsList.add(city.station);
    });

    distinctCities.forEach((city) async {
      await _firestore
          .collection("Cities")
          .doc(city.name)
          .update({"stations": FieldValue.arrayUnion(city.stationsList)});
    });
  }

  // Future<void> updateDisplayName() async {
  //   //await _firebaseAuth.currentUser!.updateDisplayName("Sukhwinder");
  //   //String name = _firebaseAuth.currentUser?.displayName ?? "na";
  //   //print('Name null? $name');
   
  // }
}

//enum CitySetting { created, updated, failed }

enum DocType { SiteMap, DipChart }
