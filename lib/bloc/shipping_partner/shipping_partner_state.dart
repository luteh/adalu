part of 'shipping_partner_bloc.dart';

@immutable
class ShippingPartnerState {
  final List<Courier> listCourier;
  final List<ServiceCourier> listServiceCourier;
  final Courier courierSelected;
  final ServiceCourier serviceCourierSelected;
  final bool isLoading;
  final String districtId;

  ShippingPartnerState(
      {this.listCourier = const [],
      this.listServiceCourier = const [],
      this.courierSelected = null,
      this.serviceCourierSelected = null,
      this.isLoading = false,
      this.districtId = ''});

  ShippingPartnerState copyWith({
    List<Courier> listCourier,
    List<ServiceCourier> listServiceCourier,
    Courier courierSelected,
    ServiceCourier serviceCourierSelected,
    bool isLoading,
    String districtId,
  }) {
    return ShippingPartnerState(
        listCourier: listCourier ?? this.listCourier,
        listServiceCourier: listServiceCourier ?? this.listServiceCourier,
        courierSelected: courierSelected, //?? this.courierSelected,
        serviceCourierSelected:
            serviceCourierSelected, //?? this.serviceCourierSelected,
        isLoading: isLoading ?? this.isLoading,
        districtId: districtId ?? this.districtId);
  }

  bool isSelectedComplete() {
    return (this.courierSelected != null) ? true : false;
  }

  String toString() {
    return 'ShippingPartnerState : {listCourier: ${listCourier.length}, listServiceCourier: ${listServiceCourier.length}, courierSelected: ${courierSelected.toString()}, serviceCourierSelected: ${serviceCourierSelected.toString()}, isLoading: ${isLoading.toString()}';
  }
}

class ShippingPartnerFailed extends ShippingPartnerState {
  final String message;

  ShippingPartnerFailed(this.message);
}
