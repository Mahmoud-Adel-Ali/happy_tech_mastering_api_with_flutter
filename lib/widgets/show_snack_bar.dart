import 'package:flutter/material.dart';

showSnackBar(BuildContext context, {required String message}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),backgroundColor: Colors.blueGrey,
    ),
  );
}
