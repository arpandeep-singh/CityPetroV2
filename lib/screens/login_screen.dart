import 'package:city_petro/services/auth.dart';
import 'package:city_petro/services/firebase_service.dart';
import 'package:city_petro/utils/routes.dart';
import 'package:city_petro/widgets/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();

  FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  String email = "";
  String password = "";
  bool loading = false;

  void showMessage(String message, MaterialColor color) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(message),
      duration: Duration(milliseconds: 1500),
    ));
  }

  trySignIn() async {
    _formKey.currentState!.validate();
    if (mounted) {
      setState(() {
        loading = true;
      
      });
    }
    try {
      String uid = await _firebaseService.signIn(email, password);
      // if (!uid.isEmptyOrNull) {
      //   print("Login Success: " + uid);
      //   await Navigator.pushNamed(context, MyRoutes.dashboardRoute);
      // }
    } on FirebaseAuthException catch (e) {
      showMessage("Login Failed!", Colors.red);
      print("Login Failed " + e.message!);
    }
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
      ),
      backgroundColor: Color(0xff3366ff),
      //backgroundColor: context.cardColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                "City Petro".text.xl6.bold.color(context.cardColor).make(),
                "LOGIN".text.xl2.bold.color(context.cardColor).make(),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  color: Colors.white,

                  child: Column(
                    children: [
                      Container(
                         color: Colors.grey[200],
                        //color: context.accentColor.withOpacity(0.8),
                        child: TextFormField(
                          style: TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            //hintStyle: TextStyle(color: Colors.white),
                            hintText: "Email Address",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                           enabledBorder: InputBorder.none,
                           disabledBorder: InputBorder.none,
                            //fillColor: Color(0xff1b66a9),
                            contentPadding: EdgeInsets.all(16),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            }

                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                      ).py12(),
                      Container(
                        color: Colors.grey[200],
                        child: TextFormField(
                           style: TextStyle(fontSize: 12),
                          obscureText: true,
                          decoration:InputDecoration(
                            hintText: "Password",
                            contentPadding: EdgeInsets.all(16),
                           border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                           enabledBorder: InputBorder.none,
                           disabledBorder: InputBorder.none,
                            //fillColor: Color(0xff1b66a9),
                          ), 
                          
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            } else if (value.length < 6) {
                              return "Password length should be atleast 6";
                            }

                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                      ).py12(),
                      SizedBox(
                        height: 20.0,
                      ),
                      CupertinoButton.filled(
                        //color: Color(0xff091A7A),
                        
                        child: "SIGN IN".text.bold.make(),
                        onPressed: trySignIn,

                        borderRadius: BorderRadius.circular(5),
                      ).wFull(context),
                    ],
                  ).p16(),
                ).cornerRadius(10).px16().py20(),
                loading
                    ? CircularProgressIndicator(
                        color: context.cardColor,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
