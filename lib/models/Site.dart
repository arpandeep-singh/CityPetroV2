import 'package:CityPetro/models/City.dart';

class Site {
  String stationID;
  String city;
  int rateT;
  int rateO;
  int rateH;
  int rateN;

  Site(
      {this.stationID="",
      this.city="",
      this.rateT=0,
      this.rateO=0,
      this.rateH=0,
      this.rateN=0});

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
        city: json["city"].toString(),
        stationID: json["stationId"].toString(),
        rateH: int.parse(json["rateHamilton"].toString()),
        rateO: int.parse(json["rateOakville"].toString()),
        rateN: int.parse(json["rateNanticoke"].toString()),
        rateT: int.parse(json["rateToronto"].toString()));
  }

  factory Site.fromCity(City city, String sid) {
    return Site(
        city: city.name,
        rateH: city.rateHamilton,
        rateN: city.rateNanticoke,
        rateO: city.rateOakville,
        rateT: city.rateToronto,
        stationID: sid);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stationID'] = this.stationID;
    data['city'] = this.city;
    data['rateT'] = this.rateT;
    data['rateO'] = this.rateO;
    data['rateH'] = this.rateH;
    data['rateN'] = this.rateN;
    return data;
  }
  @override
  String toString() {
    return '$stationID';
  }

   @override
  operator ==(o) => o is Site && (o.stationID == stationID);

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

}
