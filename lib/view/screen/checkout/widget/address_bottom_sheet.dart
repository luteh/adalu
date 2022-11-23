import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/bloc/adress_form/address_form_bloc.dart';
import 'package:flutter_rekret_ecommerce/localization/language_constrants.dart';
import 'package:flutter_rekret_ecommerce/provider/order_provider.dart';
import 'package:flutter_rekret_ecommerce/provider/profile_provider.dart';
import 'package:flutter_rekret_ecommerce/provider/theme_provider.dart';
import 'package:flutter_rekret_ecommerce/utill/color_resources.dart';
import 'package:flutter_rekret_ecommerce/utill/custom_themes.dart';
import 'package:flutter_rekret_ecommerce/utill/dimensions.dart';
import 'package:flutter_rekret_ecommerce/utill/images.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_rekret_ecommerce/view/screen/profile/widget/add_address_bottom_sheet.dart';
import 'package:provider/provider.dart';

class AddressBottomSheet extends StatelessWidget {
  final AddressFormBloc addressFormBloc;
  final Function(int indexAddress) onAddressSelected;

  AddressBottomSheet({@required this.addressFormBloc, @required this.onAddressSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // Close Button
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).accentColor,
                  boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 200], spreadRadius: 1, blurRadius: 5)]),
              child: Icon(Icons.clear, size: Dimensions.ICON_SIZE_SMALL),
            ),
          ),
        ),

        Consumer<ProfileProvider>(
          builder: (context, profile, child) {
            return profile.addressList != null ? profile.addressList.length != 0 ?  SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: profile.addressList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Provider.of<OrderProvider>(context, listen: false).setAddressIndex(index);
                      onAddressSelected(index);
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorResources.getIconBg(context),
                        border: index == Provider.of<OrderProvider>(context).addressIndex ? Border.all(width: 2, color: Theme.of(context).primaryColor) : null,
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          profile.addressList[index].addressType == 'Home' ? Images.home_image
                              : profile.addressList[index].addressType == 'Ofice' ? Images.bag : Images.more_image,
                          color: ColorResources.getSellerTxt(context), height: 30, width: 30,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${(profile.addressList[index].contactPersonName ?? " -")} [${(profile.addressList[index].addressType) + "]" ?? ""}", style: titilliumSemiBold),
                            Text(profile.addressList[index].address, style: titilliumRegular),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )  : Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
              child: Text('No address available'),
            ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
          },
        ),

        CustomButton(buttonText: getTranslated('add_new_address', context), onTap: () {
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => AddAddressBottomSheet(addressFormBloc),
          );
        }),
      ]),
    );
  }
}
