import 'package:city_petro/utils/routes.dart';
import 'package:city_petro/widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class FolderListPage extends StatelessWidget {
  const FolderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Site Maps".text.make(),
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
          child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 16, crossAxisSpacing: 16),
        itemCount: 10,
        itemBuilder: (context, index) {
          // final item = GridMenuModel.items[index];
          return InkWell(
              onTap: () => Navigator.pushNamed(context, MyRoutes.filesListRoute),
              child: _FolderItem());
        },
      )).p16(),
    );
  }
}

class _FolderItem extends StatelessWidget {
  const _FolderItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
       GridTile(
        
        child: Icon(Icons.folder, size: 80, color: MyTheme.darkBluishColor,),
        footer: "Esso".text.center.make(),
      );
   
  }
}
