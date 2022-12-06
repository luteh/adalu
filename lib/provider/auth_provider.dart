import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/model/body/login_model.dart';
import 'package:flutter_rekret_ecommerce/data/model/body/register_model.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/error_response.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/response_model.dart';
import 'package:flutter_rekret_ecommerce/data/repository/auth_repo.dart';
import 'package:flutter_rekret_ecommerce/helper/api_checker.dart';

import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;
  AuthProvider({@required this.authRepo});

  bool _isLoading = false;
  bool _isRemember = false;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  bool get isRemember => _isRemember;

  void updateRemember(bool value) {
    _isRemember = value;
    notifyListeners();
  }

  Future<ResponseModel> register(
    context,
    RegisterModel data,
    File file,
    Function callback,
  ) async {
    _isLoading = true;
    notifyListeners();

    ResponseModel responseModel;
    http.StreamedResponse response = await authRepo.register(data, file);
    // print(response.statusCode)
    _isLoading = false;

    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ));
    } else {
      print('${response.statusCode} | ${response.reasonPhrase}');
      callback(false, 'Register Failed');
      responseModel = ResponseModel(
        '${response.statusCode} | ${response.reasonPhrase}',
        false,
      );
    }
    notifyListeners();
    return responseModel;
  }

  Future registration(RegisterModel register, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.registration(register);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      String token = map["token"];
      authRepo.saveUserToken(token);
      await authRepo.updateToken();
      callback(true, token);
      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
        callback(false, errorMessage);
      }
      notifyListeners();
    }
  }

  Future login(LoginModel loginBody, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.login(loginBody);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      String token = map["token"];
      authRepo.saveUserToken(token);
      await authRepo.updateToken();
      callback(true, token);
      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      callback(false, errorMessage);
      notifyListeners();
    }
  }

  Future<void> updateToken(BuildContext context) async {
    ApiResponse apiResponse = await authRepo.updateToken();
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
  }

  // for user Section
  String getUserToken() {
    return authRepo.getUserToken();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  // for  Remember Email
  void saveUserEmail(String email, String password) {
    authRepo.saveUserEmailAndPassword(email, password);
  }

  String getUserEmail() {
    return authRepo.getUserEmail() ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo.clearUserEmailAndPassword();
  }

  String getUserPassword() {
    return authRepo.getUserPassword() ?? "";
  }

  Future<ResponseModel> forgetPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.forgetPassword(email);
    _isLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      responseModel = ResponseModel(apiResponse.response.data["message"], true);
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      responseModel = ResponseModel(errorMessage, false);
    }
    return responseModel;
  }
}
