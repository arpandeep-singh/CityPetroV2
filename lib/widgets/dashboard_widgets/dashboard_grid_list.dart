import 'package:city_petro/models/catalog.dart';
import 'package:city_petro/models/grid_menu.dart';
import 'package:city_petro/screens/home_detail_page.dart';
import 'package:city_petro/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DashboardGridMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16),

      itemCount: GridMenuModel.items.length,
      itemBuilder: (context, index) {
        final item = GridMenuModel.items[index];
        return InkWell(
            onTap: () {},
            child: _GridMenuItem(
              menuItem: item,
            ));
      },
    );
  }
}


class _GridMenuItem extends StatelessWidget {
  final GridMenuItem menuItem;
  const _GridMenuItem({Key? key, required this.menuItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Card(
          color: context.cardColor,
          elevation: 0,
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
              onTap: () => Navigator.pushNamed(
            context,
            menuItem.route,
          ),
            child: GridTile(
              child: MenuItemImage(
                image: menuItem.image,
              ),
              footer: menuItem.title.text.center.make(),
            ),
          ),
        ),
    ).rounded.make();
    
  }
}

class MenuItemImage extends StatelessWidget {
  final String image;
  const MenuItemImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(image)
        .box
        .rounded
        .p32
        //.color(context.canvasColor)
        .make()
        .p16();
  }
}
