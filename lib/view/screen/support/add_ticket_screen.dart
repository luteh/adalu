import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/model/body/support_ticket_body.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/support_ticket_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../basewidget/button/custom_button.dart';
import '../../basewidget/custom_expanded_app_bar.dart';
import '../../basewidget/show_custom_snakbar.dart';
import '../../basewidget/textfield/custom_textfield.dart';
import 'return_product_form.dart';

class AddTicketScreen extends StatefulWidget {
  final String type;
  AddTicketScreen({@required this.type});

  @override
  _AddTicketScreenState createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _subjectNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    context
        .read<SupportTicketProvider>()
        .getOrderDeliveredList(context, widget.type);
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    _subjectNode.dispose();
    _descriptionNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomExpandedAppBar(
      title: getTranslated('support_ticket', context),
      isGuestCheck: true,
      child: Selector<SupportTicketProvider, bool>(
        selector: (context, provider) {
          return provider.isLoadingOrderDelivered;
        },
        builder: (context, isLoadingOrderDelivered, child) {
          if (isLoadingOrderDelivered) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            children: [
              Text(getTranslated('add_new_ticket', context),
                  style: titilliumSemiBold.copyWith(fontSize: 20)),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              Container(
                color: ColorResources.getLowGreen(context),
                margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
                child: ListTile(
                  leading: Icon(Icons.query_builder,
                      color: ColorResources.getPrimary(context)),
                  title: Text(widget.type, style: robotoBold),
                  onTap: () {},
                ),
              ),
              Builder(builder: (context) {
                if (widget.type == 'Return') {
                  return ReturnProductForm();
                }

                return CustomTextField(
                  focusNode: _subjectNode,
                  nextNode: _descriptionNode,
                  textInputAction: TextInputAction.next,
                  hintText: getTranslated('write_your_subject', context),
                  controller: _subjectController,
                );
              }),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              CustomTextField(
                focusNode: _descriptionNode,
                textInputAction: TextInputAction.newline,
                hintText: getTranslated('issue_description', context),
                textInputType: TextInputType.multiline,
                controller: _descriptionController,
                maxLine: 5,
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              Selector<SupportTicketProvider, bool>(
                builder: (context, isLoading, child) {
                  return isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor)))
                      : Builder(
                          key: _scaffoldKey,
                          builder: (context) => CustomButton(
                              buttonText: getTranslated('submit', context),
                              onTap: () {
                                if (widget.type == 'Return') {
                                  sendSupportTicketReturn();
                                  return;
                                }

                                if (_subjectController.text.isEmpty) {
                                  showCustomSnackBar(
                                      'Subject box should not be empty',
                                      context);
                                } else if (_descriptionController
                                    .text.isEmpty) {
                                  showCustomSnackBar(
                                      'Description box should not be empty',
                                      context);
                                } else {
                                  SupportTicketBody supportTicketModel =
                                      SupportTicketBody(
                                          widget.type,
                                          _subjectController.text,
                                          _descriptionController.text);
                                  context
                                      .read<SupportTicketProvider>()
                                      .sendSupportTicket(
                                          supportTicketModel, callback);
                                }
                              }),
                        );
                },
                selector: (context, provider) {
                  return provider.isLoading;
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void callback(bool isSuccess, String message) {
    print(message);
    if (isSuccess) {
      _subjectController.text = '';
      _descriptionController.text = '';
      Navigator.of(context).pop();
    } else {}
  }

  void sendSupportTicketReturn() {
    final provider = context.read<SupportTicketProvider>();
    if (provider.selectedOrderId == null) {
      showCustomSnackBar(
          'Order ID box should not be empty', _scaffoldKey.currentContext);
      return;
    }
    if (provider.refundProducts.isEmpty) {
      showCustomSnackBar(
          'Product box should not be empty', _scaffoldKey.currentContext);
      return;
    }
    if (provider.videoFile == null) {
      showCustomSnackBar(
          'Video File box should not be empty', _scaffoldKey.currentContext);
      return;
    }
    if (_descriptionController.text.isEmpty) {
      showCustomSnackBar(
          'Description box should not be empty', _scaffoldKey.currentContext);
      return;
    }
    context.read<SupportTicketProvider>().sendSupportTicketReturn(
      _descriptionController.text,
      onSuccess: (String message) {
        showCustomSnackBar(
          message,
          context,
          isError: false,
        );
        _descriptionController.text = '';
        Navigator.of(context).pop();
      },
      onError: (String message) {
        showCustomSnackBar(message, _scaffoldKey.currentContext);
      },
    );
  }
}
