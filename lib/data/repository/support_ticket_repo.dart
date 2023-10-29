import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_rekret_ecommerce/data/model/body/support_ticket_body.dart';
import 'package:flutter_rekret_ecommerce/data/model/body/support_ticket_return_model.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';

class SupportTicketRepo {
  final DioClient dioClient;
  SupportTicketRepo({@required this.dioClient});

  Future<ApiResponse> sendSupportTicket(
      SupportTicketBody supportTicketModel) async {
    try {
      Response response = await dioClient.post(AppConstants.SUPPORT_TICKET_URI,
          data: supportTicketModel.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> sendSupportTicketReturn(
      SupportTicketReturnModel model) async {
    try {
      final file = await MultipartFile.fromFile(
        model.videoFile.path,
        filename: model.videoFile.name,
      );
      final dataMap = {
        'ticket_subject': model.orderId,
        'ticket_type': model.type,
        'ticket_priority': model.priority,
        'ticket_description': model.description,
        'ticket_reply': file,
      };
      model.products.asMap().forEach((index, product) {
        dataMap['ticket_product_id[$index][id]'] = product.productId;
        dataMap['ticket_product_id[$index][qty]'] = product.quantity;
      });
      final formData = FormData.fromMap(dataMap);

      Response response = await dioClient.post(
        AppConstants.SUBMIT_TICKET_RETURN,
        data: formData,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSupportTicketList() async {
    try {
      final response = await dioClient.get(AppConstants.SUPPORT_TICKET_GET_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderDeliveredList() async {
    try {
      final response = await dioClient.get(AppConstants.ORDER_DELIVERED_LIST);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
