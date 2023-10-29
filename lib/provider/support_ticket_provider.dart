import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data/model/body/support_ticket_body.dart';
import '../data/model/body/support_ticket_return_model.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/error_response.dart';
import '../data/model/response/order_delivered_list_model.dart';
import '../data/model/response/support_ticket_model.dart';
import '../data/repository/support_ticket_repo.dart';
import '../helper/api_checker.dart';
import '../helper/date_converter.dart';

class SupportTicketProvider extends ChangeNotifier {
  final SupportTicketRepo supportTicketRepo;
  SupportTicketProvider({@required this.supportTicketRepo});

  List<SupportTicketModel> _supportTicketList;
  bool _isLoading = false;

  List<SupportTicketModel> get supportTicketList => _supportTicketList;
  bool get isLoading => _isLoading;

  int refundProductLength = 0;
  XFile videoFile;

  List<int> orderIds = [];
  ProductData selectedProductData;
  dynamic orderDeliveredMessage;
  bool isLoadingOrderDelivered = false;
  int selectedOrderId;
  Map<int, RefundProduct> refundProducts = {};

  void sendSupportTicket(SupportTicketBody supportTicketBody,
      Function(bool isSuccess, String message) callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse =
        await supportTicketRepo.sendSupportTicket(supportTicketBody);
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      String message = apiResponse.response.data["message"];
      callback(true, message);
      _isLoading = false;
      _supportTicketList.add(SupportTicketModel(
          description: supportTicketBody.description,
          type: supportTicketBody.type,
          subject: supportTicketBody.subject,
          createdAt: DateConverter.formatDate(DateTime.now()),
          status: '0'));
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
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getSupportTicketList(BuildContext context) async {
    ApiResponse apiResponse = await supportTicketRepo.getSupportTicketList();
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      _supportTicketList.clear();
      apiResponse.response.data.forEach((supportTicket) =>
          _supportTicketList.add(SupportTicketModel.fromJson(supportTicket)));
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  Future<void> getOrderDeliveredList(BuildContext context, String type) async {
    if (type != 'Return') return;

    refundProductLength = 0;
    isLoadingOrderDelivered = true;
    notifyListeners();

    ApiResponse apiResponse = await supportTicketRepo.getOrderDeliveredList();
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      final data = OrderDeliveredListModel.fromJson(apiResponse.response.data);
      orderDeliveredMessage = apiResponse.response.data['message'];
      orderIds = data.message.listorderid;
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    isLoadingOrderDelivered = false;
    notifyListeners();
  }

  void addProductItem() {
    refundProductLength++;
    refundProducts[refundProductLength - 1] = null;
    notifyListeners();
  }

  void removeProductItem(int index) {
    refundProductLength--;
    refundProducts.remove(index);
    notifyListeners();
  }

  void saveUnboxingVideo(XFile xFile) {
    videoFile = xFile;
  }

  void changeSelectedOrderId(String orderId) {
    selectedOrderId = int.tryParse(orderId);
    refundProductLength = 1;
    refundProducts.clear();
    selectedProductData = ProductData.fromJson(orderDeliveredMessage[orderId]);
    notifyListeners();
  }

  void setRefundProductId(ListProduct value, int index) {
    refundProducts[index] = RefundProduct(
      productId: value.productId,
      quantity: 1,
    );
    refundProducts.update(
      index,
      (value) => value.copyWith(
        productId: value.productId,
      ),
      ifAbsent: () {
        return RefundProduct(
          productId: value.productId,
          quantity: 1,
        );
      },
    );
  }

  void setQuantityRefundProduct(int quantity, int index) {
    refundProducts.update(
      index,
      (value) => value.copyWith(
        quantity: quantity,
      ),
      ifAbsent: () {
        return RefundProduct(
          productId: 0,
          quantity: quantity,
        );
      },
    );
  }

  void sendSupportTicketReturn(
    String description, {
    @required Function(String message) onSuccess,
    @required Function(String message) onError,
  }) async {
    _isLoading = true;
    notifyListeners();

    final request = SupportTicketReturnModel(
      orderId: selectedOrderId,
      type: 'Return',
      priority: 'Medium',
      description: description,
      videoFile: videoFile,
      products: refundProducts.values.toList(),
    );
    ApiResponse apiResponse =
        await supportTicketRepo.sendSupportTicketReturn(request);
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      _supportTicketList.add(SupportTicketModel(
        description: request.description,
        type: request.type,
        subject: '${request.orderId}',
        priority: request.priority,
        reply: request.videoFile.name,
        createdAt: DateConverter.formatDate(DateTime.now()),
        status: '0',
      ));
      onSuccess(apiResponse.response.data['message']);
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
      onError(errorMessage);
    }
    _isLoading = false;
    notifyListeners();
  }
}

class RefundProduct {
  final int productId;
  final int quantity;

  RefundProduct({
    @required this.productId,
    @required this.quantity,
  });

  RefundProduct copyWith({
    int productId,
    int quantity,
  }) =>
      RefundProduct(
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
      );
}
