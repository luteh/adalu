import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_rekret_ecommerce/data/model/body/MessageBody.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/chat_model.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/seller_model.dart';

import 'package:flutter_rekret_ecommerce/provider/chat_provider.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';
import 'package:flutter_rekret_ecommerce/utill/color_resources.dart';
import 'package:flutter_rekret_ecommerce/utill/custom_themes.dart';
import 'package:flutter_rekret_ecommerce/utill/dimensions.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_rekret_ecommerce/view/screen/chat/widget/message_bubble.dart';
import 'package:flutter_rekret_ecommerce/view/screen/seller/seller_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  final SellerModel seller;

  ChatScreen({@required this.seller});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ImagePicker picker = ImagePicker();

  final TextEditingController _controller = TextEditingController();

  String token = "";

  Future getData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString(AppConstants.TOKEN);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    // _getJabatanList();
  }

  String selectedValue = "";

  bool isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    if (isFirstTime) {
      Provider.of<ChatProvider>(context, listen: false)
          .initChatList(widget.seller.shop.id, context);

      Provider.of<ChatProvider>(context, listen: false).initChatInfo(context);

      isFirstTime = false;
    }

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(children: [
        CustomAppBar(title: "Adalu Seller"),

        // Chats
        Expanded(
            child: Provider.of<ChatProvider>(context).chatList != null
                ? Provider.of<ChatProvider>(context).chatList.length != 0
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        itemCount:
                            Provider.of<ChatProvider>(context).chatList.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          List<ChatModel> chats =
                              Provider.of<ChatProvider>(context)
                                  .chatList
                                  .reversed
                                  .toList();
                          return MessageBubble(
                              chat: chats[index],
                              sellerImage: widget.seller.image,
                              onProfileTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SellerScreen(
                                            seller: widget.seller)));
                              });
                        },
                      )
                    : SizedBox.shrink()
                : ChatShimmer()),

        // Bottom TextField
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Provider.of<ChatProvider>(context).imageFile != null ? Padding(
              padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.file(Provider.of<ChatProvider>(context).imageFile, height: 70, width: 70, fit: BoxFit.cover),
                  Positioned(
                    top: -2, right: -2,
                    child: InkWell(
                      onTap: () => Provider.of<ChatProvider>(context, listen: false).removeImage(_controller.text),
                      child: Icon(Icons.cancel, color: ColorResources.WHITE),
                    ),
                  ),
                ],
              ),
            ) : SizedBox.shrink(),*/

            SizedBox(
              height: 100,
              child: Card(
                color: Theme.of(context).accentColor,
                shadowColor: Colors.grey[200],
                elevation: 2,
                margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(children: [
                    Expanded(
                      child: DropdownSearch<String>(
                        showSelectedItems: false,
                        dropdownSearchDecoration:
                            InputDecoration(label: Text("Select Topic")),
                        mode: Mode.DIALOG,
                        onChanged: (String newText) {
                          if (newText.isNotEmpty &&
                              !Provider.of<ChatProvider>(context, listen: false)
                                  .isSendButtonActive) {
                            Provider.of<ChatProvider>(context, listen: false)
                                .toggleSendButtonActivity();

                            if (Provider.of<ChatProvider>(context,
                                    listen: false)
                                .isSendButtonActive) {
                              MessageBody messageBody = MessageBody(
                                  sellerId: widget.seller.id.toString(),
                                  shopId: widget.seller.shop.id.toString(),
                                  message: newText);
                              Provider.of<ChatProvider>(context, listen: false)
                                  .sendMessage(messageBody, context);
                              // selectedValue = '';
                            }
                          } else if (newText.isEmpty &&
                              Provider.of<ChatProvider>(context, listen: false)
                                  .isSendButtonActive) {
                            Provider.of<ChatProvider>(context, listen: false)
                                .toggleSendButtonActivity();
                          }
                        },
                        onFind: (text) async {
                          Map<String, String> requestHeaders = {
                            'Authorization': 'Bearer ' + token
                          };
                          var response = await http.get(
                            Uri.parse(
                              AppConstants.BASE_URL +
                                  AppConstants.CHAT_DIALOG_BUYER,
                            ),
                            headers: requestHeaders,
                          );

                          if (response.statusCode != 200) {
                            return [];
                          }
                          if (response.body == '[]') {
                            return [];
                          }

                          List<dynamic> allDialog = json.decode(response.body);
                          List<String> allNameDialog = [];

                          if (allDialog != null) {
                            allDialog.forEach((element) {
                              allNameDialog.add(element["chat_questions_text"]);
                            });
                          }

                          return allNameDialog;
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (Provider.of<ChatProvider>(context, listen: false)
                            .isSendButtonActive) {
                          MessageBody messageBody = MessageBody(
                              sellerId: widget.seller.id.toString(),
                              shopId: widget.seller.shop.id.toString(),
                              message: selectedValue);
                          Provider.of<ChatProvider>(context, listen: false)
                              .sendMessage(messageBody, context);
                          selectedValue = '';
                        }
                      },
                      child: Icon(
                        Icons.send,
                        color: Provider.of<ChatProvider>(context)
                                .isSendButtonActive
                            ? Theme.of(context).primaryColor
                            : ColorResources.HINT_TEXT_COLOR,
                        size: Dimensions.ICON_SIZE_DEFAULT,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class ChatShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      shrinkWrap: true,
      reverse: true,
      itemBuilder: (context, index) {
        bool isMe = index % 2 == 0;
        return Shimmer.fromColors(
          baseColor: isMe ? Colors.grey[300] : ColorResources.IMAGE_BG,
          highlightColor: isMe
              ? Colors.grey[100]
              : ColorResources.IMAGE_BG.withOpacity(0.9),
          enabled: Provider.of<ChatProvider>(context).chatList == null,
          child: Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              isMe
                  ? SizedBox.shrink()
                  : InkWell(child: CircleAvatar(child: Icon(Icons.person))),
              Expanded(
                child: Container(
                  margin: isMe
                      ? EdgeInsets.fromLTRB(50, 5, 10, 5)
                      : EdgeInsets.fromLTRB(10, 5, 50, 5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft:
                            isMe ? Radius.circular(10) : Radius.circular(0),
                        bottomRight:
                            isMe ? Radius.circular(0) : Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: isMe
                          ? ColorResources.IMAGE_BG
                          : ColorResources.WHITE),
                  child: Container(height: 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
