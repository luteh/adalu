import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/localization/language_constrants.dart';
import 'package:flutter_rekret_ecommerce/utill/custom_themes.dart';
import 'package:flutter_rekret_ecommerce/utill/dimensions.dart';

class ConfirmCloseDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Text(getTranslated('ALL_DATA_WILL_BE_LOST', context), textAlign: TextAlign.center, style: titilliumRegular),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

            Divider(height: 0, color: Theme.of(context).hintColor),
            Row(children: [

              Expanded(child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
                  child: Text(getTranslated('NO', context), style: titilliumBold.copyWith(color: Theme.of(context).primaryColor)),
                ),
              )),

              Expanded(child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))),
                  child: Text(getTranslated('YES', context), style: titilliumBold.copyWith(color: Colors.white)),
                ),
              )),

            ]),
          ],
        ),
      ),
    );
  }
}
