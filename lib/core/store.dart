import 'package:CityPetro/models/cart.dart';
import 'package:CityPetro/models/catalog.dart';
import 'package:CityPetro/models/grid_menu.dart';
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
