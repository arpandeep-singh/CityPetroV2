import 'package:CityPetro/models/Station.dart';
import 'package:CityPetro/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:velocity_x/velocity_x.dart';

class AllStationsPage extends StatefulWidget {
  final String cityId;
  const AllStationsPage({Key? key, required this.cityId}) : super(key: key);

  @override
  State<AllStationsPage> createState() => _AllStationsPageState();
}

class _AllStationsPageState extends State<AllStationsPage> {
  List<Station> stationsList = [];

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
      _firebaseService.getAllStationsInCity(widget.cityId).then((list) {
        var listData = list;
        listData.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        setState(() {
          stationsList = listData;
          loading = false;
        });
      });
    });
  }

  void showDeleteDialog(Station station) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text("AlertDialog"),
          content: Text(
            "Are you sure you want to delete this station ?",
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
                deleteStation(station);
              },
            ),
          ],
        );
      },
    );
  }

  void deleteStation(Station station) async {
    context.pop();
    await _firebaseService.deleteSingleStation(this.widget.cityId, station.name);
    stationsList.remove(station);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: "All Stations".text.textStyle(TextStyle(fontSize: 16)).make(),
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
                  : stationsList.isEmpty
                      ? "No Data".text.make()
                      : ListView.builder(
                          //separatorBuilder: (context, int)=>Divider(height: 0,),
                          itemCount: stationsList.length,
                          itemBuilder: (context, index) {
                            return buildStationItem(stationsList[index]);
                          }).expand(),
            ],
          ),
        ));
  }

  Widget buildStationItem(Station station) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      child: 
      VxBox(
        child: VStack([
          HStack(
            [
              '${station.name}'.text.make().pOnly(bottom: 5),
            ],
            alignment: MainAxisAlignment.start,
            axisSize: MainAxisSize.max,
          ),
          
          
        ]).p(10),
      ).color(context.cardColor).make().cornerRadius(5).p(2).px(10),
      secondaryActions: [
        IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => showDeleteDialog(station)),
      ],
    );
  }
}
