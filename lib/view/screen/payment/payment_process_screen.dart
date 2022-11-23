import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/payment_process.dart';
import 'package:flutter_rekret_ecommerce/localization/language_constrants.dart';
import 'package:flutter_rekret_ecommerce/utill/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/custom_loader.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/my_dialog.dart';
import 'package:flutter_rekret_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentProcessScreen extends StatefulWidget {
  final PaymentProcess paymentProcess;

  PaymentProcessScreen(this.paymentProcess);

  @override
  _PaymentProcessScreenState createState() => _PaymentProcessScreenState();
}

class _PaymentProcessScreenState extends State<PaymentProcessScreen> {
  String selectedUrl;
  double value = 0.0;
  bool _isLoading = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  WebViewController controllerGlobal;

  @override
  void initState() {
    super.initState();
    // selectedUrl = widget.paymentProcess.data.url;
    print(selectedUrl);

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        // backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [
            CustomAppBar(
                title: getTranslated('PAYMENT', context),
                onBackPressed: () => _exitApp(context)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, \nHere the virtual account you need to pay. There's limit time to use this virtual account, if success payment, the system will update automatically and your order will be process by system.",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 40.0,
                      child: Card(
                        child: Column(
                          children: [
                            Text(
                              widget.paymentProcess.data.virtualAccount,
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 25,
                      child: CustomButton(
                        buttonText: "Copy",
                        onTap: _copyToClipboard,
                      ),
                    )
                    // WebView(
                    //   javascriptMode: JavascriptMode.unrestricted,
                    //   initialUrl: widget.paymentProcess.data.url,
                    //   gestureNavigationEnabled: true,
                    //   userAgent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                    //   onWebViewCreated: (WebViewController webViewController) {
                    //     _controller.future.then((value) => controllerGlobal = value);
                    //     _controller.complete(webViewController);
                    //   },
                    //   onPageStarted: (String url) {
                    //     if(url.contains(AppConstants.BASE_URL)) {
                    //       bool _isSuccess = url.contains('checkout-complete-end/${widget.paymentProcess.data.orderId}');
                    //       bool _isFailed = url.contains('fail');
                    //       print('Page started loading: $url');
                    //       setState(() {
                    //         _isLoading = true;
                    //       });
                    //       if (_isSuccess) {
                    //         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => DashBoardScreen()), (route) => false);
                    //         showAnimatedDialog(context, MyDialog(
                    //           icon: Icons.done,
                    //           title: getTranslated('payment_done', context),
                    //           description: getTranslated('your_payment_successfully_done', context),
                    //         ), dismissible: false, isFlip: true);
                    //       } else if (_isFailed) {
                    //         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => DashBoardScreen()), (route) => false);
                    //         showAnimatedDialog(context, MyDialog(
                    //           icon: Icons.clear,
                    //           title: getTranslated('payment_failed', context),
                    //           description: getTranslated('your_payment_failed', context),
                    //           isFailed: true,
                    //         ), dismissible: false, isFlip: true);
                    //       } else if (url == '${AppConstants.BASE_URL}cancel') {
                    //         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => DashBoardScreen()), (route) => false);
                    //         showAnimatedDialog(context, MyDialog(
                    //           icon: Icons.clear,
                    //           title: getTranslated('payment_cancelled', context),
                    //           description: getTranslated('your_payment_cancelled', context),
                    //           isFailed: true,
                    //         ), dismissible: false, isFlip: true);
                    //       }
                    //     }
                    //   },
                    //   onPageFinished: (String url) {
                    //     print('Page finished loading: $url');
                    //     setState(() {
                    //       _isLoading = false;
                    //     });
                    //   },
                    // ),

                    // _isLoading ? Center(
                    //   child: CustomLoader(color: Theme.of(context).primaryColor),
                    // ) : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(
        ClipboardData(text: widget.paymentProcess.data.virtualAccount));

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Copied to Clipboard")));
  }

  Future<bool> _exitApp(BuildContext context) async {
    // if (await controllerGlobal.canGoBack()) {
    //   controllerGlobal.goBack();
    //   return Future.value(false);
    // } else {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (_) => DashBoardScreen()),
    //       (route) => false);
    //   showAnimatedDialog(
    //       context,
    //       MyDialog(
    //         icon: Icons.clear,
    //         title: getTranslated('payment_cancelled', context),
    //         description: getTranslated('your_payment_cancelled', context),
    //         isFailed: true,
    //       ),
    //       dismissible: false,
    //       isFlip: true);
    //   return Future.value(true);
    // }
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => DashBoardScreen()), (route) => false);
    showAnimatedDialog(
        context,
        MyDialog(
          icon: Icons.check,
          title: getTranslated('payment_done', context),
          description: getTranslated('your_payment_successfully_done', context),
          isFailed: false,
        ),
        dismissible: false,
        isFlip: true);
    return Future.value(true);
  }
}
