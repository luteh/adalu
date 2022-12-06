import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/cart_model.dart';

class CartM extends Equatable {
  final String seller;
  final String address;
  final List<CartModel> cartItem;

  CartM({
    @required this.seller,
    this.address,
    this.cartItem,
  });

  CartM copyWith({
    String seller,
    String address,
    List<CartModel> cartItem,
  }) =>
      CartM(
        seller: this.seller,
        address: this.address,
        cartItem: this.cartItem,
      );

  factory CartM.fromJson(Map<String, dynamic> json) => CartM(
        seller: json['seller'],
        address: json['address'],
        cartItem: List<CartModel>.from(
          json['cartItem'].map(
            (e) => CartModel.fromJson(e),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        'seller': seller,
        'address': address,
        'cartItem': cartItem,
      };

  @override
  // TODO: implement props
  List<Object> get props => [seller, address, cartItem];
}
