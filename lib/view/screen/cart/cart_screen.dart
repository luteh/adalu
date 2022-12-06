import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/cart.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/cart_model.dart';

import 'package:flutter_rekret_ecommerce/helper/price_converter.dart';
import 'package:flutter_rekret_ecommerce/localization/language_constrants.dart';
import 'package:flutter_rekret_ecommerce/provider/auth_provider.dart';
import 'package:flutter_rekret_ecommerce/provider/cart_provider.dart';
import 'package:flutter_rekret_ecommerce/utill/color_resources.dart';
import 'package:flutter_rekret_ecommerce/utill/custom_themes.dart';
import 'package:flutter_rekret_ecommerce/utill/dimensions.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/guest_dialog.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_rekret_ecommerce/view/screen/cart/widget/cart_widget.dart';
import 'package:flutter_rekret_ecommerce/view/screen/checkout/checkout_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  final bool fromCheckout;
  final List<CartModel> checkoutCartList;
  CartScreen({this.fromCheckout = false, this.checkoutCartList});

  @override
  Widget build(BuildContext context) {
    List<CartModel> cartList = [];
    if (fromCheckout) {
      cartList.addAll(checkoutCartList);
    } else {
      cartList.addAll(Provider.of<CartProvider>(context).cartList);
    }

    //TODO: seller
    List<String> sellerList = [];
    List<List<CartModel>> cartProductList = [];
    List<List<int>> cartProductIndexList = [];
    cartList.forEach((cart) {
      if (!sellerList.contains(cart.seller)) {
        sellerList.add(cart.seller);
      }
    });
    sellerList.forEach((seller) {
      List<CartModel> cartLists = [];
      List<int> indexList = [];
      cartList.forEach((cart) {
        if (seller == cart.seller) {
          cartLists.add(cart);
          indexList.add(cartList.indexOf(cart));
        }
      });
      cartProductList.add(cartLists);
      cartProductIndexList.add(indexList);
    });

    return Scaffold(
      bottomNavigationBar: !fromCheckout
          ? Container(
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
                  // InkWell(
                  //   onTap: () => Provider.of<CartProvider>(
                  //     context,
                  //     listen: false,
                  //   ).toggleAllSelect(),
                  //   child: Container(
                  //     width: 15,
                  //     height: 15,
                  //     margin: EdgeInsets.only(
                  //       right: Dimensions.PADDING_SIZE_SMALL,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       border: Border.all(
                  //         color: Theme.of(context).accentColor,
                  //         width: 1,
                  //       ),
                  //     ),
                  //     child: Provider.of<CartProvider>(context).isAllSelect
                  //         ? Icon(
                  //             Icons.done,
                  //             color: Theme.of(context).accentColor,
                  //             size: Dimensions.ICON_SIZE_EXTRA_SMALL,
                  //           )
                  //         : SizedBox.shrink(),
                  //   ),
                  // ),
                  Expanded(
                    child: Center(
                      child: Text(
                        PriceConverter.convertPrice(
                          context,
                          Provider.of<CartProvider>(context).totalAmount,
                        ),
                        style: titilliumSemiBold.copyWith(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) => SizedBox(
                      width: 80,
                      height: 45,
                      child: TextButton(
                        onPressed: () {
                          if (Provider.of<AuthProvider>(
                            context,
                            listen: false,
                          ).isLoggedIn()) {
                            var selectedItem = Provider.of<CartProvider>(
                              context,
                              listen: false,
                            ).selectedItem;

                            if (selectedItem.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Select at least one product'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }

                            context.read<CartProvider>().validCheckout();
                            if (!context.read<CartProvider>().validCheckout()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Only one store per checkout'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CheckoutScreen(
                                    cartList: context
                                        .read<CartProvider>()
                                        .selectedItem,
                                  ),
                                ),
                              );
                            }

                            // List<CartModel> cartList = [];
                            // for (int i = 0;
                            //     i <
                            //         Provider.of<CartProvider>(
                            //           context,
                            //           listen: false,
                            //         ).isSelectedList.length;
                            //     i++) {
                            //   if (Provider.of<CartProvider>(
                            //     context,
                            //     listen: false,
                            //   ).isSelectedList[i]) {
                            //     cartList.add(
                            //       Provider.of<CartProvider>(
                            //         context,
                            //         listen: false,
                            //       ).cartList[i],
                            //     );
                            //   }
                            // }
                            // if (cartList.length > 0) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (_) =>
                            //           CheckoutScreen(cartList: cartList),
                            //     ),
                            //   );
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //       content: Text('Select at least one product.'),
                            //       backgroundColor: Colors.red,
                            //     ),
                            //   );
                            // }
                          } else {
                            showAnimatedDialog(
                              context,
                              GuestDialog(),
                              isFlip: true,
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          getTranslated('checkout', context),
                          style: titilliumSemiBold.copyWith(
                            fontSize: 13.0,
                            color: ColorResources.getPrimary(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
      body: Column(
        children: [
          CustomAppBar(
            title: getTranslated('CART', context),
          ),

          //TODO: seller
          // Provider.of<CartProvider>(context).cartList.length != 0
          //     ? Expanded(
          //         child: ListView.builder(
          //           itemCount: sellerList.length,
          //           padding: EdgeInsets.all(0),
          //           itemBuilder: (context, index) {
          //             return Padding(
          //               padding: EdgeInsets.only(
          //                 bottom: Dimensions.PADDING_SIZE_LARGE,
          //               ),
          //               child: Column(
          //                 children: [
          //                   /* Container(
          //                     padding: EdgeInsets.all(
          //                         Dimensions.MARGIN_SIZE_DEFAULT),
          //                     decoration: BoxDecoration(
          //                         color: Theme.of(context).accentColor,
          //                         boxShadow: [
          //                           BoxShadow(
          //                               color: Colors.grey.withOpacity(0.3),
          //                               spreadRadius: 1,
          //                               blurRadius: 3,
          //                               offset: Offset(0, 3)),
          //                         ],),
          //                     child: Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Text(getTranslated('seller', context),
          //                               textAlign: TextAlign.start,
          //                               style: titilliumRegular),
          //                           Text(sellerList[index],
          //                               textAlign: TextAlign.end,
          //                               style: titilliumSemiBold.copyWith(
          //                                 fontSize: Dimensions.FONT_SIZE_LARGE,
          //                                 color: ColorResources.getPrimary(
          //                                     context),
          //                               )),
          //                         ],),
          //                   ), */
          //                   Consumer<CartProvider>(
          //                     builder: (context, carProvider, child) {
          //                       return ListView.builder(
          //                         physics: NeverScrollableScrollPhysics(),
          //                         shrinkWrap: true,
          //                         padding: EdgeInsets.all(0),
          //                         itemCount: cartProductList[index].length,
          //                         itemBuilder: (context, i) => CartWidget(
          //                           cartModel: cartProductList[index][i],
          //                           index: cartProductIndexList[index][i],
          //                           fromCheckout: fromCheckout,
          //                         ),
          //                       );
          //                     },
          //                   ),
          //                 ],
          //               ),
          //             );
          //           },
          //         ),
          //       )
          //     : Expanded(
          //         child: NoInternetOrDataScreen(isNoInternet: false),
          //       ),

          context.watch<CartProvider>().cartItem.length != 0
              ? Expanded(
                  child: Consumer<CartProvider>(
                    builder: (context, cartProvider, ___) {
                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: cartProvider.cartItem.length,
                        itemBuilder: (context, index) {
                          CartM data = cartProvider.cartItem[index];
                          return Container(
                            padding: EdgeInsets.all(
                              Dimensions.PADDING_SIZE_DEFAULT,
                            ),
                            margin: EdgeInsets.only(
                              bottom: Dimensions.MARGIN_SIZE_DEFAULT,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Adalu Seller'),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text('|'),
                                    ),
                                    Text(data.address)
                                  ],
                                ),
                                Divider(),
                                ListCartItem(cartItem: data.cartItem)
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              : Expanded(
                  child: NoInternetOrDataScreen(isNoInternet: false),
                ),
        ],
      ),
    );
  }
}
