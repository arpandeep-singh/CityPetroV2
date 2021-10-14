import 'package:CityPetro/authenticate/UserInfo.dart' as my;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Create a new user".text.textStyle(TextStyle(fontSize: 16)).make(),
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [NewUserForm()],
          ).p12(),
        ),
      ),
    );
  }
}

class NewUserForm extends StatefulWidget {
  const NewUserForm({Key? key}) : super(key: key);

  @override
  _NewUserFormState createState() => _NewUserFormState();
}

class _NewUserFormState extends State<NewUserForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  my.UserInfo newUser = new my.UserInfo();
  bool loading = false;
  String password = "";

  void showMessage(String message, MaterialColor color) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(message),
      duration: Duration(milliseconds: 1500),
    ));
  }

  void _submitForm() async {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      return;
    }
    setState(() => loading = true);
    try {
      String uid = await newUser.createUser();
      if (!uid.isEmptyOrNull) {
        print('NEW USER: $uid');
        showMessage("Account created successfully", Colors.green);
      }
    } on FirebaseAuthException catch (e) {
      showMessage(e.message.toString(), Colors.red);
    } on Exception catch(e) {
showMessage(e.toString(), Colors.red);
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Container(
        child: Form(
          key: _formKey,
          //autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  VxBox(
                    child: VStack([
                      "First Name".text.make(),
                      Container(
                        color: Colors.grey[100],
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Color(0xff1b66a9),
                          ),
                          validator: (val) =>
                              val.isEmptyOrNull ? "Required*" : null,
                          onChanged: (val) {
                            setState(() {
                              newUser.firstName = val;
                              
                            });
                          },
                        ),
                      ).cornerRadius(10)
                    ]),
                  ).make().expand(),
                  VxBox().make().w(10),
                  VxBox(
                    child: VStack([
                      "Last Name".text.make(),
                      Container(
                        color: Colors.grey[100],
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Color(0xff1b66a9),
                          ),
                          validator: (val) =>
                              val.isEmptyOrNull ? "Required*" : null,
                          onChanged: (val) {
                            setState(() {
                              newUser.lastName = val;
                            });
                          },
                        ),
                      ).cornerRadius(10)
                    ]),
                  ).make().expand(),
                ],
              ),
              VxBox().make().h(10),
              "Email".text.make(),
              Container(
                color: Colors.grey[100],
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
                  validator: (val) => val.isEmptyOrNull
                      ? "Required*"
                      : !(val.toString().isValidEmail())
                          ? "Invalid Email"
                          : null,
                  onChanged: (val) {
                    setState(() {
                      newUser.email = val;
                    });
                  },
                ),
              ).cornerRadius(10),
              VxBox().make().h(10),
              "Contact".text.make(),
              Container(
                color: Colors.grey[100],
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
                  onChanged: (val) {
                    setState(() {
                      newUser.contact = val;
                    });
                  },
                ),
              ).cornerRadius(10),
              VxBox().make().h(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Password".text.make(),
                  newUser.password.text.make(),
                ],
              ),
              VxBox().make().h(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Driver Level".text.make(),
                  Container(
                    //color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: "1",
                                groupValue: newUser.level,
                                onChanged: (String? value) {
                                  setState(() {
                                    newUser.level = value!;
                                  });
                                }),
                            "1".text.make()
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: "2",
                                groupValue: newUser.level,
                                onChanged: (String? value) {
                                  setState(() {
                                    newUser.level = value!;
                                  });
                                }),
                            "2".text.make()
                          ],
                        ),
                      ],
                    ),
                  ).expand(),
                ],
              ),
              "Note: Level 2 means more pay".text.sm.coolGray600.make(),
              VxBox().make().h(20),
              CupertinoButton.filled(
                      pressedOpacity: 0.8,
                      borderRadius: BorderRadius.circular(0),
                      child: loading
                          ? "Loading".text.make()
                          : "SUBMIT".text.make(),
                      disabledColor: context.accentColor.withOpacity(0.5),
                      onPressed: loading ? null : _submitForm)
                  .cornerRadius(10)
                  .wFull(context)
            ],
          ).p20(),
        ),
      ).px12(),
    ).color(context.cardColor).make().cornerRadius(10);
  }
}
