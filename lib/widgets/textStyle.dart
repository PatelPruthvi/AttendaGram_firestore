// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TxtStyle extends StatefulWidget {
  String info1;
  String info2;
  TxtStyle({
    Key? key,
    required this.info1,
    required this.info2,
  }) : super(key: key);

  @override
  State<TxtStyle> createState() => _TxtStyleState();
}

class _TxtStyleState extends State<TxtStyle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              widget.info1,
              style: TextStyle(color: Colors.black, letterSpacing: 1.0),
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.info2,
            style: TextStyle(color: Colors.black, letterSpacing: 1.0),
          ),
        ),
      ],
    );
  }
}
