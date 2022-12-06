import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rekret_ecommerce/bloc/adress_form/address_form_bloc.dart';
import 'package:flutter_rekret_ecommerce/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_rekret_ecommerce/bloc/shipping_partner/shipping_partner_bloc.dart';
import 'package:flutter_rekret_ecommerce/data/model/body/order_place_model.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/cart_model.dart';

import 'package:flutter_rekret_ecommerce/helper/price_converter.dart';
import 'package:flutter_rekret_ecommerce/localization/language_constrants.dart';
import 'package:flutter_rekret_ecommerce/provider/cart_provider.dart';
import 'package:flutter_rekret_ecommerce/provider/coupon_provider.dart';
import 'package:flutter_rekret_ecommerce/provider/insurance_provider.dart';
import 'package:flutter_rekret_ecommerce/provider/localization_provider.dart';
import 'package:flutter_rekret_ecommerce/provider/order_provider.dart';
import 'package:flutter_rekret_ecommerce/provider/product_provider.dart';
import 'package:flutter_rekret_ecommerce/provider/profile_provider.dart';
import 'package:flutter_rekret_ecommerce/provider/splash_provider.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';
import 'package:flutter_rekret_ecommerce/utill/color_resources.dart';
import 'package:flutter_rekret_ecommerce/utill/custom_themes.dart';
import 'package:flutter_rekret_ecommerce/utill/dimensions.dart';
import 'package:flutter_rekret_ecommerce/utill/images.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/amount_widget.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/my_dialog.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/title_row.dart';
import 'package:flutter_rekret_ecommerce/view/screen/cart/cart_screen.dart';
import 'package:flutter_rekret_ecommerce/view/screen/checkout/shipping_partner_screen.dart';
import 'package:flutter_rekret_ecommerce/view/screen/checkout/widget/address_bottom_sheet.dart';
import 'package:flutter_rekret_ecommerce/view/screen/checkout/widget/custom_check_box.dart';
import 'package:flutter_rekret_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_rekret_ecommerce/view/screen/payment/payment_process_screen.dart';
import 'package:flutter_rekret_ecommerce/view/screen/payment/payment_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartModel> cartList;

  final bool fromProductDetails;
  CheckoutScreen({@required this.cartList, this.fromProductDetails = false});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CheckoutBloc checkoutBloc;
  final sl = GetIt.instance;
  AddressFormBloc addressFormBloc;
  ShippingPartnerBloc shippingPartnerBloc;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _controller = TextEditingController();
  double _order = 0;
  double _discount = 0;
  double _tax = 0;
  double defaultTotalPayment = 0;
  bool _value = false;

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false)
        .initAddressList(context);
    Provider.of<ProfileProvider>(context, listen: false)
        .initAddressTypeList(context);
    Provider.of<OrderProvider>(context, listen: false)
        .initShippingList(context);
    Provider.of<CouponProvider>(context, listen: false).removePrevCouponData();
    Provider.of<InsuranceProvider>(context, listen: false)
        .removePrevCouponData();

    checkoutBloc = new CheckoutBloc(sl());
    checkoutBloc.add(InitialCheckoutEvent());

    addressFormBloc = new AddressFormBloc(sl());
    addressFormBloc.add(GetProvinceEvent());

    shippingPartnerBloc = new ShippingPartnerBloc(sl());
    shippingPartnerBloc.add(InitialShippingPartnerEvent());

    widget.cartList.forEach((cart) {
      double amount = cart.getCalculationUnitPrice();
      _order = _order + (amount * cart.quantity);
      _discount = _discount +
          PriceConverter.calculation(
            amount,
            cart.discount,
            cart.discountType,
            cart.quantity,
          );
      //_tax = _tax + cart.getTaxPrice();//PriceConverter.calculation(amount, cart.tax, cart.taxType, cart.quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    defaultTotalPayment = ((_order));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => this.addressFormBloc),
        BlocProvider(create: (context) => this.shippingPartnerBloc),
        BlocProvider(create: (context) => this.checkoutBloc)
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ShippingPartnerBloc, ShippingPartnerState>(
            bloc: this.shippingPartnerBloc,
            listener: (context, ShippingPartnerState shippingPartnerState) {
              print('shippingPartnerState : ' +
                  shippingPartnerState.isLoading.toString());

              if (shippingPartnerState.isSelectedComplete()) {
                double _shippingCost = 1000;
                double couponDiscount =
                    Provider.of<CouponProvider>(context, listen: false)
                                .discount !=
                            null
                        ? Provider.of<CouponProvider>(context, listen: false)
                            .discount
                        : 0;
                // initialize OrderPlaceModel
                OrderPlaceModel orderPlaceModel = OrderPlaceModel(
                  CustomerInfo(
                    Provider.of<ProfileProvider>(context, listen: false)
                        .addressList[
                            Provider.of<OrderProvider>(context, listen: false)
                                .addressIndex]
                        .id
                        .toString(),
                    Provider.of<ProfileProvider>(context, listen: false)
                        .addressList[
                            Provider.of<OrderProvider>(context, listen: false)
                                .addressIndex]
                        .address,
                  ),
                  listCart(shippingPartnerState, _shippingCost),
                  'payment_digital',
                  couponDiscount,
                  shippingPartnerState.courierSelected,
                  shippingPartnerState.serviceCourierSelected,
                  shippingPartnerState.districtId,
                );
                print(
                  listCart(
                    shippingPartnerState,
                    _shippingCost,
                  ),
                );

                // call GetServiceFeeEvent
                checkoutBloc.add(GetServiceFeeEvent(orderPlaceModel));
              } else {
                print("RemoveServiceFeeLoadedEvent");
                // remove serviceFee Loaded
                checkoutBloc.add(RemoveServiceFeeLoadedEvent());
              }
            },
          ),
          BlocListener<CheckoutBloc, CheckoutState>(
            bloc: this.checkoutBloc,
            listener: (context, CheckoutState checkoutState) {
              if (checkoutState.isPaymentSuccess()) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Proceed successful, please make payment'),
                    backgroundColor: Colors.green));
                Provider.of<CartProvider>(context, listen: false)
                    .removeCheckout();
                Provider.of<ProductProvider>(context, listen: false)
                    .getLatestProductList(
                  '1',
                  context,
                  Provider.of<LocalizationProvider>(context, listen: false)
                      .locale
                      .languageCode,
                  reload: true,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentProcessScreen(
                      checkoutState.paymentProcess,
                    ),
                  ),
                );
              } else if (checkoutState.isPaymentError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(checkoutState.messagePaymentError),
                    backgroundColor: ColorResources.RED,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<ShippingPartnerBloc, ShippingPartnerState>(
          bloc: this.shippingPartnerBloc,
          builder: (context, ShippingPartnerState shippingPartnerState) {
            return BlocBuilder<CheckoutBloc, CheckoutState>(
              bloc: this.checkoutBloc,
              builder: (context, CheckoutState checkoutState) {
                return Scaffold(
                  key: _scaffoldKey,
                  bottomNavigationBar: Container(
                    height: 70,
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_LARGE,
                      vertical: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    decoration: BoxDecoration(
                      color: ColorResources.getPrimary(context),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (checkoutState.isLoading)
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[200],
                                highlightColor: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                    color: Colors.white,
                                  ),
                                  width: 120,
                                  height: 12.0,
                                ),
                              )
                            : Text(
                                PriceConverter.convertPrice(
                                  context,
                                  checkoutState.getTotalPayment(
                                    defaultTotalPayment,
                                  ),
                                ),
                                //PriceConverter.convertPrice(context, (checkoutState.isServiceFeeLoaded()) ? double.tryParse(checkoutState.serviceFee.totalNominal.toString()) : 0),
                                style: titilliumSemiBold.copyWith(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                        (checkoutState.isPaymentProcess)
                            ? Container(
                                height: 30,
                                width: 100,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).accentColor,
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 80,
                                height: 45,
                                child: TextButton(
                                  onPressed: (!checkoutState.isLoading)
                                      ? () async {
                                          buttonPressed(shippingPartnerState,
                                              checkoutState, _value);
                                        }
                                      : null,
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    getTranslated('proceed', context),
                                    style: titilliumSemiBold.copyWith(
                                      fontSize: 13.0,
                                      color: ColorResources.getPrimary(context),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  body: buildBody(shippingPartnerState, checkoutState),
                );
              },
            );
          },
        ),
      ),
    );
  }

  buttonPressed(
    ShippingPartnerState shippingPartnerState,
    CheckoutState checkoutState,
    bool value,
  ) async {
    if (Provider.of<OrderProvider>(context, listen: false).addressIndex ==
        null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Select a shipping address'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!shippingPartnerState.isSelectedComplete()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Select a shipping method'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (value == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Insurance is required'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      checkoutBloc.add(ProcessPaymentEvent());
    }
  }

  List<Cart> listCart(shippingPartnerState, _shippingCost) {
    List<Cart> carts = [];
    for (int index = 0; index < widget.cartList.length; index++) {
      CartModel cart = widget.cartList[index];
      carts.add(
        Cart(
          cart.id.toString(),
          cart.tax,
          cart.quantity,
          cart.price,
          cart.discount /*PriceConverter.calculation(cart.discountedPrice, cart.discount, cart.discountType, 1)*/,
          'amount',
          index == 0
              ? int.tryParse(
                  shippingPartnerState.courierSelected.serviceTypeCode,
                )
              : 1,
          cart.variant,
          cart.variation != null ? [cart.variation] : [],
          index == 0 ? _shippingCost : 0,
        ),
      );
    }

    // print('data Cart: $carts');

    return carts;
  }

  Widget buildBody(
      ShippingPartnerState shippingPartnerState, CheckoutState checkoutState) {
    return Column(
      children: [
        CustomAppBar(title: getTranslated('checkout', context)),
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(0),
            children: [
              // Shipping Details
              Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(color: Theme.of(context).accentColor),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        enableDrag: false,
                        isDismissible: false,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => AddressBottomSheet(
                          addressFormBloc: this.addressFormBloc,
                          onAddressSelected: (indexAddress) {
                            String districtId = Provider.of<ProfileProvider>(
                                    context,
                                    listen: false)
                                .addressList[indexAddress]
                                .districtCode;
                            if (shippingPartnerState.districtId.isNotEmpty) {
                              if (!shippingPartnerState.districtId
                                  .contains(districtId)) {
                                // remove courierShipping if address change
                                shippingPartnerBloc.add(
                                  RemoveSelectCourierShippingPartnerEvent(),
                                );
                              }
                            }
                          },
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated('SHIPPING_TO', context),
                            style: titilliumRegular,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    Provider.of<OrderProvider>(context)
                                                .addressIndex ==
                                            null
                                        ? getTranslated(
                                            'add_your_address',
                                            context,
                                          )
                                        : Provider.of<ProfileProvider>(
                                            context,
                                            listen: false,
                                          )
                                            .addressList[
                                                Provider.of<OrderProvider>(
                                              context,
                                              listen: false,
                                            ).addressIndex]
                                            .address,
                                    textAlign: TextAlign.right,
                                    style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_SMALL),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                    width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Image.asset(Images.EDIT_TWO,
                                    width: 15,
                                    height: 15,
                                    color: ColorResources.getPrimary(context)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Divider(
                        height: 2,
                        color: ColorResources.getHint(context),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (Provider.of<OrderProvider>(context, listen: false)
                                .addressIndex ==
                            null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Please select a shipping address first'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          String districtId = Provider.of<ProfileProvider>(
                                  context,
                                  listen: false)
                              .addressList[Provider.of<OrderProvider>(context,
                                      listen: false)
                                  .addressIndex]
                              .districtCode;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ShippingPartnerScreen(
                                shippingPartnerBloc,
                                districtId,
                              ),
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated('SHIPPING_PARTNER', context),
                            style: titilliumRegular,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: (shippingPartnerState
                                            .isSelectedComplete())
                                        ? RichText(
                                            textAlign: TextAlign.right,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            strutStyle: StrutStyle(),
                                            text: TextSpan(
                                              text:
                                                  "${shippingPartnerState.serviceCourierSelected.serviceTypeName} - ${shippingPartnerState.serviceCourierSelected.serviceDesc ?? ""} ",
                                              style: titilliumRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_SMALL,
                                                  color:
                                                      ColorResources.getPrimary(
                                                          context)),
                                            ),
                                          )
                                        : Text(
                                            getTranslated(
                                                'select_shipping_method',
                                                context),
                                            style: titilliumRegular.copyWith(
                                                color:
                                                    ColorResources.getPrimary(
                                                        context),
                                                fontSize:
                                                    Dimensions.FONT_SIZE_SMALL),
                                            textAlign: TextAlign.right,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                SizedBox(
                                  width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                ),
                                Image.asset(
                                  Images.EDIT_TWO,
                                  width: 15,
                                  height: 15,
                                  color: ColorResources.getPrimary(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // Order Details

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    padding: EdgeInsets.all(
                      Dimensions.PADDING_SIZE_SMALL,
                    ),
                    color: Theme.of(context).accentColor,
                    child: TitleRow(
                      title: getTranslated('ORDER_DETAILS', context) +
                          " (${widget.cartList.length})",
                      onTap: widget.fromProductDetails
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CartScreen(
                                    fromCheckout: true,
                                    checkoutCartList: widget.cartList,
                                  ),
                                ),
                              );
                            },
                    ),
                  ),

                  Container(
                    color: Theme.of(context).accentColor,
                    child: ListView.builder(
                      itemCount: widget.cartList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        // print("Cart List");
                        // print(jsonEncode(widget.cartList));
                        return Padding(
                          // color: Theme.of(context).accentColor,
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          child: Row(
                            children: [
                              FadeInImage.assetNetwork(
                                placeholder: Images.placeholder,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                                image:
                                    '${AppConstants.BASE_URL_ASSETS}${Provider.of<SplashProvider>(context, listen: false).baseUrls.productThumbnailUrl}/${widget.cartList[index].image}',
                                imageErrorBuilder: (c, o, s) => Image.asset(
                                    Images.placeholder,
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50),
                              ),
                              SizedBox(width: Dimensions.MARGIN_SIZE_DEFAULT),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.cartList[index].name,
                                      style: titilliumRegular.copyWith(
                                          fontSize:
                                              Dimensions.FONT_SIZE_EXTRA_SMALL,
                                          color: ColorResources.getPrimary(
                                              context)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height:
                                          Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          PriceConverter.convertPrice(
                                              context,
                                              widget.cartList[index]
                                                  .getCalculationUnitPrice()),
                                          style: titilliumSemiBold.copyWith(
                                            color: ColorResources.getPrimary(
                                              context,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        Text(
                                            widget.cartList[index].quantity
                                                .toString(),
                                            style: titilliumSemiBold.copyWith(
                                                color:
                                                    ColorResources.getPrimary(
                                                        context))),
                                        Container(
                                          height: 20,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          margin: EdgeInsets.only(
                                              left: Dimensions
                                                  .MARGIN_SIZE_EXTRA_LARGE),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border: Border.all(
                                              color: ColorResources.getPrimary(
                                                context,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            PriceConverter
                                                .percentageCalculation(
                                                    context,
                                                    widget
                                                        .cartList[index].price,
                                                    widget.cartList[index]
                                                        .discount,
                                                    widget.cartList[index]
                                                        .discountType),
                                            style: titilliumRegular.copyWith(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_SMALL,
                                                color:
                                                    ColorResources.getPrimary(
                                                        context)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  Container(
                    // margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    color: Theme.of(context).accentColor,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 40,
                                child: TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    hintText: 'Have a coupon?',
                                    hintStyle: titilliumRegular.copyWith(
                                        color: ColorResources.HINT_TEXT_COLOR),
                                    filled: true,
                                    fillColor:
                                        ColorResources.getIconBg(context),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                            !Provider.of<CouponProvider>(context).isLoading
                                ? ElevatedButton(
                                    onPressed: () {
                                      if (shippingPartnerState
                                          .isSelectedComplete()) {
                                        if (_controller.text.isNotEmpty) {
                                          Provider.of<CouponProvider>(
                                            context,
                                            listen: false,
                                          )
                                              .initCoupon(
                                            _controller.text,
                                            checkoutState.orderPlaceModel,
                                          )
                                              .then(
                                            (value) {
                                              if (value > 0) {
                                                checkoutBloc.add(
                                                    CouponVoucherEvent(value));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'You got${PriceConverter.convertPrice(context, value)} discount',
                                                    ),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      getTranslated(
                                                        'invalid_coupon_or',
                                                        context,
                                                      ),
                                                    ),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                                checkoutBloc.add(
                                                  CouponVoucherEvent(0),
                                                );
                                              }
                                            },
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Please select shipping address & shipping partner',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: ColorResources.getGreen(context),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child:
                                        Text(getTranslated('APPLY', context)),
                                  )
                                : CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor,
                                    ),
                                  ),
                            SizedBox(
                              width: Dimensions.MARGIN_SIZE_SMALL,
                            ),
                            ElevatedButton(
                              onPressed: (_controller.text.isNotEmpty)
                                  ? () {
                                      checkoutBloc.add(CouponVoucherEvent(0));
                                      _controller.text = "";
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                primary: ColorResources.getLowGreen(context),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                getTranslated('REMOVE', context),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Coupon
                ],
              ),

              // Total bill
              totalBillWidget(shippingPartnerState, checkoutState),

              // Payment Method
              Container(
                margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                color: Theme.of(context).accentColor,
                child: Column(
                  children: [
                    TitleRow(title: getTranslated('payment_method', context)),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    //CustomCheckBox(title: getTranslated('cash_on_delivery', context), index: 0),
                    CustomCheckBox(title: 'Virtual Account BCA', index: 1),
                    Consumer<OrderProvider>(
                      builder: (context, order, child) {
                        return InkWell(
                          onTap: () => {},
                          child: Row(
                            children: [
                              Checkbox(
                                value: _value,
                                activeColor: Theme.of(context).primaryColor,
                                onChanged: (bool isChecked) => {
                                  if (shippingPartnerState.isSelectedComplete())
                                    {
                                      setState(() {
                                        _value = isChecked;
                                        // print('Value: $_value');
                                      }),
                                      if (_value)
                                        {
                                          print(checkoutState.orderPlaceModel
                                              .cart[0].shippingMethodId),
                                          Provider.of<InsuranceProvider>(
                                            context,
                                            listen: false,
                                          )
                                              .initCoupon(
                                            checkoutState
                                                .orderPlaceModel.districtId,
                                            shippingPartnerState
                                                .serviceCourierSelected
                                                .serviceTypeCode,
                                            checkoutState.orderPlaceModel,
                                          )
                                              .then(
                                            (value) {
                                              print("insurance amount: $value");
                                              checkoutBloc.add(
                                                InsuranceAmount(value),
                                              );
                                            },
                                          )
                                        }
                                      else
                                        {
                                          checkoutBloc.add(InsuranceAmount(0)),
                                        }
                                    }
                                  else
                                    {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Please select shipping address & shipping partner'),
                                          backgroundColor: Colors.red,
                                        ),
                                      )
                                    }
                                },
                              ),
                              Expanded(
                                child: Text(
                                  "Insurance",
                                  style: titilliumRegular.copyWith(
                                    color: _value
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .color
                                        : ColorResources.getGainsBoro(
                                            context,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget totalBillWidget(
    ShippingPartnerState shippingPartnerState,
    CheckoutState checkoutState,
  ) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      color: Theme.of(context).accentColor,
      child: Consumer<OrderProvider>(
        builder: (context, order, child) {
          double _shippingCost =
              (shippingPartnerState.isSelectedComplete()) ? 1000 : 0;
          double _couponDiscount = checkoutState.couponVouher ?? 0;
          double _insuranceAmount = checkoutState.insuranceAmount ?? 0;
          //double _shippingCost = order.shippingIndex != null ? order.shippingList[order.shippingIndex].cost : 0;
          //double _couponDiscount = Provider.of<CouponProvider>(context).discount != null ? Provider.of<CouponProvider>(context).discount : 0;
          Widget totalWidget = TitleRow(
            title: getTranslated('TOTAL', context),
          );
          Widget orderWidget = AmountWidget(
              title: getTranslated('ORDER', context),
              amount: PriceConverter.convertPrice(context, _order));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleRow(title: getTranslated('TOTAL', context)),
              AmountWidget(
                  title: getTranslated('ORDER', context),
                  amount: PriceConverter.convertPrice(context, _order)),
              //AmountWidget(title: getTranslated('TAX', context), amount: PriceConverter.convertPrice(context, _tax)),
              AmountWidget(
                  title: getTranslated('SHIPPING_FEE', context),
                  amount: PriceConverter.convertPrice(
                      context,
                      (checkoutState.isServiceFeeLoaded())
                          ? double.tryParse(checkoutState
                              .serviceFee.shipmentNominal
                              .toString())
                          : 0),
                  loadingAmount: checkoutState.isLoading),
              //AmountWidget(title: getTranslated('DISCOUNT', context), amount: PriceConverter.convertPrice(context, _discount)),
              AmountWidget(
                  title: getTranslated('coupon_voucher', context),
                  amount:
                      PriceConverter.convertPrice(context, _couponDiscount)),
              AmountWidget(
                title: "Insurance",
                amount: PriceConverter.convertPrice(context, _insuranceAmount),
              ),
              Divider(height: 5, color: Theme.of(context).hintColor),
              AmountWidget(
                  title: getTranslated('TOTAL_PAYABLE', context),
                  amount: PriceConverter.convertPrice(
                    context,
                    checkoutState.getTotalPayment(defaultTotalPayment),
                  ),
                  loadingAmount: checkoutState.isLoading),
            ],
          );
        },
      ),
    );
  }

  void _callback(bool isSuccess, String message, String orderID,
      List<CartModel> carts) async {
    if (isSuccess) {
      Provider.of<CartProvider>(context, listen: false).removeCheckout();
      Provider.of<ProductProvider>(context, listen: false).getLatestProductList(
        '1',
        context,
        Provider.of<LocalizationProvider>(context, listen: false)
            .locale
            .languageCode,
        reload: true,
      );
      if (Provider.of<OrderProvider>(context, listen: false)
              .paymentMethodIndex ==
          0) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => DashBoardScreen()),
            (route) => false);
        showAnimatedDialog(
            context,
            MyDialog(
              icon: Icons.check,
              title: getTranslated('order_placed', context),
              description: getTranslated('your_order_placed', context),
              isFailed: false,
            ),
            dismissible: false,
            isFlip: true);
      } else {
        String userID =
            await Provider.of<ProfileProvider>(context, listen: false)
                .getUserInfo(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    PaymentScreen(orderID: orderID, customerID: userID)));
      }
      Provider.of<OrderProvider>(context, listen: false).stopLoader();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message), backgroundColor: ColorResources.RED));
    }
  }
}

class PaymentButton extends StatelessWidget {
  final String image;
  final Function onTap;
  PaymentButton({@required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: ColorResources.getGrey(context)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(image),
      ),
    );
  }
}
