import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rekret_ecommerce/bloc/adress_form/address_form_bloc.dart';
import 'package:flutter_rekret_ecommerce/localization/language_constrants.dart';
import 'package:flutter_rekret_ecommerce/provider/auth_provider.dart';
import 'package:flutter_rekret_ecommerce/provider/profile_provider.dart';
import 'package:flutter_rekret_ecommerce/utill/color_resources.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/not_loggedin_widget.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/show_custom_modal_dialog.dart';
import 'package:flutter_rekret_ecommerce/view/screen/profile/widget/add_address_bottom_sheet.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class AddressListScreen extends StatefulWidget {
  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  bool isGuestMode = false;
  AddressFormBloc addressFormBloc;
  final sl = GetIt.instance;

  @override
  void initState() {
    super.initState();
    addressFormBloc = new AddressFormBloc(sl());
    addressFormBloc.add(GetProvinceEvent());
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if(!isGuestMode) {
      Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList(context);
      Provider.of<ProfileProvider>(context, listen: false).initAddressList(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddressFormBloc>(
      create: (context) => this.addressFormBloc,
      child: BlocBuilder<AddressFormBloc, AddressFormState>(
        bloc: this.addressFormBloc,
        builder: (context, AddressFormState addressFormState) {
          return Scaffold(
            floatingActionButton: isGuestMode ? null : FloatingActionButton(
              onPressed: () => showModalBottomSheet(
                enableDrag: false,
                isDismissible: false,
                context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                builder: (context) => AddAddressBottomSheet(this.addressFormBloc),
              ),
              child: Icon(Icons.add, color: Theme.of(context).accentColor),
              backgroundColor: ColorResources.getPrimary(context),
            ),
            body: Column(
              children: [
                CustomAppBar(title: getTranslated('ADDRESS_LIST', context)),

                isGuestMode ? Expanded(child: NotLoggedInWidget()) : Consumer<ProfileProvider>(
                  builder: (context, profileProvider, child) {
                    return profileProvider.addressList != null ? profileProvider.addressList.length > 0 ? Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList(context);
                          await Provider.of<ProfileProvider>(context, listen: false).initAddressList(context);
                        },
                        backgroundColor: Theme.of(context).primaryColor,
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: profileProvider.addressList.length,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text((profileProvider.addressList[index].contactPersonName ?? "") + " [" + (profileProvider.addressList[index].addressType + "]" ?? "")),
                                  Text('Address : ${profileProvider.addressList[index].address}' ?? ""),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete_forever, color: Colors.red),
                                onPressed: () {
                                  showCustomModalDialog(
                                    context,
                                    title: getTranslated('REMOVE_ADDRESS', context),
                                    content: profileProvider.addressList[index].address,
                                    cancelButtonText: getTranslated('CANCEL', context),
                                    submitButtonText: getTranslated('REMOVE', context),
                                    submitOnPressed: () {
                                      Provider.of<ProfileProvider>(context, listen: false).removeAddressById(profileProvider.addressList[index].id, index, context);
                                      Navigator.of(context).pop();
                                    },
                                    cancelOnPressed: () => Navigator.of(context).pop(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ) : Expanded(child: NoInternetOrDataScreen(isNoInternet: false))
                        : Expanded(child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}