// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CredentialsAlert extends StatefulWidget {
  String error;
  CredentialsAlert({
    Key? key,
    required this.error,
  }) : super(key: key);

  @override
  State<CredentialsAlert> createState() => _CredentialsAlertState();
}

class _CredentialsAlertState extends State<CredentialsAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Icon(Icons.error),
      content: SizedBox(
        height: MediaQuery.of(context).size.width / 3,
        width: 85,
        child: Column(children: [
          Text(
            widget.error,
            style: TextStyle(
                letterSpacing: 3.2,
                fontFamily: GoogleFonts.mogra().fontFamily,
                fontSize: 18.0,
                color: Colors.black),
          ),
          SizedBox(height: MediaQuery.of(context).size.width / 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(
                  child: ElevatedButton(
                style: ButtonStyle(
                  //backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(
                  'Retry',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: GoogleFonts.mogra().fontFamily,
                    fontSize: 22.0,
                  ),
                ),
              )),
            ]),
          ),
        ]),
      ),
    );
  }
}
