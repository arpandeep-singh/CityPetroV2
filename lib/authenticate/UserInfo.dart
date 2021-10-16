import 'package:CityPetro/services/firebase_service.dart';
import 'package:CityPetro/utils/extensions.dart';
import 'package:get_it/get_it.dart';

FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();

class UserInfo {
  String firstName = "";
  String lastName = "";
  String email = "";
  String contact = "";
  String password = "";
  String level = "1";
  String get displayName => '$firstName $lastName';
  String uid = "";
  bool isAdmin = false;

  UserInfo({
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.contact = "",
    this.password = "",
    this.level = "1",
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName.capitalize().trim();
    data['lastName'] = this.lastName.capitalize().trim();
    data['email'] = this.email.trim();
    data['contact'] = this.contact.trim();
    data['password'] = this.getPassword().trim();
    data['level'] = this.level;
    return data;
  }

  UserInfo.fromJson(Map<String, dynamic> json, String userId) {
    firstName = json['firstName'] ?? "N.A";
    lastName = json['lastName'] ?? "N.A";
    level = json['level'] ?? "default 1";
    contact = json['contact'] ?? "N.A";
    email = json['email'] ?? "N.A";
    password = json['password'] ?? "";
    uid = userId;
    isAdmin = json['isAdmin'] ?? false;
  }

  Future<String> createUser() async {
    return await _firebaseService.createNewUser(this);
  }

  String getPassword() {
    String password = "";
    if (firstName.length > 2 && contact.length > 4) {
      String fromFname =
          this.firstName.isNotEmpty ? this.firstName.substring(0, 2) : "";
      String fromPh = this.contact.isNotEmpty
          ? this.contact.substring(contact.length - 4)
          : "";
      password = '$fromFname$fromPh';
    }

    //print('Password is $password');
    return password;
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
