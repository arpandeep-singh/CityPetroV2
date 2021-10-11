import 'package:city_petro/models/admin/master_city.dart';
import 'package:city_petro/screens/admin-panel/all_stations.dart';
import 'package:city_petro/screens/admin-panel/new_city.dart';
import 'package:city_petro/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:velocity_x/velocity_x.dart';

class AllCitiesPage extends StatefulWidget {
  const AllCitiesPage({Key? key}) : super(key: key);

  @override
  State<AllCitiesPage> createState() => _AllCitiesPageState();
}

class _AllCitiesPageState extends State<AllCitiesPage> {
  List<MasterCity> citiesList = [];
  FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      _firebaseService.getAllCities().then((list) {
        var listData = list;
        listData.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        setState(() {
          citiesList = listData;
          loading = false;
        });
      });
    });
  }

  void showCitySettingsPage(MasterCity city) async {
    //await Future.delayed(Duration(milliseconds: 200));
    Navigator.push(
        context,
        SwipeablePageRoute(
            canSwipe: false,
            builder: (context) => CitySettingsPage(city: city)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: "All Cities".text.make(),
          actions: [
            IconButton(
                onPressed: () => showCitySettingsPage(new MasterCity()),
                icon: Icon(Icons.add))
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              CupertinoSearchTextField(
                borderRadius: BorderRadius.circular(0),
                //controller: controller,
              ).p12(),
              loading
                  ? CupertinoActivityIndicator().expand()
                  : citiesList.isEmpty
                      ? "No Data".text.make()
                      : ListView.builder(
                          //separatorBuilder: (context, int)=>Divider(height: 0,),
                          itemCount: citiesList.length,
                          itemBuilder: (context, index) {
                            return buildCity(
                              citiesList[index],
                            );
                          }).expand(),
            ],
          ),
        ));
  }

  void showDeleteDialog(MasterCity city) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text("AlertDialog"),
          content: Text(
            "Are you sure you want to delete this city ?",
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              child: Text("Continue"),
              onPressed: () async {
                deleteCity(city);
              },
            ),
          ],
        );
      },
    );
  }

  void deleteCity(MasterCity city) async {
    context.pop();
    await _firebaseService.deleteSingleCity(city.docId);
    citiesList.remove(city);
    setState(() => {});
    showMessage("Deleted Successfully", Colors.green);
  }

  void showMessage(String message, MaterialColor color) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(message),
      duration: Duration(milliseconds: 800),
    ));
  }

  Widget buildCity(MasterCity city) => Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.2,
        child: GestureDetector(
          //onLongPress: () => showCitySettingsPage(city),
          onTap: () {
            Navigator.push(
                context,
                SwipeablePageRoute(
                    canSwipe: false,
                    builder: (context) => AllStationsPage(
                          cityId: city.docId,
                        )));
          },
          child: VxBox(
            child: VStack([
              HStack(
                [
                  city.name.text.make().pOnly(bottom: 5),
                ],
                alignment: MainAxisAlignment.spaceBetween,
              ),
              Row(
                children: [
                  "L1".text.sm.make(),
                  SizedBox(
                    width: 5,
                  ),
                  VxBox(child: city.rT1.text.sm.make().px(10))
                      .make()
                      .backgroundColor(Color(0xB78A0A).withOpacity(0.2))
                      .cornerRadius(5),
                  SizedBox(
                    width: 5,
                  ),
                  VxBox(child: city.rO1.text.sm.make().px(10))
                      .make()
                      .backgroundColor(Color(0xB78A0A).withOpacity(0.2))
                      .cornerRadius(5),
                  SizedBox(
                    width: 5,
                  ),
                  VxBox(child: city.rH1.text.sm.make().px(10))
                      .make()
                      .backgroundColor(Color(0xB78A0A).withOpacity(0.2))
                      .cornerRadius(5),
                  SizedBox(
                    width: 5,
                  ),
                  VxBox(child: city.rN1.text.sm.make().px(10))
                      .make()
                      .backgroundColor(Color(0xB78A0A).withOpacity(0.2))
                      .cornerRadius(5),
                ],
              ),
              Row(
                children: [
                  "L2".text.sm.make(),
                  SizedBox(
                    width: 5,
                  ),
                  VxBox(child: city.rT2.text.sm.make().px(10))
                      .make()
                      .backgroundColor(Color(0xB78A0A).withOpacity(0.2))
                      .cornerRadius(5),
                  SizedBox(
                    width: 5,
                  ),
                  VxBox(child: city.rO2.text.sm.make().px(10))
                      .make()
                      .backgroundColor(Color(0xB78A0A).withOpacity(0.2))
                      .cornerRadius(5),
                  SizedBox(
                    width: 5,
                  ),
                  VxBox(child: city.rH2.text.sm.make().px(10))
                      .make()
                      .backgroundColor(Color(0xB78A0A).withOpacity(0.2))
                      .cornerRadius(5),
                  SizedBox(
                    width: 5,
                  ),
                  VxBox(child: city.rN2.text.sm.make().px(10))
                      .make()
                      .backgroundColor(Color(0xB78A0A).withOpacity(0.2))
                      .cornerRadius(5),
                ],
              ).py(5),
            ]).p(10),
          ).color(context.cardColor).make().cornerRadius(5).p(2).px(10),
        ),
        // actions: [
        //   IconSlideAction(
        //       caption: 'Edit',
        //       color: Colors.yellow[600],
        //       icon: Icons.edit,
        //       onTap: () => showCitySettingsPage(city))
        // ],
        secondaryActions: [
          IconSlideAction(
              caption: 'Edit',
              color: Colors.yellow[600],
              icon: Icons.edit,
              onTap: () => showCitySettingsPage(city)),
          IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => showDeleteDialog(city)),
        ],
      );
}
