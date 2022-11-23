import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/data/repository/address_form_repo.dart';
import 'package:meta/meta.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/address/city.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/address/province.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/address/district.dart';

part 'address_form_event.dart';
part 'address_form_state.dart';

class AddressFormBloc extends Bloc<AddressFormEvent, AddressFormState> {
  final AddressFormRepo addressFormRepo;

  AddressFormBloc(this.addressFormRepo) : super(AddressFormState());

  @override
  Stream<AddressFormState> mapEventToState(AddressFormEvent event) async* {
    if (event is AddressFormEventUpdate) {
      yield state.copyWith(
          isLoading: event.isLoading,
          message: event.message,
          listCity: event.listCity,
          listDistrict: event.listDistrict,
          listProvince: event.listProvince);
    } else if (event is GetProvinceEvent) {
      yield* _getProvinceEvent(event);
    } else if (event is GetCityEvent) {
      yield* _getCityEvent(event);
    } else if (event is GetDistrictEvent) {
      yield* _getDistrictEvent(event);
    }
  }

  Stream<AddressFormState> _getProvinceEvent(GetProvinceEvent event) async* {
    yield state.copyWith(isLoading: true);

    ApiResponse apiResponse =
        await this.addressFormRepo.getListProvince(event.id);

    if (apiResponse != null) {
      try {
        List<Province> list =
            List.from(apiResponse.response.data['province'].map((data) {
          return Province.fromJson(data);
        }).toList());

        yield GetProvinceState(
            isError: false, message: 'Success Loaded Province');
        add(AddressFormEventUpdate(isLoading: false, listProvince: list));
      } catch (e) {
        yield state.copyWith(isLoading: false, message: apiResponse.error);
        yield GetProvinceState(isError: true, message: apiResponse.error);
      }
    } else {
      yield state.copyWith(isLoading: false, message: apiResponse.error);
      yield GetProvinceState(isError: true, message: apiResponse.error);
    }
  }

  Stream<AddressFormState> _getCityEvent(GetCityEvent event) async* {
    yield state.copyWith(isLoading: true);

    ApiResponse apiResponse =
        await this.addressFormRepo.getListCity(event.id, event.province);

    if (apiResponse != null) {
      try {
        List<City> list =
            List.from(apiResponse.response.data['list'].map((data) {
          return City.fromJson(data);
        }).toList());

        yield GetCityState(isError: false, message: 'Success Loaded City');
        add(AddressFormEventUpdate(
            isLoading: false,
            listProvince: state.listProvince,
            listCity: list));
      } catch (e) {
        yield state.copyWith(isLoading: false, message: apiResponse.error);
        yield GetCityState(isError: true, message: apiResponse.error);
      }
    } else {
      yield state.copyWith(isLoading: false, message: apiResponse.error);
      yield GetCityState(isError: true, message: apiResponse.error);
    }
  }

  Stream<AddressFormState> _getDistrictEvent(GetDistrictEvent event) async* {
    yield state.copyWith(isLoading: true);

    ApiResponse apiResponse =
        await this.addressFormRepo.getListDistrict(event.id, event.city);

    if (apiResponse != null) {
      try {
        List<District> list =
            List.from(apiResponse.response.data['list'].map((data) {
          return District.fromJson(data);
        }).toList());

        yield GetDistrictState(
            isError: false, message: 'Success Loaded District');
        add(AddressFormEventUpdate(
            isLoading: false,
            listProvince: state.listProvince,
            listCity: state.listCity,
            listDistrict: list));
      } catch (e) {
        yield state.copyWith(isLoading: false, message: apiResponse.error);
        yield GetDistrictState(isError: true, message: apiResponse.error);
      }
    } else {
      yield state.copyWith(isLoading: false, message: apiResponse.error);
      yield GetDistrictState(isError: true, message: apiResponse.error);
    }
  }
}
