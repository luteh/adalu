part of 'address_form_bloc.dart';

@immutable
class AddressFormState {
  final String message;
  final bool isLoading;
  final List<Province> listProvince;
  final List<City> listCity;
  final List<District> listDistrict;

  AddressFormState({this.message = '', this.isLoading = false, this.listProvince = const [], this.listCity = const [], this.listDistrict = const []});

  AddressFormState copyWith({
    String message,
    bool isLoading,
    List<Province> listProvince,
    List<City> listCity,
    List<District> listDistrict,
  }) {
    return AddressFormState(
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      listProvince: listProvince ?? this.listProvince,
      listCity: listCity ?? this.listCity,
      listDistrict: listDistrict ?? this.listDistrict,
    );
  }
}

class GetProvinceState extends AddressFormState {
  final bool isError;
  final String message;

  GetProvinceState({this.isError = false, this.message});
}


class GetCityState extends AddressFormState {
  final bool isError;
  final String message;

  GetCityState({this.isError = false, this.message});
}


class GetDistrictState extends AddressFormState {
  final bool isError;
  final String message;

  GetDistrictState({this.isError = false, this.message});
}

