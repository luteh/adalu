part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {}

class GetServiceFeeEvent extends CheckoutEvent {
  final OrderPlaceModel orderPlaceModel;

  GetServiceFeeEvent(this.orderPlaceModel);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class InitialCheckoutEvent extends CheckoutEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UpdateCheckoutEvent extends CheckoutEvent {
  final PaymentProcess paymentProcess;
  final ServiceFee serviceFee;
  final bool isLoading;
  final OrderPlaceModel orderPlaceModel;
  final bool isPaymentProcess;
  final bool isPaymentError;
  final String messagePaymentError;
  final double couponVoucher;
  final double insuranceAmount;

  UpdateCheckoutEvent({
    this.paymentProcess,
    this.serviceFee,
    this.isLoading = false,
    this.orderPlaceModel,
    this.isPaymentProcess = false,
    this.isPaymentError = false,
    this.messagePaymentError,
    this.couponVoucher,
    this.insuranceAmount,
  });

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RemoveServiceFeeLoadedEvent extends CheckoutEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ProcessPaymentEvent extends CheckoutEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CouponVoucherEvent extends CheckoutEvent {
  final double couponVoucher;

  CouponVoucherEvent(this.couponVoucher);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class InsuranceAmount extends CheckoutEvent {
  final double insuranceAmount;

  InsuranceAmount(this.insuranceAmount);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
