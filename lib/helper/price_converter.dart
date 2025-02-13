import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/provider/splash_provider.dart';
import 'package:provider/provider.dart';

class PriceConverter {
  static String convertPrice(BuildContext context, double price,
      {double discount, String discountType}) {
    if (discount != null && discountType != null) {
      if (discountType == 'amount' || discountType == 'flat') {
        price = price - discount;
      } else if (discountType == 'percent' || discountType == 'percentage') {
        price = price - ((discount / 100) * price);
      }
    }
    return '${Provider.of<SplashProvider>(context, listen: false).myCurrency.symbol} ${(price * Provider.of<SplashProvider>(context, listen: false).myCurrency.exchangeRate * (1 / Provider.of<SplashProvider>(context, listen: false).usdCurrency.exchangeRate)).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  static String convertPriceDiscount(BuildContext context, double price,
      {double discount, String discountType}) {
    if (discount != null && discountType != null) {
      if (discountType == 'amount' || discountType == 'flat') {
        price = price - discount;
      } else if (discountType == 'percent' || discountType == 'percentage') {
        price = price - ((discount / 100) * price);
      }
    }
    return '${Provider.of<SplashProvider>(context, listen: false).myCurrency.symbol}${(price * Provider.of<SplashProvider>(context, listen: false).myCurrency.exchangeRate * (1 / Provider.of<SplashProvider>(context, listen: false).usdCurrency.exchangeRate)).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  static double convertWithDiscount(BuildContext context, double price,
      double discount, String discountType) {
    if (discountType == 'amount' || discountType == 'flat') {
      price = price - discount;
    } else if (discountType == 'percent' || discountType == 'percentage') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }

  static double calculation(
      double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if (type == 'amount' || type == 'flat') {
      calculatedAmount = discount * quantity;
    } else if (type == 'percent' || type == 'percentage') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(
    BuildContext context,
    double price,
    double discount,
    String discountType,
  ) {
    return '${(discountType == 'percent' || discountType == 'percentage') ? '$discount %' : convertPriceDiscount(context, discount)} OFF';
  }
}
