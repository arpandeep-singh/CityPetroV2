import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Create a new user".text.make(),
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [SectionThree()],
          ).p12(),
        ),
      ),
    );
  }
}

class SectionThree extends StatelessWidget {
  const SectionThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              VxBox(child: VStack([
                  "FIRST NAME".text.make(),
                   Container(
              color: Colors.grey[200],
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0xff1b66a9),
                ),
              ),
            )
                ]),).make().expand(),
               VxBox().make().w(10),
                VxBox(child: VStack([
                  "LAST NAME".text.make(),
                   Container(
              color: Colors.grey[200],
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0xff1b66a9),
                ),
              ),
            )
                ]),).make().expand(),
            ],),
            VxBox().make().h(10),
            "EMAIL".text.make(),
            Container(
              color: Colors.grey[200],
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0xff1b66a9),
                ),
              ),
            ),
            VxBox().make().h(10),
            "CONTACT".text.make(),
            Container(
              color: Colors.grey[200],
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0xff1b66a9),
                ),
              ),
            ),
            VxBox().make().h(10),
            "PASSWORD".text.make(),
            Container(
              color: Colors.grey[200],
              child: TextFormField(
                initialValue: "JAL9879",
                enabled: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0xff1b66a9),
                ),
              ),
            ),
            VxBox().make().h(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "LEVEL".text.make(),
                DropdownButton<String>(
                  value: "1",
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: context.accentColor,
                  ),
                  onChanged: (String? newValue) {},
                  items: <String>['1', '2', '3', '4']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            VxBox().make().h(15),
            CupertinoButton.filled(
                    pressedOpacity: 0.8,
                    borderRadius: BorderRadius.circular(0),
                    child: "SUBMIT".text.make(),
                    onPressed: () async {})
                .wFull(context)
          ],
        ).p20(),
      ).px12(),
    ).color(context.cardColor).make();
  }
}
