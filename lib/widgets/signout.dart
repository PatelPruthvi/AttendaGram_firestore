import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class alertSign extends StatefulWidget {
  const alertSign({Key? key}) : super(key: key);

  @override
  State<alertSign> createState() => _alertSignState();
}

class _alertSignState extends State<alertSign> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Icon(Icons.power_settings_new_rounded),
      content: SizedBox(
        width: 100,
        height: 100,
        child: Column(children: [
          Text(
            "Do You want to Log Out?",
            style: TextStyle(
                fontFamily: GoogleFonts.mogra().fontFamily,
                fontSize: 18.0,
                color: Colors.black),
          ),
          SizedBox(height: 30),
          Row(children: [
            Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepPurple)),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text('CANCEL')),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple)),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      // Navigator.pushReplacementNamed(context, '/');
                    },
                    child: Text('OK'))),
          ]),
        ]),
      ),
    );
  }
}
