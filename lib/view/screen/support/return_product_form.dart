import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/order_delivered_list_model.dart';
import '../../../provider/support_ticket_provider.dart';
import '../../../utill/custom_themes.dart';
import '../../basewidget/button/custom_button.dart';
import '../../basewidget/counter_number_field.dart';
import '../../basewidget/custom_dropdown_search.dart';
import '../../basewidget/textfield/custom_textfield.dart';

class ReturnProductForm extends StatefulWidget {
  const ReturnProductForm({Key key}) : super(key: key);

  @override
  State<ReturnProductForm> createState() => _ReturnProductFormState();
}

class _ReturnProductFormState extends State<ReturnProductForm> {
  final TextEditingController _chooseFileController = TextEditingController();

  @override
  void dispose() {
    _chooseFileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderIds = context.read<SupportTicketProvider>().orderIds;
    return Column(
      children: [
        CustomDropdownSearch<String>(
          popupTitleText: 'Select an Order ID',
          hintText: 'Order ID',
          showSelectedItems: true,
          items: orderIds.map((e) => e.toString()).toList(),
          onChanged: (value) {
            context.read<SupportTicketProvider>().changeSelectedOrderId(value);
          },
        ),
        buildProductForm(),
      ],
    );
  }

  Widget buildProductForm() {
    return Selector<SupportTicketProvider, int>(
      selector: (context, provider) {
        return provider.refundProductLength;
      },
      builder: (context, refundProductLength, child) {
        if (refundProductLength < 1) {
          return SizedBox.shrink();
        }
        final products = context
            .read<SupportTicketProvider>()
            .selectedProductData
            .listProduct;
        return Column(
          children: [
            SizedBox(height: 8),
            Row(
              children: [
                Spacer(
                  flex: 2,
                ),
                Expanded(
                  child: CustomButton(
                    buttonText: 'Add',
                    onTap: () {
                      context.read<SupportTicketProvider>().addProductItem();
                    },
                  ),
                ),
              ],
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomDropdownSearch<ListProduct>(
                            popupTitleText: 'Select a Product',
                            hintText: 'Product',
                            items: products,
                            onChanged: (value) {
                              context
                                  .read<SupportTicketProvider>()
                                  .setRefundProductId(value, index);
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: CounterNumberField(
                            onChanged: (String value) {
                              context
                                  .read<SupportTicketProvider>()
                                  .setQuantityRefundProduct(
                                      int.tryParse(value) ?? 0, index);
                            },
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: index > 0,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 4,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                buttonText: 'Delete',
                                buttonColor: Colors.red,
                                onTap: () {
                                  context
                                      .read<SupportTicketProvider>()
                                      .removeProductItem(index);
                                },
                              ),
                            ),
                            Spacer(flex: 2),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 8);
              },
              itemCount: refundProductLength,
            ),
            SizedBox(height: 24),
            CustomTextField(
              textInputAction: TextInputAction.next,
              hintText: 'Choose File',
              readOnly: true,
              onTap: pickImage,
              controller: _chooseFileController,
            ),
            SizedBox(height: 2),
            Text(
              '*Upload your unboxing video formats: mp4, webm, ogx, m4v, mov, avi, and wmv. Max : 50mb',
              style: titilliumRegular.copyWith(
                fontSize: 12,
              ),
            ),
          ],
        );
      },
    );
  }

  void pickImage() async {
    try {
      final XFile xFile = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
      );

      _chooseFileController.text = xFile.name;
      context.read<SupportTicketProvider>().saveUnboxingVideo(xFile);
    } on Exception catch (e) {
      print('$e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$e',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
