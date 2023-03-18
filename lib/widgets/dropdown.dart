// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sgp/utils/colors.dart';

class DropdownList extends StatefulWidget {
  String header;
  List<String> listitems;
  String defaultString;
  DropdownList({
    Key? key,
    required this.header,
    required this.listitems,
    required this.defaultString,
  }) : super(key: key);

  @override
  State<DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.header,
            style: TextStyle(
                color: textPurple, fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ),
        Padding(
            padding:
                EdgeInsets.only(right: MediaQuery.of(context).size.width / 4),
            child: DropdownButton(
                value: widget.defaultString,
                iconSize: 36,
                items: widget.listitems.map((value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                onChanged: (String? newVal) {
                  setState(() {
                    widget.defaultString = newVal!;
                  });
                }))
      ],
    );
  }
}
