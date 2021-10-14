import 'package:CityPetro/screens/files_list.dart';
import 'package:CityPetro/services/firebase_service.dart';
import 'package:CityPetro/widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:velocity_x/velocity_x.dart';

class FolderListPage extends StatefulWidget {
  final String type;
  const FolderListPage({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  _FolderListPageState createState() => _FolderListPageState();
}

class _FolderListPageState extends State<FolderListPage> {
  FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  List<String> folders = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    _firebaseService.getDocsFolders(widget.type).then((results) {
      Future.delayed(Duration(milliseconds: 250)).then((value) => {
            setState(() {
              folders = results;
              loading = false;
            })
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.type.text .textStyle(TextStyle(fontSize: 16)).make(),
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
              child: loading
                  ? Container(
                    alignment: Alignment.center,
                    child: CupertinoActivityIndicator())
                  : folders.length==0?"No Data".text.make(): GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16),
                      itemCount: folders.length,
                      itemBuilder: (context, index) {
                        // final item = GridMenuModel.items[index];
                        return InkWell(
                            onTap: () => Navigator.push(
                                  context,
                                  SwipeablePageRoute(
                                    canSwipe: false,
                                      builder: (context) => FilesListPage(folder: folders[index], type: widget.type,)),
                                ),
                            child: _FolderItem(title: folders[index]));
                      },
                    ))
          .p16(),
    );
  }
}

class _FolderItem extends StatelessWidget {
  final String title;
  const _FolderItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Icon(
        Icons.folder,
        size: 80,
        color: MyTheme.darkBluishColor,
      ),
      footer: title.text .textStyle(TextStyle(fontSize: 12)).center.make(),
    );
  }
}
