import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/utill/color_resources.dart';

void showCustomSnackBar(String message, BuildContext context,
    {bool isError = true}) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(SnackBar(
      backgroundColor: isError ? ColorResources.getRed(context) : Colors.green,
      content: Text(message),
    ));
}
