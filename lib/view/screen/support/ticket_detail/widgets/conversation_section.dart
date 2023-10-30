import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/ticket_detail_provider.dart';
import '../../../../../utill/color_resources.dart';
import '../../../../../utill/custom_themes.dart';
import '../../../../../utill/dimensions.dart';
import '../../../../basewidget/no_internet_screen.dart';

class ConversationSection extends StatelessWidget {
  const ConversationSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<TicketDetailProvider, bool>(
      selector: (context, provider) {
        return provider.isLoadingGetConvList;
      },
      builder: (context, isLoadingGetConvList, child) {
        final convList = context.read<TicketDetailProvider>().convList;
        if (convList.isEmpty) {
          return Center(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: NoInternetOrDataScreen(
                isNoInternet: false,
              ),
            ),
          );
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          itemCount: convList.length,
          reverse: true,
          itemBuilder: (context, index) {
            final data = convList[index];
            bool isMe = data.isMe;

            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    margin: isMe
                        ? EdgeInsets.fromLTRB(50, 5, 5, 5)
                        : EdgeInsets.fromLTRB(5, 5, 50, 5),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
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
                          ? ColorResources.getImageBg(context)
                          : Theme.of(context).colorScheme.secondary,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          data.userName,
                          style: titilliumRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            fontWeight: FontWeight.bold,
                            color: ColorResources.getSellerTxt(context),
                          ),
                        ),
                        Text(
                          data.message,
                          style: titilliumRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          ),
                        ),
                        Text(
                          data.createdAt,
                          style: titilliumRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                            color: ColorResources.getHint(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
