import 'dart:convert';
import 'package:city_petro/models/Load.dart';
import 'package:city_petro/screens/add_load_page.dart';
import 'package:city_petro/screens/admin_panel_screen.dart';
import 'package:city_petro/screens/files_list.dart';
import 'package:city_petro/screens/folder_list.dart';
import 'package:city_petro/screens/reports_page.dart';
import 'package:city_petro/screens/schedule_page.dart';
import 'package:city_petro/screens/schedule_view.dart';
import 'package:flutter/material.dart';

class GridMenuModel {
  static final catModel = GridMenuModel._internal();

  GridMenuModel._internal();

  factory GridMenuModel() => catModel;

  static List<GridMenuItem> items = [
    GridMenuItem(
      id: 1,
      title: "Add Load",
      image: "assets/images/addLoad.png",
      screen: AddLoad(load:new Load(date: DateTime.now())),
    ),
    GridMenuItem(
        id: 2,
        title: "Reports",
        image: "assets/images/reports.png",
        screen: ReportsPage()),
    GridMenuItem(
      id: 3,
      title: "SiteMaps",
      image: "assets/images/site-maps.png",
      screen: FolderListPage(type: "SiteMaps"),
      // route: MyRoutes.folderListRoute,
    ),
    GridMenuItem(
        id: 4,
        title: "DipCharts",
        image: "assets/images/dip-charts.png",
        screen: FolderListPage(
          type: "DipCharts",
        )),
    GridMenuItem(
        id: 5,
        title: "Schedule",
        image: "assets/images/schedule.png",
        screen: SchedulePage()),
    GridMenuItem(
        id: 6,
        title: "Invoices",
        image: "assets/images/invoice.png",
        screen: FilesListPage(folder: "Invoices", type: "Invoices")),
    GridMenuItem(
        id: 7,
        title: "Admin Panel",
        image: "assets/images/server.png",
        screen: AdminPanel()),
  ];

  // Get Item by ID
  GridMenuItem getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  GridMenuItem getByPosition(int pos) => items[pos];
}

class GridMenuItem {
  final int id;
  final String title;
  final String image;
  //final String route;
  final Widget screen;

  GridMenuItem(
      {required this.id,
      required this.title,
      required this.image,
      required this.screen});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'screen': screen,
    };
  }

  factory GridMenuItem.fromMap(Map<String, dynamic> map) {
    return GridMenuItem(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      screen: map['screen'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GridMenuItem.fromJson(String source) =>
      GridMenuItem.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GridMenuItem &&
        other.id == id &&
        other.title == title &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ image.hashCode;
  }
}
