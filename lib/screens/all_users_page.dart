import 'package:CityPetro/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "All Users".text.make(),
        actions: [ IconButton(
            icon: const Icon(Icons.add),         
            onPressed: () =>Navigator.of(context).pushNamed(MyRoutes.createUser)
          ),]
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: Column(
          children: [
            CupertinoSearchTextField(
              borderRadius: BorderRadius.circular(0),
            ).p12(),
            1==2?CupertinoActivityIndicator().expand():
            ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Divider(height: 1,),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return VxBox(            
                    child: ListTile(
                      //leading: VxBox(child: "1".text.make().px12() ).color(Color(0xffD6E4FF)).make(),
                      title: "Garry".text.make(),
                      subtitle: "Last Load: 22 Jul, 2020".text.textStyle(context.captionStyle!).make(),
                      trailing: VxBox(child: "A".text.make().px12() ).color(Color(0xffD6E4FF)).make(),
                    ),
                  ).color(context.cardColor).make();
                }).expand(),
          ],
        ),
      ),
    );
  }
}
