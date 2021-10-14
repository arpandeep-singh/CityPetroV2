import 'package:CityPetro/models/Site.dart';
import 'package:CityPetro/utils/extensions.dart';

class City {
  String name;
  List<String> stations=[];
  int rateToronto;
  int rateOakville;
  int rateNanticoke;
  int rateHamilton;

  City(
      {required this.name,
      required this.stations,
      required this.rateToronto,
      required this.rateOakville,
      required this.rateNanticoke,
      required this.rateHamilton});

  factory City.fromJson(Map<String, dynamic> json, String level) {
    return City(
        name: json['name'].toString().capitalize(),
        stations: json['stations']!=null?List.castFrom(json['stations'] as List ):[],
        rateToronto: int.parse(json[level]['rateToronto'].toString()),
        rateOakville: int.parse(json[level]['rateOakville'].toString()),
        rateNanticoke: int.parse(json[level]['rateNanticoke'].toString()),
        rateHamilton: int.parse(json[level]['rateHamilton'].toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name.capitalize();
    data['stations'] = this.stations.map((v) => v.toString()).toList();
    data['rateToronto'] = this.rateToronto;
    data['rateOakville'] = this.rateOakville;
    data['rateNanticoke'] = this.rateNanticoke;
    data['rateHamilton'] = this.rateHamilton;
    return data;
  }

  @override
  String toString() {
    return 'Name: $name ,StationsList: ${stations.length} rateT: $rateToronto';
  }
}
