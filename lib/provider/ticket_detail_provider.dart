import 'package:flutter/material.dart';

import '../data/model/body/support_ticket_comment_body.dart';
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

  void init({
    @required Function(TicketDetailEffect) effect,
    @required TicketDetailExtra extra,
  }) {
    _effect = effect;
    supportTicket = extra.supportTicketModel;

    getConvList();
    getSupportTicketDetail();
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

  void sendMessage(String comment) async {
    if (comment.isEmpty) return;

    isLoadingSendComment = true;
    notifyListeners();

    final body = SupportTicketCommentBody(supportTicket.id, comment);
    final apiResponse = await _supportTicketRepo.sendSupportTicketComment(body);

    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      getConvList();
      getSupportTicketDetail();
    } else {
      _effect.call(CheckApi(apiResponse));
    }

    isLoadingSendComment = false;
    notifyListeners();
  }

  void refresh() {
    getSupportTicketDetail();
    getConvList();
  }
}
