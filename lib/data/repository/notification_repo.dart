import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';

class NotificationRepo {
  final DioClient dioClient;
  NotificationRepo({@required this.dioClient});

  Future<ApiResponse> getNotificationList() async {
    try {
      Response response = await dioClient.get(AppConstants.NOTIFICATION_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}