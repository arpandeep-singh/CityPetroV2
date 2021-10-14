import 'package:CityPetro/main.dart';
import 'package:CityPetro/models/grid_menu.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:velocity_x/velocity_x.dart';

class DashboardGridMenu extends StatelessWidget {
  final bool isAdmin = Startup.instance.getUserRole;

  //const DashboardGridMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = isAdmin ? GridMenuModel.adminItems : GridMenuModel.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 0, crossAxisSpacing: 0),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
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
          onTap: () {
            Navigator.push(
              context,
              SwipeablePageRoute(
                  canSwipe: false, builder: (context) => menuItem.screen),
            );
          },
          //     onTap: () => Navigator.pushNamed(
          //   context,
          //   menuItem.route,
          // ),
          child: GridTile(
            child: MenuItemImage(
              image: menuItem.image,
            ),
            footer: menuItem.title.text
                .textStyle(TextStyle(fontSize: 12))
                .center
                .make()
                .py12(),
          ),
        ),
      ),
    ).make();
  }
}

class MenuItemImage extends StatelessWidget {
  final String image;
  const MenuItemImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(image)
        .box
        //.rounded
        .p32
        .color(context.canvasColor)
        .make()
        .cornerRadius(10)
        .p12();
  }
}
