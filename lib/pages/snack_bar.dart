import 'package:flutter/material.dart';

void openSnackBar(context, snackMassage, color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
      ),
      content: Text(
        snackMassage,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      )));
}
