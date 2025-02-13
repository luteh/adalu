import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/provider/theme_provider.dart';
import 'package:flutter_rekret_ecommerce/utill/color_resources.dart';
import 'package:flutter_rekret_ecommerce/utill/custom_themes.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String buttonText;
  final Color buttonColor;

  CustomButton({this.onTap, @required this.buttonText, this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorResources.getChatIcon(context),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 1)), // changes position of shadow
            ],
            gradient:
                (Provider.of<ThemeProvider>(context).darkTheme || onTap == null)
                    ? null
                    : LinearGradient(colors: [
                        buttonColor ?? Theme.of(context).primaryColor,
                        buttonColor ?? Theme.of(context).primaryColor,
                        buttonColor ?? Theme.of(context).primaryColor,
                      ]),
            borderRadius: BorderRadius.circular(10)),
        child: Text(buttonText,
            style: titilliumSemiBold.copyWith(
              fontSize: 16,
              color: Theme.of(context).accentColor,
            )),
      ),
    );
  }
}
