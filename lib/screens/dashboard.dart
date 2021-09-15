import 'dart:convert';

import 'package:city_petro/models/catalog.dart';
import 'package:city_petro/utils/routes.dart';
import 'package:city_petro/widgets/dashboard_widgets/dashboard_grid_list.dart';
import 'package:city_petro/widgets/home_widgets/catalog_header.dart';
import 'package:city_petro/widgets/home_widgets/catalog_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    //loadData();
  }

  // loadData() async {
  //   await Future.delayed(Duration(seconds: 1));
  //   var catalogJson = await rootBundle.loadString("assets/files/catalog.json");
  //   var decodedData = jsonDecode(catalogJson);
  //   var productsData = decodedData["products"];
  //   CatalogModel.items =
  //       List.from(productsData).map((item) => Item.fromMap(item)).toList();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.white,),
      backgroundColor: context.canvasColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          MyRoutes.folderListRoute,
        ),
        child: Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
        backgroundColor: context.theme.buttonColor,
      ),
      body: SafeArea(
        child: ZStack([
          VxBox().color(context.accentColor).make().h24(context),
          Container(
          padding: Vx.m24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHedaer(),
               DashboardGridMenu().py16().expand()
            ],
          ),
        ),
        ])
      ),
    );
  }
}
