import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rekret_ecommerce/localization/language_constrants.dart';
import 'package:flutter_rekret_ecommerce/utill/dimensions.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/title_row.dart';
import 'package:flutter_rekret_ecommerce/view/screen/product/specification_screen.dart';
import 'package:webview_flutter/webview_flutter.dart' as wv;

class ProductSpecification extends StatelessWidget {
  final String productSpecification;
  ProductSpecification({@required this.productSpecification});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) wv.WebView.platform = wv.SurfaceAndroidWebView();

    return Column(
      children: [
        TitleRow(
            title: getTranslated('specification', context),
            isDetailsPage: true,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => SpecificationScreen(
                          specification: productSpecification)));
            }),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        /*Text(
          productSpecification,
          style: titilliumRegular,
          textAlign: TextAlign.justify,
          maxLines: Provider.of<ProductDetailsProvider>(context).isDescriptionExpanded ? null : 2,
          overflow: Provider.of<ProductDetailsProvider>(context).isDescriptionExpanded ? null :TextOverflow.ellipsis,
        ),*/
        productSpecification.isNotEmpty
            ? SizedBox(
                height: 100,
                child: Html(data: productSpecification, style: {
                  "*": Style(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: FontSize(15),
                    fontFamily: 'TitilliumWeb',
                  ),
                }, customRender: {
                  "iframe": (RenderContext context, Widget child) {
                    final attrs = context.tree.element?.attributes;
                    if (attrs != null) {
                      double width = double.tryParse(attrs['width'] ?? "");
                      double height = double.tryParse(attrs['height'] ?? "");
                      return Container(
                        width: width ?? (height ?? 150) * 2,
                        height: height ?? (width ?? 300) / 2,
                        child: wv.WebView(
                          initialUrl: attrs['src'] ?? "about:blank",
                          javascriptMode: wv.JavascriptMode.unrestricted,
                          //no need for scrolling gesture recognizers on embedded youtube, so set gestureRecognizers null
                          //on other iframe content scrolling might be necessary, so use VerticalDragGestureRecognizer
                          gestureRecognizers: attrs['src'] != null &&
                                  attrs['src'].contains("youtube.com/embed")
                              ? null
                              : [Factory(() => VerticalDragGestureRecognizer())]
                                  .toSet(),
                          navigationDelegate:
                              (wv.NavigationRequest request) async {
                            //no need to load any url besides the embedded youtube url when displaying embedded youtube, so prevent url loading
                            //on other iframe content allow all url loading
                            if (attrs['src'] != null &&
                                attrs['src'].contains("youtube.com/embed")) {
                              if (!request.url.contains("youtube.com/embed")) {
                                return wv.NavigationDecision.prevent;
                              } else {
                                return wv.NavigationDecision.navigate;
                              }
                            } else {
                              return wv.NavigationDecision.navigate;
                            }
                          },
                        ),
                      );
                    } else {
                      return Container(height: 0);
                    }
                  }
                }),
              )
            : Center(child: Text('No specification')),
      ],
    );
  }
}
