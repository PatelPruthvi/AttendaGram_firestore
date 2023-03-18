// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sgp/screens/StudentDashboard.dart';
import 'package:sgp/backend/flute.dart' as globals;
import 'package:google_fonts/google_fonts.dart';
import 'package:sgp/backend/flute.dart';
import 'package:sgp/utils/colors.dart';
import 'package:sgp/widgets/alertDialog.dart';

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);
  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String? dox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Center(
              child: Text(
            "Student Login",
            style: TextStyle(letterSpacing: 2.0, fontSize: 23),
          )),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 0),
                child: Center(
                  child: Text(
                    "Attendagram",
                    style: TextStyle(
                        fontFamily: GoogleFonts.alexBrush().fontFamily,
                        fontSize: 55.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Image.asset(
                'assets/image/loginPhoto2.png',
                height: 266.5,
                width: 350.0,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.deepPurple),
                      labelText: 'User Name',
                      hintText: 'example@charusat.edu.in',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: Colors.deepPurple,
                          ))),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.deepPurple,
                      ),
                      labelText: 'Password',
                      hintText: 'Enter Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: Colors.deepPurple,
                          ))),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Lottie.asset('assets/image/loading.json',
                            width: MediaQuery.of(context).size.width / 4);
                      });
                  bool shouldNavigate = await signIn(
                      nameController.text, passController.text, context);

                  if (shouldNavigate) {
                    String percent = await overall();
                    await userDetails();
                    dox = await docID();
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 200),
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                                alignment: Alignment.center,
                              );
                            },
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return getuserName(
                                percent: percent,
                                name: globals.username.toString(),
                                roll: globals.userid.toString(),
                                str: globals.program.toString(),
                                DocumentID: dox.toString(),
                              );
                            }));
                  } else {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (ctx) => CredentialsAlert(
                              error: "Wrong Credentials",
                            ));
                  }
                },
                icon: Icon(Icons.login),
                label: Text(
                  "Log In",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/faculty');
                  },
                  child: Text(
                    'Faculty? Click Here',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.deepPurpleAccent,
                    ),
                  ))
            ],
          ),
        ));
  }
}
