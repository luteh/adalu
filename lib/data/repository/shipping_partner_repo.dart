import 'package:flutter/cupertino.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';

class ShippingPartnerRepo {
  final DioClient dioClient;

  ShippingPartnerRepo({@required this.dioClient});

  Future<ApiResponse> getCourier() async {
    try {
      final response = await dioClient.get(AppConstants.GET_PROVINCE + "?id=0");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getServiceCourier(
      String courierId, String districtId) async {
    try {
      final response = await dioClient.post(AppConstants.GET_SERVICE,
          data: {'courier': courierId, 'district': districtId});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
