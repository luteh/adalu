import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_rekret_ecommerce/data/model/body/login_model.dart';
import 'package:flutter_rekret_ecommerce/data/model/body/register_model.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<http.StreamedResponse> register(RegisterModel data, File file) async {
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      Uri.parse('${AppConstants.BASE_URL}${AppConstants.REGISTRATION_URI}'),
    );

    file != null
        ? request.files.add(
            http.MultipartFile(
              'npwp',
              file.readAsBytes().asStream(),
              file.lengthSync(),
              filename: file.path.split('/').last,
            ),
          )
        : request.fields.addAll(<String, String>{'npwp': data.npwp});

    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      'f_name': data.fName,
      'l_name': data.lName,
      'phone': data.phone,
      'email': data.email,
      'password': data.password,
      'npwp_str': data.npwpStr,
      'company': data.company,
      'address': data.address,
    });

    request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<ApiResponse> registration(RegisterModel register) async {
    try {
      Response response = await dioClient.post(
        AppConstants.REGISTRATION_URI,
        data: register.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> login(LoginModel loginBody) async {
    try {
      Response response = await dioClient.post(
        AppConstants.LOGIN_URI,
        data: loginBody.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateToken() async {
    try {
      String _deviceToken = await _getDeviceToken();
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
      Response response = await dioClient.post(
        AppConstants.TOKEN_URI,
        data: {"_method": "put", "cm_firebase_token": _deviceToken},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<String> _getDeviceToken() async {
    String _deviceToken = await FirebaseMessaging.instance.getToken();
    if (_deviceToken != null) {
      print('--------Device Token---------- ' + _deviceToken);
    }
    return _deviceToken;
  }

  // for  user token
  Future<void> saveUserToken(String token) async {
    dioClient.token = token;
    dioClient.dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> clearSharedData() async {
    //sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CURRENCY);
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.USER);
    FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
    return true;
  }

  // for  Remember Email
  Future<void> saveUserEmailAndPassword(String email, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_EMAIL, email);
    } catch (e) {
      throw e;
    }
  }

  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.USER_EMAIL) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_EMAIL);
  }

  Future<ApiResponse> forgetPassword(String email) async {
    try {
      Response response = await dioClient
          .post(AppConstants.FORGET_PASSWORD_URI, data: {"email": email});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> RemoveAccount(String email) async {
    try {
      Response response = await dioClient.post(AppConstants.REMOVE_ACCOUNT_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
