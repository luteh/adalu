import 'package:flutter/cupertino.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';

class TrackOrderRepo {
  final DioClient dioClient;

  TrackOrderRepo({@required this.dioClient});

  Future<ApiResponse> getTrackOrder(String orderID) async {
    try {
      final response = await dioClient.get(AppConstants.TRACKING_ORDER+orderID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}