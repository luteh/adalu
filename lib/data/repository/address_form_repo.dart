import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressFormRepo {
  final DioClient dioClient;

  AddressFormRepo({@required this.dioClient});

  Future<ApiResponse> getListProvince(String id) async {
    try {
      final response =
          await dioClient.get(AppConstants.GET_PROVINCE + "?id=${id}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getListCity(String id, String province) async {
    try {
      final response = await dioClient
          .get(AppConstants.GET_CITY + "?id=${id}&province=${province}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getListDistrict(String id, String city) async {
    try {
      final response = await dioClient
          .get(AppConstants.GET_DISTRICT + "?id=${id}&city=${city}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
