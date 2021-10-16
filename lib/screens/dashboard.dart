import 'package:CityPetro/authenticate/user.dart';
import 'package:CityPetro/main.dart';
import 'package:CityPetro/services/firebase_service.dart';
import 'package:CityPetro/widgets/dashboard_widgets/dashboard_grid_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:velocity_x/velocity_x.dart';

class Dashboard extends StatefulWidget {
  //final bool isAdmin;
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();

  @override
  void initState() {
    super.initState();
    //loadData();
  }

  void handleLogOut() async => _firebaseService.signOut();

  @override
  Widget build(BuildContext context) {
    final LocalUser user = _firebaseService.myAppUser;

    Widget _header() {
      return Column(
        children: [
          'Hello, ${user.getFirstName()}!'.text.xl4.bold.gray100.make()
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            "City Petro".text.make(),
            VxBox().width(5).make(),
            'v${Startup.instance.localVersion}'.text.sm.make()
          ],
        ),
        actions: [
          IconButton(onPressed: handleLogOut, icon: Icon(Icons.logout)),
        ],
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
          child: ZStack([
        VxBox().color(context.accentColor).make().h20(context),
        Container(
          //padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_header(), DashboardGridMenu().py16().expand()],
          ),
        ).px20(),
      ])),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // await _firebaseService.migrateRates();
      //     await _firebaseService.updateDisplayName();
      //   },
      // ),
    );
  }
}
