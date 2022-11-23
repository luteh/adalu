part of 'address_form_bloc.dart';

@immutable
abstract class AddressFormEvent extends Equatable {}

class AddressFormEventUpdate extends AddressFormEvent {
  final String message;
  final bool isLoading;
  final List<Province> listProvince;
  final List<City> listCity;
  final List<District> listDistrict;

  AddressFormEventUpdate({this.message = '', this.isLoading = false, this.listProvince = const [], this.listCity = const [], this.listDistrict = const []});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetProvinceEvent extends AddressFormEvent {
  final String id;

  GetProvinceEvent({this.id = '0'});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetCityEvent extends AddressFormEvent {
  final String id;
  final String province;

  GetCityEvent({this.id = '0', @required this.province});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetDistrictEvent extends AddressFormEvent {
  final String id;
  final String city;

  GetDistrictEvent({this.id = '0', @required this.city});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}