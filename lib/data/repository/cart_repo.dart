import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/cart.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/cart_model.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({@required this.sharedPreferences});

  List<CartM> getCartList() {
    List<String> carts =
        sharedPreferences.getStringList(AppConstants.CART_LIST);
    List<CartM> cartList = [];
    carts.forEach((cart) => cartList.add(CartM.fromJson(jsonDecode(cart))));
    return cartList;
  }

  void addToCartList(List<CartM> cartProductList) {
    List<String> carts = [];
    cartProductList.forEach((cartModel) => carts.add(jsonEncode(cartModel)));
    sharedPreferences.setStringList(AppConstants.CART_LIST, carts);
  }
}
