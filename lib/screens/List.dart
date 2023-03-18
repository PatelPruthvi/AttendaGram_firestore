// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, camel_case_types

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgp/utils/colors.dart';
import 'package:sgp/widgets/drawer.dart';
import 'package:sgp/widgets/textStyle.dart';

import '../utils/styles.dart';

class lstP extends StatefulWidget {
  String stream;
  String sub;

  lstP({
    Key? key,
    required this.stream,
    required this.sub,
  }) : super(key: key);

  @override
  State<lstP> createState() => _lstPState();
}

class _lstPState extends State<lstP> {
  bool? isLoading;
  List tile = [];
  @override
  void initState() {
    setState(() {
      //code to add subject attendance detail in firebase
      // FirebaseFirestore.instance
      //     .collection('user')
      //     .where('stream', isEqualTo: "CS")
      //     .get()
      //     .then((value) {
      //   value.docs.forEach((element) {
      //     FirebaseFirestore.instance
      //         .collection('user')
      //         .doc(element.id)
      //         .collection('subject')
      //         .add({'Att': 0, 'Sname': 'AI', 'Tot': 0});
      //     FirebaseFirestore.instance
      //         .collection('user')
      //         .doc(element.id)
      //         .collection('subject')
      //         .add({'Att': 0, 'Sname': 'DAA', 'Tot': 0});
      //     FirebaseFirestore.instance
      //         .collection('user')
      //         .doc(element.id)
      //         .collection('subject')
      //         .add({'Att': 0, 'Sname': 'SGP', 'Tot': 0});
      //     FirebaseFirestore.instance
      //         .collection('user')
      //         .doc(element.id)
      //         .collection('subject')
      //         .add({'Att': 0, 'Sname': 'OS', 'Tot': 0});
      //   });
      // });
    });
    super.initState();
  }

  String? datedd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance Sheet',
          style: TextStyle(letterSpacing: 1.5),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          TxtStyle(info1: 'DATE', info2: 'TIME'),
          // ignore: prefer_const_literals_to_create_immutables
          Row(
            children: [
              Expanded(
                child: Text(
                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                    style: styleh2),
              ),
              Expanded(
                child: Text(
                    TimeOfDay.fromDateTime(DateTime.now())
                        .toString()
                        .substring(10, 15),
                    style: styleh2),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width / 16),
          TxtStyle(info1: 'STREAM', info2: 'SUBJECT'),
          Row(
            children: [
              Expanded(
                child: Text(widget.stream, style: styleh2),
              ),
              Expanded(
                child: Text(widget.sub, style: styleh2),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(height: 10),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('user')
                  .where('stream', isEqualTo: widget.stream)
                  // .orderBy('ID', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                    ),
                  );

                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return Card(
                      child: CheckboxListTile(
                        activeColor: Colors.deepPurple[500],
                        value: document['checkbox'],
                        onChanged: (val) {
                          setState(() {
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(document.id)
                                .update({'checkbox': val!});
                          });
                        },
                        title: Text(document['ID']),
                        subtitle: Text(document['name']),
                        tileColor: Colors.deepPurple[50],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))),
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) => Center(
                          child: CircularProgressIndicator(
                        color: textPurple,
                      )));
              await FirebaseFirestore.instance
                  .collection('user')
                  .where("checkbox", isEqualTo: true)
                  .get()
                  .then((value) {
                value.docs.forEach((element) {
                  FirebaseFirestore.instance
                      .collection('user')
                      .doc(element.id)
                      .collection('subject')
                      .where('Sname', isEqualTo: widget.sub)
                      .get()
                      .then((val) {
                    val.docs.forEach((ele) {
                      FirebaseFirestore.instance
                          .collection('user')
                          .doc(element.id)
                          .collection('subject')
                          .doc(ele.id)
                          .update({'Att': ele['Att'] + 1});
                    });
                  });
                });
              });
              await FirebaseFirestore.instance
                  .collection('user')
                  .get()
                  .then((value) {
                value.docs.forEach((element) {
                  FirebaseFirestore.instance
                      .collection('user')
                      .doc(element.id)
                      .collection('subject')
                      .where('Sname', isEqualTo: widget.sub)
                      .get()
                      .then((val) {
                    val.docs.forEach((ele) {
                      FirebaseFirestore.instance
                          .collection('user')
                          .doc(element.id)
                          .collection('subject')
                          .doc(ele.id)
                          .update({'Tot': ele['Tot'] + 1});
                    });
                  });
                });
              });
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Icon(Icons.assignment_turned_in),
                      content: Text('Attendance Taken Sucessfully !'),
                    );
                  });
            },
            icon: Icon(
              Icons.how_to_reg,
              size: 30.0,
            ),
            label: Text(
              "Take Attendance",
              style: TextStyle(
                fontFamily: GoogleFonts.lancelot().fontFamily,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
