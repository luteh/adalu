import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';

class CouponRepo {
  final DioClient dioClient;
  CouponRepo({@required this.dioClient});

  Future<ApiResponse> getCoupon(Map<String, dynamic> data) async {
    try {
      final response = await dioClient.post(AppConstants.COUPON_URI, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}