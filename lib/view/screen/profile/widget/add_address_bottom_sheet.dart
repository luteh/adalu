import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/provider/theme_provider.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/guest_dialog.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/my_dialog.dart';
import 'package:flutter_rekret_ecommerce/view/screen/setting/widget/confirm_close_dialog.dart';
import 'package:flutter_rekret_ecommerce/view/screen/setting/widget/preference_dialog.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rekret_ecommerce/bloc/adress_form/address_form_bloc.dart';
import 'package:flutter_rekret_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/address_model.dart';
import 'package:flutter_rekret_ecommerce/data/repository/address_form_repo.dart';
import 'package:flutter_rekret_ecommerce/localization/language_constrants.dart';
import 'package:flutter_rekret_ecommerce/provider/profile_provider.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';
import 'package:flutter_rekret_ecommerce/utill/color_resources.dart';
import 'package:flutter_rekret_ecommerce/utill/custom_themes.dart';
import 'package:flutter_rekret_ecommerce/utill/dimensions.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/dialog/dialog_select_list.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/textfield/custom_textfield.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class AddAddressBottomSheet extends StatefulWidget {
  final AddressFormBloc addressFormBloc;

  AddAddressBottomSheet(this.addressFormBloc);

  @override
  _AddAddressBottomSheetState createState() => _AddAddressBottomSheetState();
}

class _AddAddressBottomSheetState extends State<AddAddressBottomSheet> {
  final FocusNode _provinceFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _districtFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _contactFocus = FocusNode();
  final FocusNode _zipCodeFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  final TextEditingController _provinceNameController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _districtNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  //
  final TextEditingController _provinceIdNameController =
      TextEditingController();
  final TextEditingController _cityIdNameController = TextEditingController();
  final TextEditingController _districtIdNameController =
      TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  //

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false)
        .setAddAddressErrorText(null);
  }

  void showImageErrorBloc(AddressFormState addressFormState) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${addressFormState.message}'),
        backgroundColor: Colors.red));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressFormBloc, AddressFormState>(
      bloc: widget.addressFormBloc,
      listener: (context, AddressFormState addressFormState) {
        if (addressFormState is GetProvinceState) {
          if (addressFormState.isError) {
            showImageErrorBloc(addressFormState);
          }
        }
        if (addressFormState is GetDistrictState) {
          if (addressFormState.isError) {
            showImageErrorBloc(addressFormState);
          }
        }
        if (addressFormState is GetCityState) {
          if (addressFormState.isError) {
            showImageErrorBloc(addressFormState);
          }
        }
      },
      child: BlocBuilder<AddressFormBloc, AddressFormState>(
        bloc: widget.addressFormBloc,
        builder: (context, AddressFormState addressFormState) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  Dimensions.PADDING_SIZE_DEFAULT,
                  Dimensions.PADDING_SIZE_DEFAULT,
                  Dimensions.PADDING_SIZE_DEFAULT,
                  MediaQuery.of(context).viewInsets.bottom),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: addressFormState.isLoading,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Consumer<ProfileProvider>(
                        builder: (context, profileProvider, child) {
                      return Container(
                        padding: EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT,
                          right: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            )
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6)),
                        ),
                        alignment: Alignment.center,
                        child: DropdownButtonFormField<String>(
                          value: profileProvider.addressType,
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Theme.of(context).primaryColor),
                          decoration: InputDecoration(border: InputBorder.none),
                          iconSize: 24,
                          elevation: 16,
                          style: titilliumRegular,
                          //underline: SizedBox(),

                          onChanged: profileProvider.updateCountryCode,
                          items: profileProvider.addressTypeList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: titilliumRegular.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .color)),
                            );
                          }).toList(),
                        ),
                      );
                    }),
                    Divider(thickness: 0.7, color: ColorResources.GREY),
                    CustomTextField(
                      onTap: () {
                        if (addressFormState.listProvince.isNotEmpty) {
                          showProvinceDialog(addressFormState);
                        }
                      },
                      hintText: getTranslated('SELECT_YOUR_PROVINCE', context),
                      controller: _provinceNameController,
                      enable: (!addressFormState.isLoading),
                      readOnly: true,
                      textInputType: TextInputType.streetAddress,
                      focusNode: _provinceFocus,
                      nextNode: _cityFocus,
                      textInputAction: TextInputAction.next,
                    ),
                    Divider(thickness: 0.7, color: ColorResources.GREY),
                    CustomTextField(
                      onTap: () {
                        if (addressFormState.listCity.isNotEmpty) {
                          showCityDialog(addressFormState);
                        }
                      },
                      hintText: getTranslated('SELECT_YOUR_CITY', context),
                      controller: _cityNameController,
                      enable: (!addressFormState.isLoading),
                      readOnly: true,
                      textInputType: TextInputType.streetAddress,
                      focusNode: _cityFocus,
                      nextNode: _districtFocus,
                      textInputAction: TextInputAction.next,
                    ),
                    Divider(thickness: 0.7, color: ColorResources.GREY),
                    CustomTextField(
                      onTap: () {
                        if (addressFormState.listDistrict.isNotEmpty) {
                          showDistrictDialog(addressFormState);
                        }
                      },
                      hintText: getTranslated('SELECT_YOUR_DISTRICT', context),
                      controller: _districtNameController,
                      enable: (!addressFormState.isLoading),
                      readOnly: true,
                      textInputType: TextInputType.streetAddress,
                      focusNode: _districtFocus,
                      nextNode: _addressFocus,
                      textInputAction: TextInputAction.next,
                    ),
                    Divider(thickness: 0.7, color: ColorResources.GREY),
                    CustomTextField(
                      hintText: getTranslated('ENTER_YOUR_ADDRESS', context),
                      controller: _addressController,
                      maxLine: 5,
                      textInputType: TextInputType.streetAddress,
                      focusNode: _addressFocus,
                      nextNode: _contactFocus,
                      textInputAction: TextInputAction.next,
                    ),
                    Divider(thickness: 0.7, color: ColorResources.GREY),
                    CustomTextField(
                      hintText:
                          getTranslated('ENTER_YOUR_CONTACT_PERSON', context),
                      controller: _contactController,
                      textInputType: TextInputType.streetAddress,
                      focusNode: _contactFocus,
                      nextNode: _zipCodeFocus,
                      textInputAction: TextInputAction.next,
                    ),
                    Divider(thickness: 0.7, color: ColorResources.GREY),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            hintText:
                                getTranslated('ENTER_YOUR_ZIP_CODE', context),
                            isPhoneNumber: true,
                            controller: _zipCodeController,
                            textInputType: TextInputType.number,
                            focusNode: _zipCodeFocus,
                            nextNode: _phoneFocus,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(
                            hintText:
                                getTranslated('ENTER_YOUR_PHONE', context),
                            isPhoneNumber: true,
                            controller: _phoneController,
                            textInputType: TextInputType.number,
                            focusNode: _phoneFocus,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Provider.of<ProfileProvider>(context).addAddressErrorText !=
                            null
                        ? Text(
                            Provider.of<ProfileProvider>(context)
                                .addAddressErrorText,
                            style: titilliumRegular.copyWith(
                                color: ColorResources.RED))
                        : SizedBox.shrink(),
                    Consumer<ProfileProvider>(
                      builder: (context, profileProvider, child) {
                        return Row(
                          children: [
                            Expanded(
                                child: TextButton(
                              onPressed: () {
                                showAnimatedDialog(
                                    context, ConfirmCloseDialog(),
                                    dismissible: false, isFlip: true);
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(0)),
                              child: Container(
                                height: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: ColorResources.getHint(context),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1)), // changes position of shadow
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(getTranslated('CLOSE', context),
                                    style: titilliumSemiBold.copyWith(
                                      fontSize: 16,
                                      color: Theme.of(context).accentColor,
                                    )),
                              ),
                            )),
                            SizedBox(width: 10),
                            Expanded(
                                child: profileProvider.isLoading
                                    ? Container(
                                        alignment: Alignment.center,
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                            key: Key(''),
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Theme.of(context)
                                                        .primaryColor)))
                                    : CustomButton(
                                        buttonText: getTranslated(
                                            'UPDATE_ADDRESS', context),
                                        onTap: () {
                                          _addAddress();
                                        },
                                      )),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _addAddress() {
    if (Provider.of<ProfileProvider>(context, listen: false).addressType ==
        Provider.of<ProfileProvider>(context, listen: false)
            .addressTypeList[0]) {
      Provider.of<ProfileProvider>(context, listen: false)
          .setAddAddressErrorText(
              getTranslated('SELECT_ADDRESS_TYPE', context));
    } else if (_provinceIdNameController.text.isEmpty) {
      Provider.of<ProfileProvider>(context, listen: false)
          .setAddAddressErrorText(
              getTranslated('PROVINCE_FIELD_MUST_BE_REQUIRED', context));
    } else if (_cityIdNameController.text.isEmpty) {
      Provider.of<ProfileProvider>(context, listen: false)
          .setAddAddressErrorText(
              getTranslated('CITY_FIELD_MUST_BE_REQUIRED', context));
    } else if (_districtIdNameController.text.isEmpty) {
      Provider.of<ProfileProvider>(context, listen: false)
          .setAddAddressErrorText(
              getTranslated('DISTRICT_FIELD_MUST_BE_REQUIRED', context));
    } else if (_addressController.text.isEmpty) {
      Provider.of<ProfileProvider>(context, listen: false)
          .setAddAddressErrorText(
              getTranslated('ADDRESS_FIELD_MUST_BE_REQUIRED', context));
    } else if (_contactController.text.isEmpty) {
      Provider.of<ProfileProvider>(context, listen: false)
          .setAddAddressErrorText(
              getTranslated('CONTACT_FIELD_MUST_BE_REQUIRED', context));
    } else if (_zipCodeController.text.isEmpty) {
      Provider.of<ProfileProvider>(context, listen: false)
          .setAddAddressErrorText(
              getTranslated('ZIPCODE_FIELD_MUST_BE_REQUIRED', context));
    } else if (_phoneController.text.isEmpty) {
      Provider.of<ProfileProvider>(context, listen: false)
          .setAddAddressErrorText(
              getTranslated('PHONE_FIELD_MUST_BE_REQUIRED', context));
    } else {
      Provider.of<ProfileProvider>(context, listen: false)
          .setAddAddressErrorText(null);
      AddressModel addressModel = AddressModel();
      addressModel.contactPersonName = _contactController.text;
      addressModel.addressType =
          Provider.of<ProfileProvider>(context, listen: false).addressType;
      addressModel.address = _addressController.text;
      addressModel.provinceCode = _provinceIdNameController.text;
      addressModel.cityCode = _cityIdNameController.text;
      addressModel.districtCode = _districtIdNameController.text;
      addressModel.city = _cityNameController.text;
      addressModel.address = _addressController.text;
      addressModel.zip = _zipCodeController.text;
      addressModel.phone = _phoneController.text;

      Provider.of<ProfileProvider>(context, listen: false)
          .addAddress(addressModel, route);
    }
  }

  route(bool isRoute, String message) {
    if (isRoute) {
      _cityNameController.clear();
      _zipCodeController.clear();
      Provider.of<ProfileProvider>(context, listen: false)
          .initAddressList(context);
      Navigator.pop(context);
    }
  }

  void showProvinceDialog(AddressFormState addressFormState) {
    showDialog(
      context: context,
      builder: (context) {
        List<Map<String, dynamic>> listStringDynamic =
            addressFormState.listProvince.map((e) {
          return {'id': e.provinsiCode, 'province': e.provinsiName};
        }).toList();

        return DialogSelectList(
          listStringDynamic: listStringDynamic,
          indexedWidgetBuilder: (context, index) {
            Map<String, dynamic> value = listStringDynamic[index];
            bool isSelected = (_provinceIdNameController.text
                .contains(value['id'].toString()));

            return ListTile(
              onTap: () {
                _provinceNameController.text = value['province'];
                _provinceIdNameController.text = value['id'];
                // if current province is not as selected call : GetCityEvent
                // reset value city & district
                if (!isSelected) {
                  widget.addressFormBloc
                      .add(GetCityEvent(province: value['id']));
                  _cityNameController.text = '';
                  _cityIdNameController.text = '';
                  _districtNameController.text = '';
                  _districtIdNameController.text = '';
                }
                Navigator.pop(context);
              },
              title: Text(value['province']),
              selected: isSelected,
              trailing: (isSelected) ? Icon(Icons.check, size: 20) : null,
            );
          },
          title: 'Select Province',
        );
      },
    );
  }

  void showCityDialog(AddressFormState addressFormState) {
    showDialog(
      context: context,
      builder: (context) {
        List<Map<String, dynamic>> listStringDynamic =
            addressFormState.listCity.map((e) {
          return {
            'id': e.cityCode,
            'city_name': e.cityName,
          };
        }).toList();

        return DialogSelectList(
          listStringDynamic: listStringDynamic,
          indexedWidgetBuilder: (context, index) {
            Map<String, dynamic> value = listStringDynamic[index];
            bool isSelected =
                (_cityIdNameController.text.contains(value['id'].toString()));

            return ListTile(
              onTap: () {
                _cityNameController.text = value['city_name'];
                _cityIdNameController.text = value['id'];

                // if current city is not as selected call : GetDistrictEvent
                // reset value district
                if (!isSelected) {
                  widget.addressFormBloc
                      .add(GetDistrictEvent(city: value['id']));
                  _districtNameController.text = '';
                  _districtIdNameController.text = '';
                }
                Navigator.pop(context);
              },
              title: Text("${value['city_name']}"),
              // title: Text("${value['type']} - ${value['city_name']}"),
              // subtitle: Text("Postal Code : ${value['postal_code']}"),
              selected: isSelected,
              trailing: (isSelected) ? Icon(Icons.check, size: 20) : null,
            );
          },
          title: 'Select City',
        );
      },
    );
  }

  void showDistrictDialog(AddressFormState addressFormState) {
    showDialog(
      context: context,
      builder: (context) {
        List<Map<String, dynamic>> listStringDynamic =
            addressFormState.listDistrict.map((e) {
          return {'subdistrict_name': e.districtName, 'id': e.districtCode};
        }).toList();

        return DialogSelectList(
          listStringDynamic: listStringDynamic,
          indexedWidgetBuilder: (context, index) {
            Map<String, dynamic> value = listStringDynamic[index];
            bool isSelected = (_districtIdNameController.text
                .contains(value['subdistrict_name'].toString()));

            return ListTile(
              onTap: () {
                _districtNameController.text = value['subdistrict_name'];
                _districtIdNameController.text = value['id'];
                Navigator.pop(context);
              },
              title: Text(value['subdistrict_name'].toString()),
              selected: isSelected,
              trailing: (isSelected) ? Icon(Icons.check, size: 20) : null,
            );
          },
          title: 'Select District',
        );
      },
    );
  }
}
