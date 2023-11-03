part of 'shipping_partner_bloc.dart';

@immutable
abstract class ShippingPartnerEvent extends Equatable {}

class InitialShippingPartnerEvent extends ShippingPartnerEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UpdateShippingPartnerEvent extends ShippingPartnerEvent {
  final List<Courier> listCourier;
  final List<ServiceCourier> listServiceCourier;
  final Courier courierSelected;
  final ServiceCourier serviceCourierSelected;
  final bool isLoading;
  final String districtId;

  UpdateShippingPartnerEvent(
      {this.listCourier = const [],
      this.listServiceCourier = const [],
      this.courierSelected,
      this.serviceCourierSelected,
      this.isLoading = false,
      this.districtId = ''});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SelectCourierShippingPartnerEvent extends ShippingPartnerEvent {
  final Courier courier;
  final String districtId;
  final List<CartModel> cartList;

  SelectCourierShippingPartnerEvent(
      this.courier, this.districtId, this.cartList);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RemoveSelectCourierShippingPartnerEvent extends ShippingPartnerEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SelectServiceCourierShippingPartnerEvent extends ShippingPartnerEvent {
  final ServiceCourier serviceCourier;

  SelectServiceCourierShippingPartnerEvent(this.serviceCourier);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UpdateSelectShippingPartnerEvent extends ShippingPartnerEvent {
  final ServiceCourier serviceCourier;
  final Courier courierSelected;

  UpdateSelectShippingPartnerEvent({this.serviceCourier, this.courierSelected});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
