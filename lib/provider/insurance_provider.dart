import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/model/body/order_place_model.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/coupon_model.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_rekret_ecommerce/data/repository/coupon_repo.dart';
import 'package:flutter_rekret_ecommerce/data/repository/insurance_repo.dart';

class InsuranceProvider extends ChangeNotifier {
  final InsuranceRepo insuranceRepo;
  InsuranceProvider({@required this.insuranceRepo});

  CouponModel _coupon;
  double _discount;
  bool _isLoading = false;
  CouponModel get coupon => _coupon;
  double get discount => _discount;
  bool get isLoading => _isLoading;

  Future<double> initCoupon(
      String kota, String service, OrderPlaceModel orderPlaceModel) async {
    _isLoading = true;
    notifyListeners();
    List<Cart> listCart = [];
    List<Variation> listVariation = [];
    orderPlaceModel.cart.forEach((Cart cart) {
      cart.variation.forEach((Variation variation) {
        listVariation.add(variation.copyWith(type: 'Black'));
      });

      listCart.add(cart.copyWith(variant: 'Black', variation: listVariation));
    });

    Map<String, dynamic> data = new Map<String, dynamic>();
    data['kota'] = kota;
    data['service'] = service;
    data['cart'] = listCart.map((v) => v.toJson()).toList();

    ApiResponse apiResponse = await insuranceRepo.getInsurance(data);
    if (apiResponse.response != null &&
        apiResponse.response.toString() != '{}' &&
        apiResponse.response.statusCode == 200) {
      final response = apiResponse.response.data;

      _discount =
          double.tryParse(response['insurance_nominal'].toString()) ?? 0;
    }
    /*_coupon = CouponModel.fromJson(apiResponse.response.data);
      if (_coupon.minPurchase != null && _coupon.minPurchase < order) {
        if(_coupon.discountType == 'percent') {
          _discount = (_coupon.discount * order / 100) < _coupon.maxDiscount
              ? (_coupon.discount * order / 100) : _coupon.maxDiscount;
        }else {
          _discount = _coupon.discount;
        }
      } else {
        _discount = 0;
      }
    } else {
      print(apiResponse.error.toString());
      _discount = 0;
    }*/
    _isLoading = false;
    notifyListeners();
    return _discount;
  }

  void removePrevCouponData() {
    _isLoading = false;
    _discount = null;
  }
}
