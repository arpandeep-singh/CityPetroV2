import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = "https://images.pod.co/ZDzAoaBXKTOdLDQag3Gx5embmzfTxlaAX58hJRoT2XM/resize:fill:1400:1400/plain/artwork/c6955bc1-1350-4910-9c60-82d96cc07e77/britasiapodcast-celebrity-interviews/interview-with-sidhu-moosewala.jpg";
    return Drawer(
      child: Container(
        color: Colors.deepPurple,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  accountName: Text("Arpan Singh"),
                  accountEmail: Text("arpan@gmail.com"),
                  currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage(imageUrl),),
                )),
                ListTile(leading: Icon(CupertinoIcons.home, color: Colors.white,),title: Text("Home", style: TextStyle(color: Colors.white),)),
                 ListTile(leading: Icon(CupertinoIcons.home, color: Colors.white,),title: Text("Home", style: TextStyle(color: Colors.white),)),
          ],
        ),
      ),
    );
  }
}
