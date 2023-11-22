import 'package:flutter/material.dart';

import '../../../../data/model/response/base/api_response.dart';

abstract class TicketDetailEffect {}

class ShowSnackbar extends TicketDetailEffect {
  final String message;
  final bool isError;

  ShowSnackbar({
    @required this.message,
    this.isError = true,
  });
}

class CheckApi extends TicketDetailEffect {
  final ApiResponse apiResponse;

  CheckApi(this.apiResponse);
}
