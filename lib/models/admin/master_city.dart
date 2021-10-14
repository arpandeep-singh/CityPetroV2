import 'package:CityPetro/utils/extensions.dart';

class MasterCity {
  String name = "";
  int rT1 = 0;
  int rO1 = 0;
  int rH1 = 0;
  int rN1 = 0;
  int rT2 = 0;
  int rO2 = 0;
  int rH2 = 0;
  int rN2 = 0;

  //for firebase use only : update city
  String docId = "";

  //For migration
  List<String> stationsList = [];
  String station = "";

  MasterCity(
      {this.name = "",
      this.rT1 = 0,
      this.rO1 = 0,
      this.rH1 = 0,
      this.rN1 = 0,
      this.rT2 = 0,
      this.rO2 = 0,
      this.rH2 = 0,
      this.rN2 = 0});

  MasterCity.fromJson(Map<String, dynamic> json, String id) {
    docId = id;
    name = json['name'].toString().capitalize();
    rT1 = int.parse(json['1']['rateToronto']?.toString() ?? "0");
    rO1 = int.parse(json['1']['rateOakville']?.toString() ?? "0");
    rH1 = int.parse(json['1']['rateHamilton']?.toString() ?? "0");
    rN1 = int.parse(json['1']['rateNanticoke']?.toString() ?? "0");
    rT2 = int.parse(json['2']['rateToronto']?.toString() ?? "0");
    rO2 = int.parse(json['2']['rateOakville']?.toString() ?? "0");
    rH2 = int.parse(json['2']['rateHamilton']?.toString() ?? "0");
    rN2 = int.parse(json['2']['rateNanticoke']?.toString() ?? "0");
  }

  MasterCity.fromExistingJson(Map<String, dynamic> json) {
    name = json['city'] !=null? json['city'].toString().trim().toLowerCase().capitalize() :"";
    rT1 = int.parse(json['rateToronto'] ?? "0");
    rO1 = int.parse(json['rateOakville'] ?? "0");
    rH1 = int.parse(json['rateHamilton'] ?? "0");
    rN1 = int.parse(json['rateNanticoke'] ?? "0");
    rT2 = rT1;
    rO2 = rO1;
    rH2 = rH1;
    rN2 = rN1;
    station = json['stationID']!.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name.capitalize();
    data['1'] = {
      "rateToronto": this.rT1,
      "rateOakville": this.rO1,
      "rateHamilton": this.rH1,
      "rateNanticoke": this.rN1
    };
    data['2'] = {
      "rateToronto": this.rT2,
      "rateOakville": this.rO2,
      "rateHamilton": this.rH2,
      "rateNanticoke": this.rN2
    };
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$name $rT1 $rO1 $rH1 $rT2 $rO2 $rH2 $rN2';
  }
}
