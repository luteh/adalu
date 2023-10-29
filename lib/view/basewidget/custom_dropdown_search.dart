import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../utill/custom_themes.dart';

class CustomDropdownSearch<T> extends StatelessWidget {
  final String popupTitleText;
  final String hintText;
  final List<T> items;
  final Function(T value) onChanged;
  final bool showSelectedItems;

  const CustomDropdownSearch({
    Key key,
    @required this.popupTitleText,
    @required this.hintText,
    @required this.items,
    @required this.onChanged,
    this.showSelectedItems = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      popupTitle: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          popupTitleText,
          style: titilliumSemiBold,
        ),
      ),
      mode: Mode.BOTTOM_SHEET,
      popupShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      dropdownSearchDecoration: InputDecoration(
        constraints: BoxConstraints.tightFor(
          height: 50,
        ),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
        isDense: true,
        counterText: '',
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        hintStyle: titilliumRegular.copyWith(
          color: Theme.of(context).hintColor,
        ),
        errorStyle: TextStyle(
          height: 1.5,
        ),
        border: InputBorder.none,
      ),
      showSelectedItems: showSelectedItems,
      items: items,
      onChanged: onChanged,
    );
  }
}
