import 'package:city_petro/core/store.dart';
import 'package:city_petro/screens/add_load_page.dart';
import 'package:city_petro/screens/all_users_page.dart';
import 'package:city_petro/screens/cart_page.dart';
import 'package:city_petro/screens/create_user.dart';
import 'package:city_petro/screens/dashboard.dart';
import 'package:city_petro/screens/files_list.dart';
import 'package:city_petro/screens/folder_list.dart';
import 'package:city_petro/screens/home_page.dart';
import 'package:city_petro/screens/load_detail_page.dart';
import 'package:city_petro/screens/login_screen.dart';
import 'package:city_petro/screens/reports_page.dart';
import 'package:city_petro/screens/schedule_page.dart';
import 'package:city_petro/utils/routes.dart';
import 'package:city_petro/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(VxState(store: MyStore(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City Petro',
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      initialRoute: MyRoutes.dashboardRoute,
      debugShowCheckedModeBanner: false,
      routes: {
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.cartRoute: (context) => CartPage(),
        MyRoutes.dashboardRoute: (context) => Dashboard(),
        MyRoutes.filesListRoute: (context) => FilesListPage(),
        MyRoutes.folderListRoute: (context) => FolderListPage(),
        MyRoutes.addLoadRoute: (context) => AddLoad(),
        MyRoutes.reportsRoute: (context) => ReportsPage(),
        MyRoutes.scheduleRoute: (context) => SchedulePage(),
        MyRoutes.allUsersRoute: (context) => AllUsersPage(),
        MyRoutes.createUser: (context) => CreateUserPage(),
        MyRoutes.loadDetailRoute: (context) => LoadDetailPage(),
      },
    );
  }
}
