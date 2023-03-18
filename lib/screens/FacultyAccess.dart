// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sgp/screens/List.dart';
import 'package:sgp/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgp/widgets/alertDialog.dart';
import 'package:sgp/widgets/signout.dart';

import '../widgets/drawer.dart';

class TakeA extends StatefulWidget {
  const TakeA({Key? key}) : super(key: key);

  @override
  _TakeAState createState() => _TakeAState();
}

class _TakeAState extends State<TakeA> {
  String currDate = 'dd/mm/yyyy';
  String? semester;
  String? stream;
  String? sub;
  List<String> subs = [];
  var streams = ['CE', 'CS', 'IT'];
  var cesubs = ['MPCO', 'DSA', 'SGP', 'DBMS'];
  var cssubs = ['AI', 'DAA', 'SGP', 'OS'];
  @override
  void initState() {
    setState(() {
      //firestore add new students
      // FirebaseFirestore.instance.collection('user').get().then((value) {
      //   value.docs.forEach((element) {
      //     FirebaseFirestore.instance.collection('user').doc(element.id).set(
      //         {'stream': 'CE', 'ID': '20DCE', 'checkbox': true, 'name': ''});
      //   });
      // });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Faculty Access',
          style: TextStyle(
            letterSpacing: 1.5,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showDialog(context: context, builder: (ctx) => alertSign());
              },
              icon: Icon(Icons.power_settings_new_sharp))
        ],
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width / 10),
                  child: Text(
                    'Faculty Controls',
                    style: TextStyle(
                        fontSize: 44,
                        fontFamily: GoogleFonts.dancingScript().fontFamily,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Lottie.network(
                  'https://assets2.lottiefiles.com/packages/lf20_ny7LIo.json',
                  height: MediaQuery.of(context).size.width),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'STREAM: ',
                        style: TextStyle(
                            color: textPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 6),
                        child: DropdownButton(
                            hint: Text('select stream '),
                            value: stream,
                            iconSize: 36,
                            items: streams.map((value) {
                              return DropdownMenuItem(
                                  value: value, child: Text(value));
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                stream = newVal!;
                                if (stream == "CE")
                                  subs = cesubs;
                                else if (stream == "CS") subs = cssubs;
                                sub = null;
                              });
                            }))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'SUBJECT: ',
                        style: TextStyle(
                            color: textPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 6),
                        child: DropdownButton(
                            hint: Text('select subject '),
                            value: sub,
                            iconSize: 36,
                            items: subs.map((value) {
                              return DropdownMenuItem(
                                  value: value, child: Text(value));
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                sub = newVal!;
                              });
                            }))
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    if (sub == null || stream == null) {
                      showDialog(
                          context: context,
                          builder: (context) => CredentialsAlert(
                              error: 'incomplete credentials'));
                    } else
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return lstP(
                          stream: stream!,
                          sub: sub!,
                        );
                      }));
                  });
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                label: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Take Attendance',
                    style: TextStyle(
                      fontFamily: GoogleFonts.lancelot().fontFamily,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                icon: Icon(
                  Icons.how_to_reg,
                  size: 35.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
