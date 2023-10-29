import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/view/screen/support/ticket_detail/ticket_detail_extra.dart';
import 'package:flutter_rekret_ecommerce/view/screen/support/ticket_detail/ticket_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/model/response/support_ticket_model.dart';
import '../../../di_container.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/support_ticket_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../basewidget/custom_expanded_app_bar.dart';
import '../../basewidget/no_internet_screen.dart';
import 'issue_type_screen.dart';

class SupportTicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          sl<SupportTicketProvider>()..getSupportTicketList(context),
      child: SupportTicketView(),
    );
  }
}

class SupportTicketView extends StatelessWidget {
  const SupportTicketView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomExpandedAppBar(
      title: getTranslated('support_ticket', context),
      isGuestCheck: true,
      bottomChild: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => IssueTypeScreen())),
        child: Material(
          color: ColorResources.getColombiaBlue(context),
          elevation: 5,
          borderRadius: BorderRadius.circular(50),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: BoxDecoration(
                color: ColorResources.getFloatingBtn(context),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white, size: 35),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Text(getTranslated('new_ticket', context),
                  style: titilliumSemiBold.copyWith(
                      color: Colors.white,
                      fontSize: Dimensions.FONT_SIZE_LARGE)),
            ),
          ]),
        ),
      ),
      child: Provider.of<SupportTicketProvider>(context).supportTicketList !=
              null
          ? Provider.of<SupportTicketProvider>(context)
                      .supportTicketList
                      .length !=
                  0
              ? Consumer<SupportTicketProvider>(
                  builder: (context, support, child) {
                    List<SupportTicketModel> supportTicketList =
                        support.supportTicketList.reversed.toList();
                    return RefreshIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                      onRefresh: () async {
                        await support.getSupportTicketList(context);
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                        itemCount: supportTicketList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TicketDetailScreen(
                                    extra: TicketDetailExtra(
                                      supportTicketList[index],
                                    ),
                                  ),
                                ),
                              );
                              context
                                  .read<SupportTicketProvider>()
                                  .getSupportTicketList(context);
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              margin: EdgeInsets.only(
                                  bottom: Dimensions.PADDING_SIZE_SMALL),
                              decoration: BoxDecoration(
                                color: ColorResources.getImageBg(context),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: ColorResources.getSellerTxt(context),
                                    width: 2),
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Place date: ${supportTicketList[index].createdAt}',
                                      style: titilliumRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL),
                                    ),
                                    Text(supportTicketList[index].subject,
                                        style: titilliumSemiBold),
                                    Row(children: [
                                      Icon(Icons.notifications,
                                          color: ColorResources.getPrimary(
                                              context),
                                          size: 20),
                                      SizedBox(
                                          width: Dimensions.PADDING_SIZE_SMALL),
                                      Expanded(
                                          child: Text(
                                              supportTicketList[index].type,
                                              style: titilliumSemiBold)),
                                      TextButton(
                                        onPressed: null,
                                        style: TextButton.styleFrom(
                                          backgroundColor: supportTicketList[
                                                          index]
                                                      .status ==
                                                  '1'
                                              ? ColorResources.getGreen(context)
                                              : Theme.of(context).primaryColor,
                                        ),
                                        child: Text(
                                          supportTicketList[index].status == '0'
                                              ? getTranslated(
                                                  'pending', context)
                                              : supportTicketList[index].status,
                                          style: titilliumSemiBold.copyWith(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ]),
                                  ]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              : NoInternetOrDataScreen(isNoInternet: false)
          : SupportTicketShimmer(),
    );
  }
}

class SupportTicketShimmer extends StatelessWidget {
  final int itemCount;

  const SupportTicketShimmer({Key key, this.itemCount = 10}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: ColorResources.IMAGE_BG,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorResources.SELLER_TXT, width: 2),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled:
                Provider.of<SupportTicketProvider>(context).supportTicketList ==
                    null,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(height: 10, width: 100, color: ColorResources.WHITE),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Container(height: 15, color: ColorResources.WHITE),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Row(children: [
                Container(height: 15, width: 15, color: ColorResources.WHITE),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                Container(height: 15, width: 50, color: ColorResources.WHITE),
                Expanded(child: SizedBox.shrink()),
                Container(height: 30, width: 70, color: ColorResources.WHITE),
              ]),
            ]),
          ),
        );
      },
    );
  }
}
