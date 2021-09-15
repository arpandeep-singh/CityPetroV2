import 'package:city_petro/models/cart.dart';
import 'package:city_petro/models/catalog.dart';
import 'package:city_petro/models/grid_menu.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStore extends VxStore {
  CatalogModel? catalog;
  CartModel? cart;
  GridMenuModel? gridMenu;

  MyStore() {
    catalog = CatalogModel();
    cart = CartModel();
    cart!.catalog = catalog!;
    gridMenu = GridMenuModel();
  }
}
