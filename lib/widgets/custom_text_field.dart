import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    required this.label,
  });
  final TextInputType textInputType;
  final String hintText;
  final Function(String)? onChanged;
  final TextInputAction textInputAction;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [Text(label, style: TextStyle(fontSize: 17))]),
        SizedBox(height: 7),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: TextField(
            textInputAction: textInputAction,
            keyboardType: textInputType,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.5),
              ),
              contentPadding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
              hint: Text(
                hintText,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
