import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rekret_ecommerce/bloc/shipping_partner/shipping_partner_bloc.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/checkout/courier.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/checkout/service_courier.dart';
import 'package:flutter_rekret_ecommerce/helper/price_converter.dart';
import 'package:flutter_rekret_ecommerce/utill/color_resources.dart';
import 'package:flutter_rekret_ecommerce/utill/custom_themes.dart';
import 'package:flutter_rekret_ecommerce/utill/dimensions.dart';
import 'package:flutter_rekret_ecommerce/view/screen/checkout/widget/radio_list_tile_service.dart';

import '../../../../data/model/response/cart_model.dart';

class ListTileCourier extends StatelessWidget {
  final Courier courier;
  final String subtitle;
  final bool isSelected;
  final Widget serviceSelected;
  final ShippingPartnerBloc shippingPartnerBloc;
  final String districtId;
  final List<CartModel> cartList;

  ListTileCourier({
    @required this.courier,
    @required this.subtitle,
    @required this.isSelected,
    this.serviceSelected,
    @required this.shippingPartnerBloc,
    @required this.districtId,
    @required this.cartList,
  });

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return Column(
        children: [
          InkWell(
            onTap: () {
              shippingPartnerBloc.add(SelectCourierShippingPartnerEvent(
                  courier, districtId, cartList));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(
                    width: 5,
                    color: (isSelected)
                        ? Theme.of(context).primaryColor
                        : Colors.black26),
                top: BorderSide(width: 1, color: Colors.black12),
              )),
              child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pilih Services", style: titilliumSemiBold),
                            if (serviceSelected != null) serviceSelected,
                            if (serviceSelected == null)
                              Text(subtitle, style: titilliumRegular),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(Icons.check, color: Theme.of(context).primaryColor)
                    ],
                  )),
            ),
          ),
          BlocBuilder<ShippingPartnerBloc, ShippingPartnerState>(
            bloc: shippingPartnerBloc,
            builder: (context, ShippingPartnerState shippingPartnerState) {
              if (shippingPartnerState.courierSelected != null) {
                if (shippingPartnerState.isLoading) {
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: CircularProgressIndicator(
                          key: Key(''),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor)));
                } else {
                  List<Widget> listWidget = [];
                  int value;
                  int index = 0;
                  for (ServiceCourier serviceCourier
                      in shippingPartnerState.listServiceCourier) {
                    if (shippingPartnerState.serviceCourierSelected != null) {
                      if (shippingPartnerState
                          .serviceCourierSelected.serviceTypeName
                          .contains(serviceCourier.serviceTypeName)) {
                        value = index;
                      }
                    }

                    listWidget.add(RadioListTileService(
                        onChanged: (value) {
                          shippingPartnerBloc.add(
                            SelectServiceCourierShippingPartnerEvent(
                              serviceCourier,
                            ),
                          );
                        },
                        groupValue: value,
                        value: index,
                        isSelected: (value == index),
                        title:
                            "${serviceCourier.serviceDesc} [${serviceCourier.serviceTypeName}] ",
                        cost: PriceConverter.convertPrice(
                            context, double.tryParse(10000.toString())),
                        estimated: ""));

                    index++;
                  }

                  return Column(
                    children: listWidget,
                  );
                }
              }

              return Container();
            },
          )
        ],
      );
    } else {
      return InkWell(
        onTap: () {
          shippingPartnerBloc.add(SelectCourierShippingPartnerEvent(
            courier,
            districtId,
            cartList,
          ));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
            left: BorderSide(
                width: 5,
                color: (isSelected)
                    ? Theme.of(context).primaryColor
                    : Colors.black26),
            top: BorderSide(width: 1, color: Colors.black12),
          )),
          child: Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pilih Services", style: titilliumSemiBold),
                        if (serviceSelected != null) serviceSelected,
                        if (serviceSelected == null)
                          Text(subtitle, style: titilliumRegular),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(Icons.check, color: Theme.of(context).primaryColor)
                ],
              )),
        ),
      );
    }
  }
}
