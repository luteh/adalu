part of 'checkout_bloc.dart';

class CheckoutState {
  final PaymentProcess paymentProcess;
  final ServiceFee serviceFee;
  final bool isLoading;
  final OrderPlaceModel orderPlaceModel;
  final bool isPaymentProcess;
  final bool isPaymentError;
  final String messagePaymentError;
  final double couponVouher;
  final double insuranceAmount;

  CheckoutState({
    this.paymentProcess,
    this.serviceFee,
    this.isLoading = false,
    this.orderPlaceModel,
    this.isPaymentProcess = false,
    this.isPaymentError = false,
    this.messagePaymentError,
    this.couponVouher = 0,
    this.insuranceAmount = 0,
  });

  bool isServiceFeeLoaded() {
    return (this.serviceFee != null) ? true : false;
  }

  bool isPaymentSuccess() {
    return (this.paymentProcess != null)
        ? (this.paymentProcess.data.virtualAccount.isNotEmpty)
            ? true
            : false
        : false;
  }

  double getTotalPayment(double defaultTotalPayment) {
    return (defaultTotalPayment +
        this.insuranceAmount +
        (this.serviceFee?.shipmentNominal ?? 0) -
        (this.couponVouher));

    if (isServiceFeeLoaded()) {
      double totalNominal =
          double.tryParse(this.serviceFee.totalNominal.toString());

      return (totalNominal - this.couponVouher);
    } else {
      print("!isServiceFeeLoaded()");
      return (defaultTotalPayment - this.couponVouher);
    }
  }

  CheckoutState copyWith({
    PaymentProcess paymentProcess,
    ServiceFee serviceFee,
    bool isLoading = false,
    OrderPlaceModel orderPlaceModel,
    bool isPaymentProcess = false,
    bool isPaymentError = false,
    String messagePaymentError,
    double couponVouher,
    double insuranceAmount,
  }) {
    return CheckoutState(
      paymentProcess: paymentProcess ?? this.paymentProcess,
      serviceFee: serviceFee,
      isLoading: isLoading ?? this.isLoading,
      orderPlaceModel: orderPlaceModel,
      isPaymentProcess: isPaymentProcess ?? this.isPaymentProcess,
      isPaymentError: isPaymentError ?? this.isPaymentError,
      messagePaymentError: messagePaymentError ?? this.messagePaymentError,
      couponVouher: couponVouher ?? this.couponVouher,
      insuranceAmount: insuranceAmount ?? this.insuranceAmount,
    );
  }
}

class CheckoutInitial extends CheckoutState {
  @override
  List<Object> get props => [];
}

class CheckoutError extends CheckoutState {
  final String message;

  CheckoutError(this.message);
}

class GetServiceFeeError extends CheckoutState {
  final String message;

  GetServiceFeeError(this.message);
}

class ProcessPaymentError extends CheckoutState {
  final String message;

  ProcessPaymentError(this.message);
}
