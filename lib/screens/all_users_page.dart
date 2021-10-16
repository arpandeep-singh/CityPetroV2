import 'package:CityPetro/authenticate/UserInfo.dart';
import 'package:CityPetro/screens/reports_page.dart';
import 'package:CityPetro/services/firebase_service.dart';
import 'package:CityPetro/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:velocity_x/velocity_x.dart';

class AllUsersPage extends StatefulWidget {
  final String screenName;
  const AllUsersPage({Key? key, required this.screenName}) : super(key: key);

  @override
  State<AllUsersPage> createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  List<UserInfo> users = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await Future.delayed(Duration(milliseconds: 300));
    var list = await _firebaseService.getAllUsers();
    if (list.isNotEmpty) {
      setState(() {
        users = list;
      });
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: "All Users".text.textStyle(TextStyle(fontSize: 16)).make(),
          actions: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () =>
                    Navigator.of(context).pushNamed(MyRoutes.createUser)),
          ]),
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: Column(
          children: [
            CupertinoSearchTextField(
              borderRadius: BorderRadius.circular(0),
            ).p12(),
            loading
                ? CupertinoActivityIndicator().expand()
                : users.isEmpty
                    ? "No Data".text.make()
                    : ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                              height: 5,
                            ),
                        itemCount: 15,
                        itemBuilder: (context, index) {
                          UserInfo user = users[index];
                          return _userItem(context, user);
                        }).expand(),
          ],
        ),
      ),
    );
  }

  Widget _userItem(BuildContext context, UserInfo user) {
    return GestureDetector(
      onTap: () {
        print('UserId: ${user.uid}');
       // Widget screen = widget.screenName == "Reports"
           // ? ReportsPage(
                
             // )
            //: ReportsPage();
        Navigator.push(
          context,
          SwipeablePageRoute(canSwipe: false, builder: (context) => ReportsPage(userId: user.uid,)),
        );
      },
      // openDetailScreen(load),
      onLongPress: () {
        //showDeleteDialog(load);
      },
      child: VxBox(
              child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          VStack([
            user.displayName.text.textStyle(context.captionStyle!).make(),
            HStack([
              VxBox(
                      child: 'Level: ${user.level}'
                          .text
                          .textStyle(style)
                          .make()
                          .px(10))
                  .make()
                  .backgroundColor(Colors.green.withOpacity(0.2))
                  .cornerRadius(5),
                    user.isAdmin? Icon(Icons.star, color: Colors.yellow[800],).px(10):Container()
            ]),
          ]),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
          )
        ],
      ).py(10).px(20))
          .color(context.cardColor)
          .make(),
    ).cornerRadius(0).px(10);
  }
}

TextStyle get style => TextStyle(fontSize: 12);
