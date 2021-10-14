import 'package:CityPetro/models/Site.dart';
import 'package:CityPetro/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();

class Load {
  DateTime date = DateTime.now();
  String stationId;
  String city;
  int baseRate;
  double waitingCost;
  int waitingTime;
  double totalCostWithHST;
  //extra info
  String terminal = "";
  String uptLink = "";
  int splitLoads = 0;
  int splitCost = 0;
  String truck = "";
  String comments = "";
  int documents = 0;
  bool isOnHold = false;
  //String cpPdfLink = "";
  //Firebase use only
  String docId = "";
  double HST = 0.0;

  Load({
    required this.date,
    this.stationId = "",
    this.city = "",
    this.baseRate = -1,
    this.waitingCost = 0,
    this.waitingTime = 0,
    this.totalCostWithHST = 0.0,
  });

  // factory Load.fromJson(Map<String, dynamic> json, {String docId = ""}) {
  //   Load load = new Load(date: DateTime.now());
  //   load.date = DateTime.now();
  //   load.stationId = json['stationID'] ?? "-";
  //   load.city = json['city'] ?? "-";
  //   load.baseRate = int.parse(json['rate']?.toString() ?? "0");
  //   load.waitingCost = 10;
  //   load.splitCost = int.parse(json['splitCost']?.toString() ?? "0");
  //   load.totalCostWithHST =
  //       ((load.waitingCost + load.baseRate + load.splitCost) * 1.13);
  //   load.docId = docId;
  //   return load;
  // }

  factory Load.fromNewJson(Map<String, dynamic> json, {String docId = ""}) {
    Load load = new Load(date: DateTime.now());
    load.date = (json['date'] as Timestamp).toDate();
    load.stationId = json['stationId'] ?? "-";
    load.city = json['city'] ?? "-";
    load.baseRate = int.parse(json['baseRate']?.toString() ?? "0");
    load.waitingCost = double.parse(json['waitingCost']?.toString() ?? "0.00");
    load.splitCost = int.parse(json['splitCost']?.toString() ?? "0");
    load.HST = (((load.waitingCost + load.baseRate + load.splitCost) * 0.13));
    load.totalCostWithHST =
        ((load.waitingCost + load.baseRate + load.splitCost) + load.HST);

    load.docId = docId;
    load.isOnHold = json['isOnHold'] ?? false;
    return load;
  }

  factory Load.fromJsonFullData(Map<String, dynamic> json) {
    Load load = Load.fromNewJson(json);
    load.splitLoads = json['splitLoads'] ?? 0;
    load.documents = int.parse(json['documents']?.toString() ?? "0");
    load.uptLink = json['uptLink'] ?? "";
    load.terminal = json['terminal'] ?? "";
    load.comments = json['comments'] ?? "NA";
    load.waitingTime = int.parse(json['waitingTime']?.toString() ?? "0");
    //load.cpPdfLink = json['pdfLink'] ?? "";
    return load;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    print('WaitingCost: ${this.waitingCost}');
    data['date'] = DateTime(this.date.year, this.date.month, this.date.day);
    data['stationId'] = this.stationId;
    data['city'] = this.city;
    data['baseRate'] = this.baseRate;
    data['waitingCost'] = this.waitingCost;
    data['truck'] = this.truck.toUpperCase();
    data['terminal'] = this.terminal;
    data['uptLink'] = this.uptLink;
    data['splitLoads'] = this.splitLoads;
    data['splitCost'] = this.splitCost;
    data['comments'] = this.comments;
    data['documents'] = this.documents;
    data['waitingTime'] = this.waitingTime;
    data['userId'] = _firebaseService.myAppUser.uid;
    data['isOnHold'] = this.isOnHold;
    //data['pdfLink'] = this.cpPdfLink;
    return data;
  }

  void setup(Site site) {
    this.city = site.city;
    this.stationId = site.stationID;
    if (site.rateT != 0) {
      this.terminal = "Toronto";
      this.baseRate = site.rateT;
    } else if (site.rateO != 0) {
      this.terminal = "Oakville";
      this.baseRate = site.rateO;
    } else if (site.rateH != 0) {
      this.terminal = "Hamilton";
      this.baseRate = site.rateH;
    } else if (site.rateN != 0) {
      this.terminal = "Nanticoke";
      this.baseRate = site.rateN;
    }
  }

  bool validate() {
    return !(this.baseRate == -1 ||
        this.stationId.isEmpty ||
        this.terminal.isEmpty);
  }

  @override
  String toString() {
    return 'City: $city SID: $stationId Terminal: $terminal baseRate: $baseRate splits: $splitLoads truck: $truck date:${date.myDateFormat} wT:$waitingTime';
  }
}

const months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

const weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

extension myExt on DateTime {
  String get myDateFormat {
    // you have access to the instance in extension methods via 'this' keyword.
    return "${months[this.month - 1]} ${this.day}, ${this.year}";
  }

  String get myDateFormatWithWeekDay {
    return "${weekDays[this.weekday - 1]}, ${months[this.month - 1]} ${this.day}, ${this.year}";
  }
}

class UptResponse {
  final String remoteLink;
  final String localLink;
  final int status;

  UptResponse({this.remoteLink = "", this.localLink = "", this.status = 0});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remote'] = this.remoteLink;
    data['local'] = this.localLink;
    data['status'] = this.status;
    return data;
  }
}
