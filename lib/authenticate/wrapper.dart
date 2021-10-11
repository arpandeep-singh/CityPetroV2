import 'package:city_petro/authenticate/user.dart';
import 'package:city_petro/screens/dashboard.dart';
import 'package:city_petro/screens/home_page.dart';
import 'package:city_petro/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LocalUser>(context);
    print('User Name is ${user.name}');
    return user==null ? LoginPage() : Dashboard();
  }
}
