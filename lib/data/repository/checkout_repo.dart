import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_rekret_ecommerce/data/model/body/order_place_model.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';

class CheckoutRepo {
  final DioClient dioClient;

  CheckoutRepo({@required this.dioClient});

  Future<ApiResponse> postServiceFee(Map<String, dynamic> dataValue) async {
    try {
      print('getServiceFee');
      print(dataValue);

      final Response response = await dioClient.post(
        AppConstants.GET_SERVICE_FEE,
        data: dataValue,
      );
      print("Sukses");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print("Sukses");

      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> postPaymentProcess(Map<String, dynamic> data) async {
    try {
      print('postPaymentProcess');
      print(data);

      final Response response = await dioClient.post(
        AppConstants.PAYMENT_PROCESS,
        data: data,
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
