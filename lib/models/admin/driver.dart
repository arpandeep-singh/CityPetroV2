import 'package:CityPetro/utils/extensions.dart';

class Driver {
  String firstName="";
  String lastName="";
  String level="";
  String contact="";
  String email="";
  String password="";

  Driver(
      {this.firstName="",
      this.lastName="",
      this.level="",
      this.contact="",
      this.email="",
      this.password=""});

  Driver.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    level = json['level'];
    contact = json['contact'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName.capitalize();
    data['lastName'] = this.lastName.capitalize();
    data['level'] = this.level.capitalize();
    data['contact'] = this.contact.capitalize();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}