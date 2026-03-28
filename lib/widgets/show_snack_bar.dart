import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String massage,
  bool isError = false,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.grey.shade200,
      content: Text(
        massage,
        style: TextStyle(
          fontSize: 20,
          color: isError ? Colors.red : Colors.green,
        ),
      ),
    ),
  );
}
