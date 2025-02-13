import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rekret_ecommerce/data/model/body/register_model.dart';
import 'package:flutter_rekret_ecommerce/localization/language_constrants.dart';
import 'package:flutter_rekret_ecommerce/provider/auth_provider.dart';
import 'package:flutter_rekret_ecommerce/provider/profile_provider.dart';
import 'package:flutter_rekret_ecommerce/utill/color_resources.dart';
import 'package:flutter_rekret_ecommerce/utill/custom_themes.dart';
import 'package:flutter_rekret_ecommerce/utill/dimensions.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/textfield/custom_textfield.dart';
import 'package:flutter_rekret_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _npwpStrController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _npwpAddressController = TextEditingController();
  GlobalKey<FormState> _formKey;

  FocusNode _fNameFocus = FocusNode();
  FocusNode _lNameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();
  FocusNode _npwpFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _confirmPasswordFocus = FocusNode();
  FocusNode _companyFocus = FocusNode();
  FocusNode _npwpAddressFocus = FocusNode();

  RegisterModel register = RegisterModel();
  bool isEmailVerified = false;

  addUser() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      isEmailVerified = true;

      String _firstName = _firstNameController.text.trim();
      String _email = _emailController.text.trim();
      String _phone = _phoneController.text.trim();
      String _password = _passwordController.text.trim();
      String _confirmPassword = _confirmPasswordController.text.trim();
      String _npwpStr = _npwpStrController.text.trim();
      String _company = _companyController.text.trim();
      String _npwpAddress = _npwpAddressController.text.trim();

      if (_firstName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('NAME_FIELD_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('EMAIL_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_phone.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(getTranslated('CONFIRM_PASSWORD_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_password != _confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_DID_NOT_MATCH', context)),
          backgroundColor: Colors.red,
        ));
      } else if (_npwpStr.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("NPWP is required"),
          backgroundColor: Colors.red,
        ));
      } else if (_company.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Company is required'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (_npwpAddress.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Npwp Address is required'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (file == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Npwp is Required'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        register.fName = '${_firstNameController.text}';
        register.lName = _lastNameController.text ?? " ";
        register.email = _emailController.text;
        register.phone = _phoneController.text;
        register.password = _passwordController.text;
        register.npwpStr = _npwpStrController.text;
        register.company = _companyController.text;
        register.address = _npwpAddressController.text;

        await context.read<AuthProvider>().register(
              context,
              register,
              file,
              route,
            );
      }
    } else {
      isEmailVerified = false;
    }
  }

  File file;

  void chooseFile() async {
    try {
      final picketFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 1800,
        maxWidth: 1800,
      );

      if (picketFile == null) return;

      setState(() {
        file = File(picketFile.path);
        print(file);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  route(bool isRoute, String errorMessage) async {
    if (isRoute) {
      await Provider.of<ProfileProvider>(context, listen: false)
          .getUserInfo(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => DashBoardScreen()),
          (route) => false);
      _emailController.clear();
      _passwordController.clear();
      _firstNameController.clear();
      _lastNameController.clear();
      _phoneController.clear();
      _confirmPasswordController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
    }
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              // for first and last name
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      hintText: getTranslated('FIRST_NAME', context),
                      textInputType: TextInputType.name,
                      focusNode: _fNameFocus,
                      nextNode: _lNameFocus,
                      isPhoneNumber: false,
                      capitalization: TextCapitalization.words,
                      controller: _firstNameController,
                    )),
                    SizedBox(width: 15),
                    Expanded(
                        child: CustomTextField(
                      hintText: getTranslated('LAST_NAME', context),
                      focusNode: _lNameFocus,
                      nextNode: _emailFocus,
                      capitalization: TextCapitalization.words,
                      controller: _lastNameController,
                    )),
                  ],
                ),
              ),

              // for email
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomTextField(
                  hintText: getTranslated('ENTER_YOUR_EMAIL', context),
                  focusNode: _emailFocus,
                  nextNode: _phoneFocus,
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
              ),

              // for phone

              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomTextField(
                  textInputType: TextInputType.number,
                  hintText: getTranslated('ENTER_MOBILE_NUMBER', context),
                  focusNode: _phoneFocus,
                  nextNode: _npwpFocus,
                  controller: _phoneController,
                  isPhoneNumber: true,
                ),
              ),

              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomTextField(
                  textInputType: TextInputType.number,
                  hintText: "Enter NPWP",
                  focusNode: _npwpFocus,
                  nextNode: _passwordFocus,
                  controller: _npwpStrController,
                ),
              ),

              Container(
                width: double.infinity,
                height: 200,
                margin: EdgeInsets.only(
                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                  right: Dimensions.MARGIN_SIZE_DEFAULT,
                  top: Dimensions.MARGIN_SIZE_SMALL,
                ),
                padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_DEFAULT),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: file != null
                          ? Container(
                              child: Image.file(
                                file,
                                fit: BoxFit.contain,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload_outlined,
                                  color: Theme.of(context).hintColor,
                                ),
                                Text(
                                  'Upload NPWP',
                                  style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                      ),
                      onPressed: () => chooseFile(),
                      child: Text('Browser File'),
                    )
                  ],
                ),
              ),

              // for password
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomPasswordTextField(
                  hintTxt: getTranslated('PASSWORD', context),
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  nextNode: _confirmPasswordFocus,
                  textInputAction: TextInputAction.next,
                ),
              ),

              // for re-enter password
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomPasswordTextField(
                  hintTxt: getTranslated('RE_ENTER_PASSWORD', context),
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocus,
                  nextNode: _companyFocus,
                  textInputAction: TextInputAction.next,
                ),
              ),

              // Company
              Container(
                margin: EdgeInsets.only(
                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                  right: Dimensions.MARGIN_SIZE_DEFAULT,
                  top: Dimensions.MARGIN_SIZE_SMALL,
                ),
                child: CustomTextField(
                  textInputType: TextInputType.text,
                  hintText: "Enter Company",
                  focusNode: _companyFocus,
                  nextNode: _npwpAddressFocus,
                  controller: _companyController,
                  textInputAction: TextInputAction.done,
                ),
              ),

              // NPWP Address
              Container(
                margin: EdgeInsets.only(
                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                  right: Dimensions.MARGIN_SIZE_DEFAULT,
                  top: Dimensions.MARGIN_SIZE_SMALL,
                ),
                child: CustomTextField(
                  textInputType: TextInputType.multiline,
                  maxLine: 3,
                  hintText: "NPWP Address",
                  focusNode: _npwpAddressFocus,
                  controller: _npwpAddressController,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),
        ),

        // for register button
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 40),
          child: Provider.of<AuthProvider>(context).isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : CustomButton(
                  onTap: addUser,
                  buttonText: getTranslated('SIGN_UP', context)),
        ),

        // for skip for now
        // Provider.of<AuthProvider>(context).isLoading
        //     ? SizedBox()
        //     : Center(
        //         child: TextButton(
        //           onPressed: () {
        //             Navigator.pushReplacement(context,
        //                 MaterialPageRoute(builder: (_) => DashBoardScreen()));
        //           },
        //           child: Text(getTranslated('SKIP_FOR_NOW', context),
        //               style: titilliumRegular.copyWith(
        //                   fontSize: Dimensions.FONT_SIZE_SMALL,
        //                   color: ColorResources.getColombiaBlue(context))),
        //         ),
        //       ),
      ],
    );
  }
}
