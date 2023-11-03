import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/address/city.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/address/district.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/address/province.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/cart_model.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/checkout/courier.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/checkout/service_courier.dart';
import 'package:flutter_rekret_ecommerce/data/repository/shipping_partner_repo.dart';
import 'package:meta/meta.dart';

part 'shipping_partner_event.dart';
part 'shipping_partner_state.dart';

class ShippingPartnerBloc
    extends Bloc<ShippingPartnerEvent, ShippingPartnerState> {
  final ShippingPartnerRepo shippingPartnerRepo;

  ShippingPartnerBloc(this.shippingPartnerRepo) : super(ShippingPartnerState());

  @override
  Stream<ShippingPartnerState> mapEventToState(
      ShippingPartnerEvent event) async* {
    if (event is InitialShippingPartnerEvent) {
      yield* _initialShippingPartnerEvent();
    } else if (event is UpdateShippingPartnerEvent) {
      yield state.copyWith(
          listServiceCourier: event.listServiceCourier,
          listCourier: event.listCourier,
          isLoading: event.isLoading,
          courierSelected: event.courierSelected,
          serviceCourierSelected: event.serviceCourierSelected,
          districtId: event.districtId);
    } else if (event is SelectCourierShippingPartnerEvent) {
      yield* _selectCourierShippingPartnerEvent(event);
    } else if (event is RemoveSelectCourierShippingPartnerEvent) {
      add(UpdateShippingPartnerEvent(
          courierSelected: null,
          serviceCourierSelected: null,
          listCourier: state.listCourier,
          districtId: state.districtId));
    } else if (event is SelectServiceCourierShippingPartnerEvent) {
      add(UpdateShippingPartnerEvent(
          courierSelected: state.courierSelected,
          serviceCourierSelected: event.serviceCourier,
          listServiceCourier: state.listServiceCourier,
          listCourier: state.listCourier,
          districtId: state.districtId));
    } else if (event is UpdateSelectShippingPartnerEvent) {
      add(UpdateShippingPartnerEvent(
          courierSelected: event.courierSelected,
          serviceCourierSelected: event.serviceCourier,
          listServiceCourier: state.listServiceCourier,
          listCourier: state.listCourier,
          districtId: state.districtId));
    }
  }

  Stream<ShippingPartnerState> _selectCourierShippingPartnerEvent(
      SelectCourierShippingPartnerEvent event) async* {
    yield state.copyWith(
        isLoading: true,
        courierSelected: event.courier,
        districtId: event.districtId);

    ApiResponse response = await this.shippingPartnerRepo.getServiceCourier(
          event.courier.serviceTypeCode,
          event.districtId,
          event.cartList,
        );

    if (response.response != null) {
      List<ServiceCourier> list =
          List.from(response.response.data['services'].map((data) {
        return ServiceCourier.fromJson(data);
      }).toList());

      add(UpdateShippingPartnerEvent(
          courierSelected: event.courier,
          listCourier: state.listCourier,
          listServiceCourier: list,
          districtId: event.districtId));
    }
  }

  Stream<ShippingPartnerState> _initialShippingPartnerEvent() async* {
    yield state.copyWith(isLoading: true);

    ApiResponse response = await this.shippingPartnerRepo.getCourier();

    if (response.response == null) {
      yield ShippingPartnerFailed(response.error.toString());
      yield state.copyWith(isLoading: false);
    } else {
      List<Courier> listCourier =
          List.from(response.response.data['services'].map((data) {
        return Courier.fromJson(data);
      }).toList());

      add(UpdateShippingPartnerEvent(
        isLoading: false,
        listCourier: listCourier,
      ));
      /*List<String> courierId = listCourier.map((e) {
        return e.idKurir;
      }).toList();

      Future.wait(courierId.map((String courierId) {
        return this.shippingPartnerRepo.getServiceCourier(courierId, event.districtId).then((ApiResponse getCourierServiceResponse) {
          if (getCourierServiceResponse.response != null) {
            List<ServiceCourier> listServiceCourier = List.from(response.response.data['list'].map((data) {
              return ServiceCourier.fromJson(data).copyWith(
                courierId: courierId
              );
            }).toList());

            return add(UpdateShippingPartnerEvent(
              isLoading: false,
              listCourier: listCourier,
              listServiceCourier: listServiceCourier
            ));
          }
        });
      }));*/
    }
  }
}
