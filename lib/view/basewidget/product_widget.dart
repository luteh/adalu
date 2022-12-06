import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_rekret_ecommerce/helper/price_converter.dart';
import 'package:flutter_rekret_ecommerce/provider/splash_provider.dart';
import 'package:flutter_rekret_ecommerce/provider/theme_provider.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';
import 'package:flutter_rekret_ecommerce/utill/color_resources.dart';
import 'package:flutter_rekret_ecommerce/utill/custom_themes.dart';
import 'package:flutter_rekret_ecommerce/utill/dimensions.dart';
import 'package:flutter_rekret_ecommerce/utill/images.dart';
import 'package:flutter_rekret_ecommerce/view/screen/product/product_details_screen.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final Product productModel;
  ProductWidget({@required this.productModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1000),
            pageBuilder: (context, anim1, anim2) =>
                ProductDetails(product: productModel),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).accentColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5)
          ],
        ),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Product Image
              Container(
                height: 195,
                //padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                decoration: BoxDecoration(
                  color: Colors.white, //ColorResources.getIconBg(context),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: Images.placeholder,
                    fit: BoxFit.cover,
                    image:
                        '${AppConstants.BASE_URL_ASSETS}${Provider.of<SplashProvider>(context, listen: false).baseUrls.productThumbnailUrl}/${productModel.thumbnail}',
                    imageErrorBuilder: (c, o, s) =>
                        Image.asset(Images.placeholder, fit: BoxFit.cover),
                  ),
                ),
              ),

              // Product Details
              Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(productModel.name ?? '',
                        style: robotoRegular,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Text(
                      PriceConverter.convertPrice(
                        context,
                        productModel.getCalculationUnitPrice(),
                      ),
                      style: robotoBold.copyWith(
                        color: ColorResources.getPrimary(context),
                      ),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    productModel.discount > 0
                        ? Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red.withOpacity(0.2),
                                ),
                                child: Text(
                                  productModel.discountType == 'percent' ||
                                          productModel.discountType ==
                                              'percentage'
                                      ? '${productModel.discount.toStringAsFixed(1)}% OFF'
                                      : PriceConverter.convertPrice(
                                            context,
                                            productModel.discount,
                                          ) +
                                          ' OFF',
                                  style: robotoBold.copyWith(
                                    color: Colors.red,
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Text(
                                PriceConverter.convertPrice(
                                  context,
                                  productModel.getPriceWithTax(),
                                ),
                                style: robotoBold.copyWith(
                                  color: Theme.of(context).hintColor,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                ),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    if (productModel.discount > 0)
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),
                    Row(
                      children: [
                        Icon(Icons.star_rounded,
                            color: Provider.of<ThemeProvider>(context).darkTheme
                                ? Colors.white
                                : Colors.orange,
                            size: 15),
                        SizedBox(width: 3),
                        Text(
                            productModel.rating != null
                                ? productModel.rating.length != 0
                                    ? double.parse(
                                            productModel.rating[0].average)
                                        .toStringAsFixed(1)
                                    : '0.0'
                                : '0.0',
                            style: robotoRegular.copyWith(
                              color:
                                  Provider.of<ThemeProvider>(context).darkTheme
                                      ? Colors.white
                                      : Colors.orange,
                              fontSize: Dimensions.FONT_SIZE_SMALL,
                            )),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Text(
                          "|",
                          style: robotoRegular.copyWith(
                            color: Colors.white,
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                          ),
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Text(
                          "Stock : ${productModel.currentStock.toString()}",
                          style: robotoRegular.copyWith(
                            color: Colors.white,
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Off
          productModel.discount >= 1
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent[200],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        productModel.discountType == 'percent' ||
                                productModel.discountType == 'percentage'
                            ? '${productModel.discount.toStringAsFixed(1)}% OFF'
                            : PriceConverter.convertPrice(
                                  context,
                                  productModel.discount,
                                ) +
                                ' OFF',
                        style: robotoRegular.copyWith(
                          color: Colors.white,
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ]),
      ),
    );
  }
}
