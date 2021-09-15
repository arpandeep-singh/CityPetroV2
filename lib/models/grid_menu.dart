import 'dart:convert';

import 'package:city_petro/utils/routes.dart';

class GridMenuModel {
  static final catModel = GridMenuModel._internal();

  GridMenuModel._internal();

  factory GridMenuModel() => catModel;

  static List<GridMenuItem> items = [
    GridMenuItem(
      id: 1,
      title: "Site Maps",
      image: "assets/images/site-maps.png",
      route: MyRoutes.folderListRoute,
    ),
    GridMenuItem(
      id: 2,
      title: "Dip Charts",
      image: "assets/images/dip-charts.png",
      route: MyRoutes.folderListRoute,
    ),
    GridMenuItem(
      id: 3,
      title: "Add Load",
      image: "assets/images/addLoad.png",
      route: MyRoutes.addLoadRoute,
    ),
    GridMenuItem(
      id: 4,
      title: "Reports",
      image: "assets/images/reports.png",
      route: MyRoutes.reportsRoute,
    ),
    GridMenuItem(
      id: 5,
      title: "Invoices",
      image: "assets/images/invoices.png",
      route: MyRoutes.filesListRoute,
    ),
    GridMenuItem(
      id: 6,
      title: "Schedule",
      image: "assets/images/schedule.png",
      route: MyRoutes.scheduleRoute
    ),
     GridMenuItem(
      id: 7,
      title: "All Users",
      image: "assets/images/schedule.png",
      route: MyRoutes.allUsersRoute
    ),
    GridMenuItem(
      id: 8,
      title: "Create User",
      image: "assets/images/schedule.png",
      route: MyRoutes.createUser
    ),
    GridMenuItem(
      id: 9,
      title: "Load Deatil",
      image: "assets/images/schedule.png",
      route: MyRoutes.loadDetailRoute
    )
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
  final String route;

  GridMenuItem(
      {required this.id,
      required this.title,
      required this.image,
      required this.route});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'route': route,
    };
  }

  factory GridMenuItem.fromMap(Map<String, dynamic> map) {
    return GridMenuItem(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      route: map['route'],
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
