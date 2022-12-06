import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/cart_model.dart';
import 'package:flutter_rekret_ecommerce/helper/price_converter.dart';
import 'package:flutter_rekret_ecommerce/provider/cart_provider.dart';
import 'package:flutter_rekret_ecommerce/provider/splash_provider.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';
import 'package:flutter_rekret_ecommerce/utill/color_resources.dart';
import 'package:flutter_rekret_ecommerce/utill/custom_themes.dart';
import 'package:flutter_rekret_ecommerce/utill/dimensions.dart';
import 'package:flutter_rekret_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

class ListCartItem extends StatelessWidget {
  final List<CartModel> cartItem;

  const ListCartItem({Key key, this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: cartItem.length,
      itemBuilder: (context, i) {
        CartModel data = cartItem[i];
        return Padding(
          padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
          child: Consumer<CartProvider>(builder: (context, cartModel, ___) {
            context.watch<CartProvider>();
            return Row(
              children: [
                InkWell(
                  onTap: () => context.read<CartProvider>().selectItem(data),
                  child: Container(
                    width: 15,
                    height: 15,
                    margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: ColorResources.getPrimary(context), width: 1),
                    ),
                    child: cartModel.selectedItem.contains(data)
                        ? Icon(
                            Icons.check,
                            size: Dimensions.ICON_SIZE_EXTRA_SMALL,
                            color: Theme.of(context).primaryColor,
                          )
                        : SizedBox.shrink(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE,
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: Images.placeholder,
                    height: 50,
                    width: 50,
                    image:
                        '${AppConstants.BASE_URL_ASSETS}${context.watch<SplashProvider>().baseUrls.productThumbnailUrl}/${data.image}',
                    imageErrorBuilder: (c, o, s) => Image.asset(
                      Images.placeholder,
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          data.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: titilliumBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                            color: ColorResources.getHint(context),
                          ),
                        ),
                        Text(
                          PriceConverter.convertPrice(
                            context,
                            data.getCalculationUnitPrice(),
                          ),
                          style: titilliumSemiBold.copyWith(
                            color: ColorResources.getPrimary(context),
                          ),
                        ),
                        Visibility(
                          visible: data.discount >= 1,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              '${PriceConverter.convertPrice(context, data.getPriceWithTax())}',
                              style: titilliumRegular.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 10,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => context
                                  .read<CartProvider>()
                                  .decrementQty(data),
                              child: Container(
                                child: Icon(
                                  Icons.remove_circle,
                                  color: data.quantity > 1
                                      ? ColorResources.getPrimary(context)
                                      : ColorResources.getGrey(context),
                                  size: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_SMALL,
                              ),
                              child: Text(data.quantity.toString()),
                            ),
                            InkWell(
                              onTap: () => context
                                  .read<CartProvider>()
                                  .incrementQty(data),
                              child: Container(
                                child: Icon(
                                  Icons.add_circle,
                                  color: data.quantity >= data.maxQuantity
                                      ? ColorResources.getGrey(context)
                                      : ColorResources.getPrimary(context),
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: ColorResources.getPrimary(context)),
                  ),
                  child: Text(
                    PriceConverter.percentageCalculation(
                      context,
                      data.price,
                      data.discount,
                      data.discountType,
                    ),
                    textAlign: TextAlign.center,
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                        color: ColorResources.getHint(context)),
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      context.read<CartProvider>().deleteItem(data),
                  icon: Icon(Icons.cancel, color: ColorResources.RED),
                )
              ],
            );
          }),
        );
      },
    );
  }
}
