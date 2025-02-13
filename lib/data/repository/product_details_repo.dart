import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_rekret_ecommerce/data/model/body/review_body.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';
import 'package:http/http.dart' as http;

class ProductDetailsRepo {
  final DioClient dioClient;
  ProductDetailsRepo({@required this.dioClient});

  Future<ApiResponse> getProduct(String productID, String languageCode) async {
    try {
      final dio = Dio(BaseOptions(
        baseUrl: 'https://adakom.rekretgroup.com/',
        headers: {
          'authorization': 'Bearer ${dioClient.token}',
        }
      ));
      final response = await dio.get(
        AppConstants.PRODUCT_DETAILS_URI + productID,
        options: Options(headers: {AppConstants.LANG_KEY: languageCode}),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getReviews(String productID) async {
    try {
      final response =
          await dioClient.get(AppConstants.PRODUCT_REVIEW_URI + productID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCount(String productID) async {
    try {
      final response =
          await dioClient.get(AppConstants.COUNTER_URI + productID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSharableLink(String productID) async {
    try {
      final response =
          await dioClient.get(AppConstants.SOCIAL_LINK_URI + productID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<http.StreamedResponse> submitReview(
      ReviewBody reviewBody, List<File> files, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse('${AppConstants.BASE_URL}${AppConstants.SUBMIT_REVIEW_URI}'));
    request.headers.addAll(<String, String>{'Authorization': 'Bearer $token'});
    for (int index = 0; index < 3; index++) {
      if (files[index].path.isNotEmpty) {
        request.files.add(http.MultipartFile(
          'fileUpload[$index]',
          files[index].readAsBytes().asStream(),
          files[index].lengthSync(),
          filename: files[index].path.split('/').last,
        ));
      }
    }
    request.fields.addAll(<String, String>{
      'product_id': reviewBody.productId,
      'comment': reviewBody.comment,
      'rating': reviewBody.rating
    });
    http.StreamedResponse response = await request.send();
    print(response.reasonPhrase);
    return response;
  }
}
