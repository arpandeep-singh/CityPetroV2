import 'package:CityPetro/core/store.dart';
import 'package:CityPetro/screens/create_user.dart';
import 'package:CityPetro/screens/dashboard.dart';
import 'package:CityPetro/screens/login_screen.dart';
import 'package:CityPetro/screens/schedule_page.dart';
import 'package:CityPetro/services/firebase_service.dart';
import 'package:CityPetro/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:velocity_x/velocity_x.dart';
import 'widgets/themes.dart';

GetIt locator = GetIt.instance;

void setupSingletons() async {
  locator.registerLazySingleton<FirebaseService>(() => FirebaseService());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupSingletons();
  runApp(VxState(store: MyStore(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              themeMode: ThemeMode.light,
              theme: MyTheme.lightTheme(context),
              debugShowCheckedModeBanner: false,
              home: Splash());
        } else if (snapshot.connectionState == ConnectionState.done) {
          FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();

          return MaterialApp(
            themeMode: ThemeMode.light,
            theme: MyTheme.lightTheme(context),
            debugShowCheckedModeBanner: false,
            home: StreamBuilder<User?>(
              stream: _firebaseService.authStateChanges(),
              builder: (_, _snapshot) {
                bool isSignedIn = _snapshot.data != null;
               
                // bool isAdmin = false;
                // if (isSignedIn) {
                //   isAdmin = _firebaseService.isUserExist;
                // }

                return FutureBuilder(
                    future: Startup.instance.checkUserAdmin(isSignedIn),
                    builder: (context, AsyncSnapshot<void> ss) {
                      //bool isAdmin = ss.data != null ? ss.data! : false;
                      //bool userExist = ss.data!=null? ss.data :false;
                      if (ss.connectionState == ConnectionState.waiting) {
                        return Splash();
                      } else {
                        return isSignedIn ? Dashboard() : LoginPage();
                      }
                    });
              },
            ),
            routes: {
              //MyRoutes.dashboardRoute: (context) => Dashboard(isAdmin: isAdmin),
              //MyRoutes.addLoadRoute: (context) => AddLoad(),
              MyRoutes.createUser: (context) => CreateUserPage(),
              MyRoutes.scheduleRoute: (context) => SchedulePage()
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.transparent,),
      backgroundColor: Color(0xff3366ff),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "CP",
                textScaleFactor: 9,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: context.cardColor),
              ),
              "City Petroleum Transport Inc."
                  .text
                  .xl
                  .color(context.cardColor)
                  .makeCentered(),
              VxBox().make().hOneThird(context)
            ],
          ),
        ),
      )),
    );
  }
}

class PleaseWait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.transparent,),
      backgroundColor: context.accentColor,
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "Please Wait"
                  .text
                  .xl
                  .bold
                  .color(context.cardColor)
                  .makeCentered(),
              //CircularProgressIndicator(color: Colors.white, ),
              // Container(
              //   color: Colors.white,
              //   child: CupertinoActivityIndicator().p12()
              //   ),
              VxBox().make().hOneThird(context)
            ],
          ),
        ),
      )),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();
  //FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();

  Future initialize() async {
    await Firebase.initializeApp();
    //Check if user is signed in.
    // if yes, set the flag as true and save in device
    // if not, set the flag as false and save in device

    // artificial delay
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

class Startup {
  Startup._();
  static final instance = Startup._();
  bool _isAdmin = false;
  bool get userAdmin => _isAdmin;
  set userAdmin(bool val) {
    this._isAdmin = val;
  }

  String localVersion = "";
  FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  Future<void> checkUserAdmin(bool isSignedIn) async {
    if (isSignedIn) {
      bool isAdmin = await _firebaseService.isUserAdmin;
      this.setUserAdmin = isAdmin;

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      this.localVersion = packageInfo.version;
    }

    await Future.delayed(Duration(milliseconds: 800));
  }

  bool get getUserRole => userAdmin;
  set setUserAdmin(bool isAdmin) {
    userAdmin = isAdmin;
  }
}
