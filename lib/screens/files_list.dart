import 'package:city_petro/models/Folder.dart';
import 'package:city_petro/models/PdfDoc.dart';
import 'package:city_petro/screens/load_detail_page.dart';
import 'package:city_petro/screens/pdf_view_page.dart';
import 'package:city_petro/services/firebase_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:velocity_x/velocity_x.dart';

class FilesListPage extends StatefulWidget {
  final String folder;
  final String type;
  const FilesListPage({Key? key, required this.folder, required this.type})
      : super(key: key);

  @override
  _FilesListPageState createState() => _FilesListPageState();
}

class _FilesListPageState extends State<FilesListPage> {
  TextEditingController controller = new TextEditingController();
  FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  List<PdfDoc> files = [];
  bool loading = true;
  String filter ="";

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
    _firebaseService.getFiles(widget.folder, widget.type).then((results) {
      Future.delayed(Duration(milliseconds: 250)).then((value) => {
            setState(() {
              files = results;
              loading = false;
            })
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.folder.text.make(),
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: Column(
          children: [
            CupertinoSearchTextField(
              borderRadius: BorderRadius.circular(0),
               controller: controller,
            ).p12(),
            loading
                ? CupertinoActivityIndicator().expand()
                : files.isEmpty
                    ? "No Files".text.make()
                    : ListView.separated(
                      physics: BouncingScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                              height: 5,
                            ),
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                          return _buildFile(index);}).expand(),
          ],
        ),
      ),
    );
  }

  Widget _buildFile(int index){
    var file = files[index];
    return file.name.toLowerCase().contains(filter.toLowerCase()) ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  SwipeablePageRoute(
                                     canSwipe: false,
                                      builder: (context) => PdfViewerPage(
                                            doc: file,
                                          )));
                            },
                            child: VxBox(
                              child: ListTile(
                                //leading: Image.asset("assets/images/pdf.png"),
                                leading: Icon(
                                  Icons.picture_as_pdf,
                                  color: Colors.red,
                                ),
                                title: file.name.text
                                    .textStyle(TextStyle(fontSize: 12))
                                    .make(),
                                //subtitle: "Brampton".text.make(),
                                //trailing: CupertinoActivityIndicator().px12(),
                              ),
                            ).color(context.cardColor).make().cornerRadius(5).px(10),
                          ): new Container();
  }
}
