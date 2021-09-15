import 'package:city_petro/utils/routes.dart';
import 'package:city_petro/widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(milliseconds: 500));
      await Navigator.pushNamed(context, MyRoutes.dashboardRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Color(0xff3366ff),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                "City Petro".text.xl6.bold.color(context.cardColor).make(),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: [
                    Container(
                      color: Color(0xff254EDB),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: "Email Address",
                          //labelText: "Username",

                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          fillColor: Color(0xff1b66a9),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email cannot be empty";
                          }

                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                          setState(() {});
                        },
                      ),
                    ).py12(),
                    Container(
                      color: Color(0xff254EDB),
                      child: TextFormField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: "Password",
                          //labelText: "Username",

                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          fillColor: Color(0xff1b66a9),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value.length < 6) {
                            return "Password length should be atleast 6";
                          }

                          return null;
                        },
                      ),
                    ).py12(),
                    SizedBox(
                      height: 40.0,
                    ),
                    CupertinoButton.filled(
                      //color: Color(0xff091A7A),
                      child: "SIGN IN".text.bold.make(),
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.dashboardRoute);
                      },
                      borderRadius: BorderRadius.circular(0),
                    ).wFull(context),
                  ],
                ).p16(),
                Container(
                  //alignment: Alignment.bottomCenter,
                  child: "v1.0.5".text.color(context.cardColor).make(),
                  //color: Colors.amber,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
