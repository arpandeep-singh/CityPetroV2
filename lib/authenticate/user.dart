import 'package:firebase_auth/firebase_auth.dart';

class LocalUser {
  final String uid;
  final String name;
  LocalUser({required this.uid, required this.name});

  factory LocalUser.fromFireBaseUser(User user) {
    return LocalUser(uid: user.uid, name: user.displayName??"");
  }

  factory LocalUser.emptyUser() {
    return LocalUser(uid: "", name: "");
  }
  String getFirstName() => name.toString().split('#')[0];
  String getLastName() => name.toString().split('#')[1];
  String getLevel() => name.toString().split('#')[2];
}
