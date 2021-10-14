import 'package:CityPetro/screens/admin-panel/all_cities.dart';
import 'package:CityPetro/screens/create_user.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Admin Panel".text.make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AdminPanelItem(
              title: "Manage Cities",
              icon: Icons.location_city,
              screen: AllCitiesPage(),
            ),
            AdminPanelItem(
              title: "Create a new User",
              icon: Icons.person_add,
              screen: CreateUserPage(),
            ),
            AdminPanelItem(
              title: "View Schedule",
              icon: Icons.schedule,
              screen: AllCitiesPage(),
            ),
            AdminPanelItem(
              title: "On-Hold Loads",
              icon: Icons.warning_amber,
              screen: AllCitiesPage(),
            )
          ],
        ).py(10),
      ),
    );
  }
}

class AdminPanelItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget screen;
  const AdminPanelItem(
      {Key? key, required this.title, required this.screen, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: ListTile(
        leading: Icon(this.icon,color: context.accentColor),
        title: title.text.textStyle(TextStyle(fontSize: 12)).make(),
        onTap: () {Navigator.push(context,SwipeablePageRoute(canSwipe: false, builder: (context) => this.screen));},
      ),
    ).color(context.cardColor).make().cornerRadius(5).px(15).py(5);
  }
}
