import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../data/model/response/awb_model.dart';
import '../../../../../localization/language_constrants.dart';
import '../../../../../provider/ticket_detail_provider.dart';
import '../../../../../utill/color_resources.dart';
import '../../../../../utill/custom_themes.dart';
import '../../../../../utill/dimensions.dart';
import '../../../../basewidget/button/custom_button.dart';

class DetailSection extends StatelessWidget {
  const DetailSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<TicketDetailProvider, bool>(
      selector: (context, provider) {
        return provider.isLoadingGetTicket;
      },
      builder: (context, isLoadingGetTicket, child) {
        if (isLoadingGetTicket) {
          return _detailShimmer();
        }

        final supportTicket =
            context.read<TicketDetailProvider>().supportTicket;

        return Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                  color: ColorResources.getImageBg(context),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: ColorResources.getSellerTxt(context), width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Place date: ${supportTicket.createdAt}',
                      style: titilliumRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_SMALL,
                      ),
                    ),
                    Text(
                      supportTicket.subject,
                      style: titilliumSemiBold,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.notifications,
                          color: ColorResources.getPrimary(context),
                          size: 20,
                        ),
                        SizedBox(
                          width: Dimensions.PADDING_SIZE_SMALL,
                        ),
                        Expanded(
                          child: Text(
                            supportTicket.type,
                            style: titilliumSemiBold,
                          ),
                        ),
                        TextButton(
                          onPressed: null,
                          style: TextButton.styleFrom(
                            backgroundColor: supportTicket.status == '1'
                                ? ColorResources.getGreen(context)
                                : Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            supportTicket.status == '0'
                                ? getTranslated('pending', context)
                                : supportTicket.status,
                            style: titilliumSemiBold.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Selector<TicketDetailProvider, AwbModel>(
                      selector: (context, provider) {
                        return provider.awb;
                      },
                      builder: (context, awb, child) {
                        if (awb == null) {
                          return SizedBox.shrink();
                        }

                        return Text(
                          'Reference No : ${awb.referenceNo}',
                          style: titilliumRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Builder(builder: (context) {
                if (supportTicket.type.toLowerCase() != 'return' ||
                    supportTicket.status.toLowerCase() != 'approve') {
                  return SizedBox.shrink();
                }
                return Padding(
                  padding: EdgeInsets.only(
                    top: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: Selector<TicketDetailProvider, AwbModel>(
                    selector: (context, provider) {
                      return provider.awb;
                    },
                    builder: (context, awb, child) {
                      return Selector<TicketDetailProvider, bool>(
                        selector: (context, provider) {
                          return provider.isLoadingDownloadResi;
                        },
                        builder: (context, isLoadingDownloadResi, child) {
                          if (isLoadingDownloadResi) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return CustomButton(
                            buttonText: awb == null
                                ? 'Pick Up Request'
                                : 'Download Pick Up Resi',
                            onTap: awb == null
                                ? context
                                    .read<TicketDetailProvider>()
                                    .pickUpRequest
                                : context
                                    .read<TicketDetailProvider>()
                                    .generateResi,
                          );
                        },
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _detailShimmer() {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: ColorResources.IMAGE_BG,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorResources.SELLER_TXT, width: 2),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
  }
}
