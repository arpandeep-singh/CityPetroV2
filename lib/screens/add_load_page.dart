import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AddLoad extends StatelessWidget {
  const AddLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Add Load".text.make(),
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SectionOne(),
              VxBox().make().h(10),
              SectionTwo(),
              VxBox().make().h(10),
              SectionThree()
            ],
          ).px12().pOnly(top: 12),
        ),
      ),
    );
  }
}

class SectionOne extends StatelessWidget {
  const SectionOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "STATION ".text.xl.make(),
                Container(
                  child: Material(
                    child: InkWell(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.arrow_drop_down),
                          "SELECT".text.xl.bold.color(Colors.grey[700]!).make()
                        ],
                      ),
                      onTap: () {
                        // SelectDialog.showModal<
                        //     Site>(
                        //   context,
                        //   label:
                        //       "Select Station",
                        //   titleStyle: TextStyle(
                        //       color:
                        //           Colors.black),
                        //   showSearchBox: true,
                        //   searchBoxDecoration:
                        //       InputDecoration(
                        //     hintText: 'Search',
                        //     prefixIcon: Icon(
                        //         Icons.search),
                        //   ),
                        //   backgroundColor:
                        //       Colors.white,
                        //   items: sites,
                        //   onChange:
                        //       (Site selected) {
                        //     setState(() {
                        //       load.stationID =
                        //           selected
                        //               .stationID;
                        //       load.city =
                        //           selected.city;
                        //       rateToronto =
                        //           selected
                        //               .rateToronto;
                        //       rateOakville =
                        //           selected
                        //               .rateOakville;
                        //       rateHamilton =
                        //           selected
                        //               .rateHamilton;
                        //       rateNanticoke =
                        //           selected
                        //               .rateNanticoke;
                        //       load.splits = 0;
                        //       load.rate =
                        //           rateToronto;
                        //       rate = selected
                        //           .rateToronto;
                        //       load.terminal =
                        //           'Toronto';
                        //     });
                        //   },
                        // );
                      },
                    ),
                  ),
                ),
              ],
            ),
            VxBox().make().h(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ["CITY ".text.xl.make(), "RATE".text.xl.make()],
            ),
            //VxBox().make().h(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Brampton ".text.xl.bold.color(Colors.grey[700]!).make(),
                "\$135".text.xl.bold.color(Colors.grey[700]!).make()
              ],
            ),
            VxBox().make().h(10),
            Column(
              children: [
                "TERMINAL ".text.xl.make(),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                    child: HStack([
                  new Radio(
                    value: 0,
                    groupValue: 0,
                    onChanged: (int? value) {},
                  ),
                  "TORONTO".text.xl.color(Colors.grey[600]!).make(),
                ])).expand(),
                Container(
                    child: HStack([
                  new Radio(
                    value: 0,
                    groupValue: 0,
                    onChanged: (int? value) {},
                  ),
                  "OAKVILLE".text.xl.color(Colors.grey[600]!).make(),
                ])).expand(),
              ],
            ),
               Row(
              children: <Widget>[
                Container(
                    child: HStack([
                  new Radio(
                    value: 0,
                    groupValue: 0,
                    onChanged: (int? value) {},
                  ),
                  "HAMILTON".text.xl.color(Colors.grey[600]!).make(),
                ])).expand(),
                Container(
                    child: HStack([
                  new Radio(
                    value: 0,
                    groupValue: 0,
                    onChanged: (int? value) {},
                  ),
                  "NANTICOKE".text.xl.color(Colors.grey[600]!).make(),
                ])).expand(),
              ],
            ),
            VxBox().make().h(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VxBox(
                    child: HStack([
                  "SPLIT LOADS".text.xl.make(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_circle,
                        color: Colors.green,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.remove_circle,
                        color: Colors.green,
                      ))
                ])).make(),
                "1".text.xl.make(),
              ],
            )
          ],
        ).p20(),
      ).px12(),
    ).color(context.cardColor).make();
  }
}

class SectionTwo extends StatelessWidget {
  const SectionTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "DATE ".text.make(),
                Material(
                    child: InkWell(
                            child: "JUL 24, 2021"
                                .text
                                .xl
                                .bold
                                .color(Colors.grey[700]!)
                                .make(),
                            onTap: () {})
                        .px12())
              ],
            ),
            VxBox().make().h(10),
            "TRUCK NUMBER".text.make(),
            Container(
              color: Colors.grey[200],
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0xff1b66a9),
                ),
              ),
            )
          ],
        ).p20(),
      ).px12(),
    ).color(context.cardColor).make();
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
            "WAITING".text.make(),
            Container(
              color: Colors.grey[200],
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
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
            "COMMENTS".text.make(),
            Container(
              color: Colors.grey[200],
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
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
            "UPT LINK".text.make(),
            Container(
              color: Colors.grey[200],
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0xff1b66a9),
                ),
              ),
            ),
            VxBox().make().h(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Material(
                    child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.attach_file),
                              // documents.isEmpty
                              //     ?
                              Text('SELECT IMAGE(S)')
                              //: Text('SELECT MORE'),
                            ],
                          ),
                        ),
                        onTap: () => openBottomSheet(context)),
                    color: Colors.grey[200],
                  ),
                ),
                // documents.isEmpty
                //     ?
                Text('0 Documents')
                // : Text('${documents.length} Document(s)')
              ],
            ),
            VxBox().make().h(25),
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

  openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camera"),
                  onTap: () => {
                        // Navigator.pop(context);
                      }),
              ListTile(
                  leading: Icon(Icons.photo),
                  title: Text("Photos"),
                  onTap: () => {
                        // Navigator.pop(context);
                      }),
              SizedBox(
                height: 40,
              )
            ],
          );
        });
  }
}
