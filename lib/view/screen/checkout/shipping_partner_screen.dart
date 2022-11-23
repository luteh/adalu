import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rekret_ecommerce/bloc/shipping_partner/shipping_partner_bloc.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/checkout/courier.dart';
import 'package:flutter_rekret_ecommerce/localization/language_constrants.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_rekret_ecommerce/view/screen/checkout/widget/list_tile_courier.dart';

class ShippingPartnerScreen extends StatefulWidget {
  final ShippingPartnerBloc shippingPartnerBloc;
  final String disrictId;

  ShippingPartnerScreen(this.shippingPartnerBloc, this.disrictId);

  @override
  _ShippingPartnerScreenState createState() => _ShippingPartnerScreenState();
}

class _ShippingPartnerScreenState extends State<ShippingPartnerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ShippingPartnerBloc, ShippingPartnerState>(
          bloc: widget.shippingPartnerBloc,
          builder: (context, ShippingPartnerState shippingPartnerState) {
            print(shippingPartnerState.listCourier);
            return Column(children: [
              CustomAppBar(title: getTranslated('shipping_partner', context)),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  decoration:
                      BoxDecoration(color: Theme.of(context).accentColor),
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 1),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      Courier courier = shippingPartnerState.listCourier[index];
                      bool isSelected =
                          (shippingPartnerState.courierSelected != null)
                              ? (shippingPartnerState
                                      .courierSelected.serviceTypeCode
                                      .contains(courier.serviceTypeCode))
                                  ? true
                                  : false
                              : false;

                      return ListTileCourier(
                          courier: courier,
                          subtitle: "Please choose service courier",
                          isSelected: isSelected,
                          shippingPartnerBloc: widget.shippingPartnerBloc,
                          districtId: widget.disrictId);
                    },
                  ),
                ),
              )
            ]);
          },
        ),
        bottomNavigationBar:
            BlocBuilder<ShippingPartnerBloc, ShippingPartnerState>(
          bloc: widget.shippingPartnerBloc,
          builder: (context, ShippingPartnerState shippingPartnerState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.black12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: Offset(2, 0),
                  )
                ],
              ),
              padding: EdgeInsets.all(10),
              child: CustomButton(
                buttonText: getTranslated('select_shipping_partner', context),
                onTap: (!shippingPartnerState.isLoading &&
                        shippingPartnerState.courierSelected != null)
                    ? () {
                        Navigator.pop(context);
                        // print("test");
                      }
                    : null,
              ),
            );
          },
        ));
  }
}
