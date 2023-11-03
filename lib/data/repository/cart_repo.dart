import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utill/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';
import '../model/response/cart.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  final DioClient dioClient;
  CartRepo({
    @required this.sharedPreferences,
    @required this.dioClient,
  });

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

  Future<bool> clearCartList() {
    return sharedPreferences.remove(AppConstants.CART_LIST);
  }

  Future<ApiResponse> getCartListRemote() async {
    try {
      final response = await dioClient.get(AppConstants.GET_CART);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addToCartListRemote(int productId, int quantity) async {
    try {
      final response = await dioClient.post(
        '${AppConstants.ADD_TO_TABLE_CART}',
        queryParameters: {
          'id': productId,
          'quantity': quantity,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> confirmStock() async {
    try {
      final response = await dioClient.post(
        '${AppConstants.CONFIRM_STOCK_CUST}',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> deleteCart(int productId) async {
    try {
      final response = await dioClient.post(
        '${AppConstants.DELETE_CART}',
        data: {
          'product_id': productId,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
