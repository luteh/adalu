import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../utill/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/pick_up_request_body.dart';
import '../model/body/support_ticket_body.dart';
import '../model/body/support_ticket_comment_body.dart';
import '../model/body/support_ticket_return_model.dart';
import '../model/response/base/api_response.dart';

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

  Future<ApiResponse> getSupportTicketById(int ticketId) async {
    try {
      final response = await dioClient
          .get('${AppConstants.SUPPORT_TICKET_GET_URI}/$ticketId');
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

  Future<ApiResponse> getSupportTicketConvList(int ticketId) async {
    try {
      final response =
          await dioClient.get('${AppConstants.SUPPORT_TICKET_CONV}/$ticketId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getAwb(int ticketId) async {
    try {
      final response = await dioClient.get(
        '${AppConstants.GET_AWB}',
        queryParameters: {
          'ticket_id': ticketId,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> sendSupportTicketComment(
      SupportTicketCommentBody body) async {
    try {
      Response response = await dioClient
          .post(AppConstants.SUPPORT_TICKET_COMMENT, data: body.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> pickUpRequest(PickUpRequestBody body) async {
    try {
      Response response = await dioClient.post(AppConstants.PICKUP_REQUEST,
          data: body.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> generateResi(int ticketId) async {
    try {
      Response response = await dioClient.post(
        AppConstants.GENERATE_RESI,
        data: {
          'ticket_id': ticketId,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> downloadFile(String url, String savePath) async {
    try {
      Response response = await dioClient.dio.download(url, savePath);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
