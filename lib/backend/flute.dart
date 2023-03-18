// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgp/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String userid = "", username = "", program = "", firestoreid = "";
Future<bool> signIn(String email, String password, BuildContext context) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (email.contains("faculty") == false) {
      await overall();
      await userDetails();
    }
    return true;
  } catch (e) {
    return false;
  }
}

Future overall() async {
  num oatt = 0, otot = 0;

  await FirebaseFirestore.instance
      .collection('user')
      .doc(await docID())
      .collection('subject')
      .get()
      .then((value) {
    value.docs.forEach((element) {
      oatt = oatt + element['Att'];
      otot = otot + element['Tot'];
    });
  });
  return (oatt * 100 / otot).toStringAsFixed(2);
}

Future userDetails() async {
  await FirebaseFirestore.instance
      .collection('user')
      .doc(await docID())
      .get()
      .then((value) {
    username = value['name'];
    userid = value['ID'];
    program = value['stream'];
  });
}

Future docID() async {
  String? rollcall = await FirebaseAuth.instance.currentUser!.email!
      .toUpperCase()
      .substring(0, 8);

  await FirebaseFirestore.instance
      .collection('user')
      .where('ID', isEqualTo: rollcall)
      .get()
      .then((value) => value.docs.forEach((element) {
            firestoreid = element.id;
          }));

  return firestoreid;
}
