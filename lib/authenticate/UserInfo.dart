import 'package:CityPetro/services/firebase_service.dart';
import 'package:get_it/get_it.dart';

FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();

class UserInfo {
  String firstName;
  String lastName;
  String email;
  String contact;
  String password;
  String level;

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
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['password'] = this.password;
    data['level'] = this.level;
    return data;
  }

  Future<String> createUser() async {
    return await _firebaseService.createNewUser(this);
  }

  String getPassword() {
    String fromFname = this.firstName.isNotEmpty ?this.firstName.substring(0, 3):"";
    String fromPh = this.contact.isNotEmpty? this.contact.substring(6, 9):"";
    
    return '$fromFname$fromPh';
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
