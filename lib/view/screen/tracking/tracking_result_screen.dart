import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/track_order.dart';
import 'package:flutter_rekret_ecommerce/provider/order_provider.dart';
import 'package:flutter_rekret_ecommerce/helper/date_converter.dart';

import 'package:flutter_rekret_ecommerce/localization/language_constrants.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';
import 'package:flutter_rekret_ecommerce/utill/color_resources.dart';
import 'package:flutter_rekret_ecommerce/utill/custom_themes.dart';
import 'package:flutter_rekret_ecommerce/utill/dimensions.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/custom_loader.dart';
import 'package:flutter_rekret_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_rekret_ecommerce/view/screen/tracking/painter/line_dashed_painter.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

class TrackingResultScreen extends StatefulWidget {
  final TrackOrder trackOrder;

  TrackingResultScreen(this.trackOrder);

  @override
  _TrackingResultScreenState createState() => _TrackingResultScreenState();
}

const kTileHeight = 50.0;

class _TrackingResultScreenState extends State<TrackingResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('DELIVERY_STATUS', context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: getTranslated('ORDER_ID', context), style: titilliumRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_SMALL, color: Theme.of(context).textTheme.bodyText1.color,
                        )),
                        TextSpan(text: widget.trackOrder.orderDetails.id.toString(), style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context))),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_SMALL),
                  decoration: BoxDecoration(color: Theme.of(context).accentColor),
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Expanded(child: Text('Order Status', style: titilliumRegular)),
                        SizedBox(width: 15),
                        Expanded(child: Text(widget.trackOrder.orderDetails.orderStatus.toUpperCase(), textAlign: TextAlign.right, maxLines: 1,
                            overflow: TextOverflow.ellipsis, style: titilliumRegular.copyWith(color: ColorResources.getPrimary(context), fontSize: Dimensions.FONT_SIZE_SMALL)))
                      ]),
                      Divider(),
                      Row(children: [
                        Expanded(child: Text('Payment Status', style: titilliumRegular)),
                        SizedBox(width: 15),
                        Text(widget.trackOrder.orderDetails.paymentStatus.toUpperCase(), style: titilliumRegular.copyWith(color: ColorResources.getPrimary(context), fontSize: Dimensions.FONT_SIZE_SMALL), textAlign: TextAlign.right, maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ]),
                      Divider(),
                      Row(children: [
                        Expanded(child: Text('Shipping Methode', style: titilliumRegular)),
                        SizedBox(width: 15),
                        Text(widget.trackOrder.trackDetail.rajaongkir.result.summary.courierName.toUpperCase(), style: titilliumRegular.copyWith(color: ColorResources.getPrimary(context), fontSize: Dimensions.FONT_SIZE_SMALL), textAlign: TextAlign.right, maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ]),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: FixedTimeline.tileBuilder(
                        theme: TimelineThemeData(
                          nodePosition: 0,
                          color: Color(0xff989898),
                          indicatorTheme: IndicatorThemeData(
                            position: 0,
                            size: 25.0,
                          ),
                          connectorTheme: ConnectorThemeData(
                            thickness: 2.5,
                          ),
                        ),
                        builder: TimelineTileBuilder.connected(
                          connectionDirection: ConnectionDirection.before,
                          itemCount: widget.trackOrder.trackDetail.rajaongkir.result.manifest.length,
                          contentsBuilder: (_, index) {
                            Manifest manifest = widget.trackOrder.trackDetail.rajaongkir.result.manifest[index];
                            //if (processes[index].isCompleted) return null;

                            return Padding(
                              padding: EdgeInsets.only(left: 8.0, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(manifest.manifestDescription, style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context))),
                                  Text("${manifest.manifestDate} ${manifest.manifestTime}", style: titilliumRegular)
                                ],
                              ),
                            );
                          },
                          indicatorBuilder: (_, index) {
                            return DotIndicator(
                              color: Color(0xff66c97f),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 18.0,
                              ),
                            );
                          },
                          connectorBuilder: (context, index, connectorType) {
                            var color = Color(0xff6ad192);
                            return SolidLineConnector(
                              color: color,
                              thickness:3,
                            );
                          },
                        ),
                      )
                      /*child: FixedTimeline.tileBuilder(
                        verticalDirection: VerticalDirection.down,
                        theme: TimelineThemeData(
                          nodePosition: 0,
                          nodeItemOverlap: true,
                          connectorTheme: ConnectorThemeData(
                            color: Color(0xffe6e7e9),
                            thickness: 15.0,
                          ),
                        ),
                        builder: TimelineTileBuilder.connected(
                          connectionDirection: ConnectionDirection.before,
                          indicatorBuilder: (context, index) {
                            return OutlinedDotIndicator(
                              color: Color(0xff6ad192),
                              backgroundColor: Color(0xffd4f5d6),
                              borderWidth: 3.0,
                              child: Icon(Icons.check, size: 20, color: Color(0xff6ad192)),
                            );
                          },
                          connectorBuilder: (context, index, connectorType) {
                            var color = Color(0xff6ad192);
                            return SolidLineConnector(
                              color: color,
                              thickness:3,
                            );
                          },
                          contentsBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "OKE",
                                    style: DefaultTextStyle.of(context).style.copyWith(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Text(
                                    "OKE",
                                    style: DefaultTextStyle.of(context).style.copyWith(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Text(
                                    "OKE",
                                    style: DefaultTextStyle.of(context).style.copyWith(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Text(
                                    "OKE",
                                    style: DefaultTextStyle.of(context).style.copyWith(
                                      fontSize: 18.0,
                                    ),
                                  ),Text(
                                    "OKE",
                                    style: DefaultTextStyle.of(context).style.copyWith(
                                      fontSize: 18.0,
                                    ),
                                  ),

                                ],
                              ),
                            );

                            var height = kTileHeight - 10;
                            return SizedBox(
                              height: 50,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.red,
                                  margin: EdgeInsets.only(left: 10.0),
                                  *//*decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.0),
                                    color: Color(0xffe6e7e9),
                                  ),*//*
                                  child: Column(
                                    children: [
                                      Text("OKE")
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: widget.trackOrder.trackDetail.rajaongkir.result.manifest.length,
                        ),
                      ),*/
                    ),
                  ),
                )
              ],
            )
          )
        ]
      )
    );
  }
}

class _EmptyContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      height: 10.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: Color(0xffe6e7e9),
      ),
    );
  }
}

/*class TrackingResultScreen extends StatelessWidget {
  final String orderID;
  TrackingResultScreen({@required this.orderID});

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderProvider>(context, listen: false).initTrackingInfo(orderID, null, false, context);
    List<String> statusList = [AppConstants.PENDING, AppConstants.PROCESSING, AppConstants.PROCESSED, 'received', AppConstants.DELIVERED];


    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('DELIVERY_STATUS', context)),

          Expanded(
            child: Consumer<OrderProvider>(
              builder: (context, tracking, child) {
                String status = tracking.trackingModel != null ? tracking.trackingModel.orderStatus : '';
                DateTime date = tracking.trackingModel != null ? DateConverter.isoStringToLocalDate(tracking.trackingModel.createdAt).add(Duration(days: 7)) : DateTime.now();

                return tracking.trackingModel != null
                    ? statusList.contains(status) ? ListView(
                  physics: BouncingScrollPhysics(),
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(getTranslated('ESTIMATED_DELIVERY', context), style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
                              Text(DateConverter.estimatedDate(date), style: titilliumSemiBold.copyWith(fontSize: 20.0)),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(Dimensions.MARGIN_SIZE_DEFAULT),
                            decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // for parcel status and order id section
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(getTranslated('PARCEL_STATUS', context), style: titilliumSemiBold),
                                      RichText(
                                        text: TextSpan(
                                          text: getTranslated('ORDER_ID', context),
                                          style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                                          children: <TextSpan>[
                                            TextSpan(text: orderID, style: titilliumSemiBold),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                  color: ColorResources.getPrimary(context),
                                ),
                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                                // Steppers
                                CustomStepper(
                                    title: status == statusList[0] ? getTranslated('processing', context) : getTranslated('ORDER_PLACED_PREPARING', context),
                                    color: ColorResources.getHarlequin(context)),
                                CustomStepper(
                                    title: status == statusList[0]
                                        ? getTranslated('pending', context)
                                        : status == statusList[1] ? getTranslated('processing', context) : getTranslated('ORDER_PICKED_SENDING', context),
                                    color: ColorResources.getCheris(context)),
                                CustomStepper(
                                    title: status == statusList[0]
                                        ? getTranslated('pending', context)
                                        : status == statusList[1]
                                            ? getTranslated('pending', context)
                                            : status == statusList[2] ? getTranslated('processing', context) : getTranslated('RECEIVED_LOCAL_WAREHOUSE', context),
                                    color: ColorResources.getColombiaBlue(context)),
                                CustomStepper(
                                    title: status == statusList[0]
                                        ? getTranslated('pending', context)
                                        : status == statusList[1]
                                            ? getTranslated('pending', context)
                                            : status == statusList[2] ? getTranslated('pending', context) : status == statusList[3]
                                        ? getTranslated('processing', context) : getTranslated('DELIVERED', context),
                                    color: Theme.of(context).primaryColor,
                                    isLastItem: true),
                              ],
                            ),
                          ),
                        ],
                      )
                    : status == AppConstants.FAILED ? Center(child: Text('Failed')) : status == AppConstants.RETURNED ? Center(child: Text('Returned'))
                    : Center(child: Text('Invalid order id')) : Center(child: CustomLoader(color: Theme.of(context).primaryColor));
              },
            ),
          ),

          // for footer button
          Container(
            height: 45,
            margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            decoration: BoxDecoration(color: ColorResources.getImageBg(context), borderRadius: BorderRadius.circular(6)),
            child: TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => DashBoardScreen()), (route) => false);
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  getTranslated('ORDER_MORE', context),
                  style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.getPrimary(context)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomStepper extends StatelessWidget {
  final String title;
  final Color color;
  final bool isLastItem;
  CustomStepper({@required this.title, @required this.color, this.isLastItem = false});

  @override
  Widget build(BuildContext context) {
    Color myColor;
    if (title == getTranslated('processing', context) || title == getTranslated('pending', context)) {
      myColor = ColorResources.GREY;
    } else {
      myColor = color;
    }
    return Container(
      height: isLastItem ? 50 : 100,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                child: CircleAvatar(backgroundColor: myColor, radius: 10.0),
              ),
              Text(title, style: titilliumRegular)
            ],
          ),
          isLastItem
              ? SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL, left: Dimensions.PADDING_SIZE_LARGE),
                  child: CustomPaint(painter: LineDashedPainter(myColor)),
                ),
        ],
      ),
    );
  }
}*/
