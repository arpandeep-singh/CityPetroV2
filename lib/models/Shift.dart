import 'package:CityPetro/services/firebase_service.dart';
import 'package:CityPetro/utils/extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();

class Shift {
  late DateTime date;
  late String truck;
  late String trailer;
  late String time;
  bool isOff = true;

  Shift(
      {required this.date,
      this.truck = "",
      this.trailer = "",
      this.time = "",
      this.isOff = true});

  Shift.fromJson(Map<String, dynamic> json) {
    date = (json['date'] as Timestamp).toDate();
    truck = json['truck'].toString().toUpperCase();
    trailer = json['trailer'].toString().toUpperCase();
    time = json['time'].toString().capitalize();
    isOff = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['truck'] = this.truck;
    data['trailer'] = this.trailer;
    data['time'] = this.time.toUpperCase();
    return data;
  }
}

class ScheduleReport {
  List<Shift> shifts = [];
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  Future<void> refreshData() async {
    Map<String, DateTime> period = await _firebaseService.getSchedulePeriod();
    this.fromDate = period["from"]!;
    this.toDate = period["to"]!;
    this.shifts = List.generate(toDate.difference(fromDate).inDays + 1,
        (index) => Shift(date: fromDate.add(Duration(days: index))));

    List<Shift> listFromDB =
        await _firebaseService.getSchedule(period["from"]!, period["to"]!);

    this.shifts = shifts
        .map((d) => listFromDB.firstWhere((s) => s.date.day == d.date.day, orElse: ()=>d))
        .toList();

    return;
  }
}
