import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rekret_ecommerce/bloc/track_order/track_order_bloc.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/track_order.dart';

import 'package:flutter_rekret_ecommerce/localization/language_constrants.dart';
import 'package:flutter_rekret_ecommerce/utill/color_resources.dart';
import 'package:flutter_rekret_ecommerce/utill/custom_themes.dart';
import 'package:flutter_rekret_ecommerce/utill/dimensions.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/textfield/custom_textfield.dart';
import 'package:flutter_rekret_ecommerce/view/screen/tracking/tracking_result_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TrackingScreen extends StatefulWidget {
  final String orderID;
  TrackingScreen({@required this.orderID});

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final TextEditingController _orderIdController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  TrackOrderBloc trackOrderBloc;
  final sl = GetIt.instance;
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  void initState() {
    _orderIdController.text = widget.orderID;

    trackOrderBloc = new TrackOrderBloc(sl());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => this.trackOrderBloc,
      child: Scaffold(
        key: _globalKey,
        backgroundColor: ColorResources.getIconBg(context),
        body: BlocListener<TrackOrderBloc, TrackOrderState>(
          bloc: this.trackOrderBloc,
          listener: (context, TrackOrderState trackOrderState) {
            if (trackOrderState is TrackOrderStateFailure) {
              _btnController.stop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(trackOrderState.message), backgroundColor: Colors.red));
            }

            if (!trackOrderState.isLoading) {
              if (trackOrderState.trackOrder != null) {
                print(trackOrderState.trackOrder.toJson());
                _btnController.stop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrackingResultScreen(trackOrderState.trackOrder)));
              }
            }
          },
          child: BlocBuilder<TrackOrderBloc, TrackOrderState>(
            bloc: this.trackOrderBloc,
            builder: (context, TrackOrderState trackOrderState) {
              return Column(
                children: [
                  CustomAppBar(title: getTranslated('TRACKING', context)),
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Image.asset(
                                'assets/images/onboarding_image_one.png',
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.35,
                              ),
                              SizedBox(height: 50),

                              Text(getTranslated('TRACK_ORDER', context), style: robotoBold),
                              Stack(children: [
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  margin: EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
                                  color: ColorResources.colorMap[50],
                                ),
                                Container(
                                  width: 70,
                                  height: 1,
                                  margin: EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
                                  decoration: BoxDecoration(color: ColorResources.getPrimary(context), borderRadius: BorderRadius.circular(1)),
                                ),
                              ]),
                              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                              CustomTextField(
                                hintText: getTranslated('TRACK_ID', context),
                                textInputType: TextInputType.number,
                                readOnly: true,
                                controller: _orderIdController,
                                textInputAction: TextInputAction.done,
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                              RoundedLoadingButton(
                                child: Text(getTranslated('TRACK', context), style: titilliumSemiBold.copyWith(
                                  fontSize: 16,
                                  color: Theme.of(context).accentColor,
                                )),
                                color: Theme.of(context).primaryColor,
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                borderRadius: (trackOrderState.isLoading) ? 100 : 10,
                                controller: _btnController,
                                onPressed: () {
                                  if (_orderIdController.text.isNotEmpty) {
                                    trackOrderBloc.add(InitialTrackOrderEvent(_orderIdController.text));
                                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrackingResultScreen(orderID: _orderIdController.text)));
                                  }else {
                                    _globalKey.currentState.showSnackBar(SnackBar(content: Text('Insert track ID'), backgroundColor: Colors.red));
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          )
        ),
      ),
    );
  }
}