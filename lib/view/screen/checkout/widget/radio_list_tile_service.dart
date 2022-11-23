import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/utill/color_resources.dart';
import 'package:flutter_rekret_ecommerce/utill/custom_themes.dart';

class RadioListTileService extends StatelessWidget {
  final int groupValue;
  final int value;
  final bool isSelected;
  final String title;
  final String cost;
  final String estimated;
  final Function(int value) onChanged;

  RadioListTileService(
      {@required this.groupValue,
      @required this.value,
      @required this.isSelected,
      @required this.title,
      @required this.cost,
      @required this.estimated,
      @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: value,
      activeColor: Theme.of(context).primaryColor,
      groupValue: groupValue,
      onChanged: onChanged,
      title: RichText(
        text: TextSpan(
          text: title,
          style: titilliumSemiBold.copyWith(color: Colors.black),
        ),
      ),
      selected: isSelected,
    );
  }
}
