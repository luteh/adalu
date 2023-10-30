import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../data/model/body/pick_up_request_body.dart';
import '../data/model/body/support_ticket_comment_body.dart';
import '../data/model/response/awb_model.dart';
import '../data/model/response/support_ticket_conv_model.dart';
import '../data/model/response/support_ticket_model.dart';
import '../data/repository/support_ticket_repo.dart';
import '../view/screen/support/ticket_detail/ticket_detail_effect.dart';
import '../view/screen/support/ticket_detail/ticket_detail_extra.dart';

class TicketDetailProvider extends ChangeNotifier {
  final SupportTicketRepo _supportTicketRepo;
  TicketDetailProvider(this._supportTicketRepo);

  Function(TicketDetailEffect) _effect;

  bool isLoadingGetConvList = true;
  List<SupportTicketConvModel> convList = [];

  bool isLoadingGetTicket = true;
  SupportTicketModel supportTicket;

  bool isLoadingSendComment = false;
  bool isLoadingPickUpRequest = false;
  bool isLoadingDownloadResi = false;

  AwbModel awb;

  void init({
    @required Function(TicketDetailEffect) effect,
    @required TicketDetailExtra extra,
  }) {
    _effect = effect;
    supportTicket = extra.supportTicketModel;

    refresh();
  }

  void getConvList() async {
    isLoadingGetConvList = true;
    notifyListeners();

    final apiResponse =
        await _supportTicketRepo.getSupportTicketConvList(supportTicket.id);

    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      convList.clear();
      apiResponse.response.data.forEach(
          (data) => convList.add(SupportTicketConvModel.fromJson(data)));
      convList = convList.reversed.toList();
    } else {
      _effect.call(CheckApi(apiResponse));
    }

    isLoadingGetConvList = false;
    notifyListeners();
  }

  void getSupportTicketDetail() async {
    isLoadingGetTicket = true;
    notifyListeners();

    final apiResponse =
        await _supportTicketRepo.getSupportTicketById(supportTicket.id);

    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      supportTicket = SupportTicketModel.fromJson(apiResponse.response.data);
    } else {
      _effect.call(CheckApi(apiResponse));
    }

    isLoadingGetTicket = false;
    notifyListeners();
  }

  void _getAwb() async {
    final apiResponse = await _supportTicketRepo.getAwb(supportTicket.id);

    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      awb = AwbModel.fromJson(apiResponse.response.data['message']);
    } else {
      _effect.call(CheckApi(apiResponse));
    }

    isLoadingGetTicket = false;
    notifyListeners();
  }

  void sendMessage(String comment) async {
    if (comment.isEmpty) return;

    isLoadingSendComment = true;
    notifyListeners();

    final body = SupportTicketCommentBody(supportTicket.id, comment);
    final apiResponse = await _supportTicketRepo.sendSupportTicketComment(body);

    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      refresh();
    } else {
      _effect.call(CheckApi(apiResponse));
    }

    isLoadingSendComment = false;
    notifyListeners();
  }

  void refresh() {
    getSupportTicketDetail();
    getConvList();
    _getAwb();
  }

  void pickUpRequest() async {
    isLoadingPickUpRequest = true;
    notifyListeners();

    final body = PickUpRequestBody(supportTicket.id, supportTicket.orderId);
    final apiResponse = await _supportTicketRepo.pickUpRequest(body);

    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      refresh();
    } else {
      _effect.call(CheckApi(apiResponse));
    }

    isLoadingPickUpRequest = false;
    notifyListeners();
  }

  void generateResi() async {
    isLoadingDownloadResi = true;
    notifyListeners();

    final apiResponse = await _supportTicketRepo.generateResi(supportTicket.id);

    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      final pdfUrl = apiResponse.response.data['pdf_url'];
      await _downloadFile(pdfUrl);
    } else {
      _effect.call(CheckApi(apiResponse));
    }

    isLoadingDownloadResi = false;
    notifyListeners();
  }

  Future<void> _downloadFile(String pdfUrl) async {
    final downloadPath = await getDownloadPath();
    final savePath =
        '$downloadPath/${awb.ordersId}-${awb.referenceNo}-${awb.awbNo}.pdf';
    final apiResponse = await _supportTicketRepo.downloadFile(pdfUrl, savePath);

    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      _effect.call(ShowSnackbar(
        message: 'Resi downloaded here : $savePath',
        isError: false,
      ));
    } else {
      _effect.call(CheckApi(apiResponse));
    }
  }

  Future<String> getDownloadPath() async {
    Directory directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }
}
