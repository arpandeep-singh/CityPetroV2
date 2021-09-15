import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class FilesListPage extends StatelessWidget {
  const FilesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Site Maps".text.make(),
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
                      leading: Image.asset("assets/images/pdf.png"),
                      title: "1067".text.make(),
                      subtitle: "Brampton".text.make(),
                      // trailing: CupertinoActivityIndicator().px12(),
                    ),
                  ).color(context.cardColor).make();
                }).expand(),
          ],
        ),
      ),
    );
  }
}
