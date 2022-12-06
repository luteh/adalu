import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rekret_ecommerce/data/model/body/order_place_model.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/cart_model.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/service_fee.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/payment_process.dart';
import 'package:flutter_rekret_ecommerce/data/repository/checkout_repo.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckoutRepo checkoutRepo;

  CheckoutBloc(this.checkoutRepo) : super(CheckoutInitial());

  @override
  Stream<CheckoutState> mapEventToState(CheckoutEvent event) async* {
    if (event is GetServiceFeeEvent) {
      yield* _getServiceFeeEvent(event);
    } else if (event is UpdateCheckoutEvent) {
      yield state.copyWith(
        isLoading: event.isLoading,
        paymentProcess: event.paymentProcess,
        serviceFee: event.serviceFee,
        orderPlaceModel: event.orderPlaceModel,
        isPaymentProcess: event.isPaymentProcess,
        isPaymentError: event.isPaymentError,
        messagePaymentError: event.messagePaymentError,
        couponVouher: event.couponVoucher,
        insuranceAmount: event.insuranceAmount,
      );
    } else if (event is RemoveServiceFeeLoadedEvent) {
      add(
        UpdateCheckoutEvent(
          isLoading: false,
          serviceFee: null,
        ),
      );
    } else if (event is ProcessPaymentEvent) {
      yield* _processPaymentEvent();
    } else if (event is CouponVoucherEvent) {
      add(
        UpdateCheckoutEvent(
          couponVoucher: event.couponVoucher,
          serviceFee: state.serviceFee,
          orderPlaceModel: state.orderPlaceModel.copyWith(
            discount: event.couponVoucher,
          ),
        ),
      );
    } else if (event is InsuranceAmount) {
      add(
        UpdateCheckoutEvent(
          insuranceAmount: event.insuranceAmount,
          serviceFee: state.serviceFee,
          orderPlaceModel:
              state.orderPlaceModel.copyWith(discount: event.insuranceAmount),
        ),
      );
    }
  }

  Stream<CheckoutState> _processPaymentEvent() async* {
    yield state.copyWith(
      isPaymentProcess: true,
      serviceFee: state.serviceFee,
      orderPlaceModel: state.orderPlaceModel,
    );
    List<Cart> listCart = [];
    List<Variation> listVariation = [];
    state.orderPlaceModel.cart.forEach(
      (Cart cart) {
        cart.variation.forEach(
          (Variation variation) {
            listVariation.add(
              variation.copyWith(type: 'Black'),
            );
          },
        );

        listCart.add(cart.copyWith(variant: 'Black', variation: listVariation));
      },
    );

    Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart'] = listCart.map((v) => v.toJson()).toList();
    data['coupon_discount'] = state.orderPlaceModel.discount;
    data['address_id'] = state.orderPlaceModel.customerInfo.addressId;
    data['courier'] = state.orderPlaceModel.courier.serviceTypeCode;
    data['shipping_code'] = state.orderPlaceModel.courier.serviceTypeCode;
    data['shipping_name'] =
        "${state.orderPlaceModel.courier.serviceTypeName} - ${state.orderPlaceModel.serviceCourier.serviceDesc}"; //state.orderPlaceModel.serviceCourier.service;
    data['total_shipment_fee'] = state.serviceFee.shipmentNominal.toString();
    data['insurance'] = state.insuranceAmount;

    print('payment data:  $data');

    ApiResponse apiResponse = await checkoutRepo.postPaymentProcess(data);

    if (apiResponse.response != null) {
      PaymentProcess paymentProcess =
          PaymentProcess.fromJson(apiResponse.response.data);
      print('URL : ${paymentProcess.data}');
      print('RESPONSE : ${apiResponse.toString()}');

      /// TODO : Success
      add(UpdateCheckoutEvent(
          isPaymentProcess: false,
          serviceFee: state.serviceFee,
          paymentProcess: paymentProcess,
          orderPlaceModel: state.orderPlaceModel));
    } else {
      add(
        UpdateCheckoutEvent(
            isPaymentProcess: false,
            serviceFee: state.serviceFee,
            orderPlaceModel: state.orderPlaceModel,
            isPaymentError: true,
            messagePaymentError:
                apiResponse.error.toString() ?? "Failed to proceed order"),
      );
    }
  }

  Stream<CheckoutState> _getServiceFeeEvent(GetServiceFeeEvent event) async* {
    yield state.copyWith(isLoading: true);

    Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart'] = event.orderPlaceModel.toJson()['cart'];
    data['discount'] = '0';
    data['courier'] = event.orderPlaceModel.courier.serviceTypeCode;
    data['district'] = event.orderPlaceModel.districtId;
    data['service'] = event.orderPlaceModel.serviceCourier.serviceTypeCode;

    print('data: $data');

    ApiResponse apiResponse = await checkoutRepo.postServiceFee(data);

    if (apiResponse.response != null) {
      ServiceFee serviceFee = ServiceFee.fromJson(apiResponse.response.data);

      /// TODO : Success
      add(UpdateCheckoutEvent(
          isLoading: false,
          serviceFee: serviceFee,
          orderPlaceModel: event.orderPlaceModel));
      print("Sukses");
    } else {
      yield GetServiceFeeError(
          apiResponse.error.toString() ?? "Failed to calculate total order");
      add(
        UpdateCheckoutEvent(
          isLoading: false,
        ),
      );
    }
  }
}
