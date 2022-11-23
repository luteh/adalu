import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/utill/custom_themes.dart';
import 'package:flutter_rekret_ecommerce/utill/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class AmountWidget extends StatelessWidget {
  final String title;
  final String amount;
  final bool loadingAmount;

  AmountWidget({@required this.title, @required this.amount, this.loadingAmount=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
        if (!loadingAmount)
          Text(amount, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
        if (loadingAmount)
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
              width: 120,
              height: 12.0,
              color: Colors.white,
            ),
          )
      ]),
    );
  }
}
