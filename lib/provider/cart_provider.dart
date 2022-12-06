import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/cart.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/cart_model.dart';
import 'package:flutter_rekret_ecommerce/data/repository/cart_repo.dart';

class CartProvider extends ChangeNotifier {
  final CartRepo cartRepo;
  CartProvider({@required this.cartRepo});

  List<CartModel> _cartList = [];

  List<CartModel> get cartList => _cartList;

  List<CartM> cartItem = [];
  List<CartModel> selectedItem = [];
  double totalAmount = 0.0;
  int cartItemLength = 0;

  void getCartData() {
    cartItem.clear();
    cartItem.addAll(cartRepo.getCartList());
    cartItem.forEach((element) {
      cartItemLength = cartItemLength + element.cartItem.length;
    });
  }

  bool containSeller(List<CartM> cart, String seller) {
    return cart.any((e) => e.seller == seller);
  }

  void addCartItem(context, CartModel cart, String address) {
    if (containSeller(cartItem, cart.seller)) {
      cartItem.any((element) {
        if (element.seller == cart.seller) {
          if (element.cartItem.any((item) => item.id == cart.id)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Item is already in the cart'),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            cartItemLength = cartItemLength + 1;
            element.cartItem.add(cart);
          }
        }
        return false;
      });
    } else {
      cartItemLength = cartItemLength + 1;

      cartItem.add(
        CartM(
          seller: cart.seller,
          address: address,
          cartItem: [cart],
        ),
      );
    }

    cartRepo.addToCartList(cartItem);

    notifyListeners();
  }

  bool containProduct(List<CartM> cart, CartModel item) {
    return cart.any((element) => element.cartItem.contains(item));
  }

  void selectItem(CartModel item) {
    if (containProduct(cartItem, item)) {
      if (selectedItem.contains(item)) {
        selectedItem.remove(item);
        totalAmount = totalAmount - (item.discountedPrice * item.quantity);

        notifyListeners();
        return;
      }
      selectedItem.add(item);
      totalAmount = totalAmount + (item.discountedPrice * item.quantity);
    }
    notifyListeners();
  }

  bool containItem(List<CartModel> cartItem, item) {
    return cartItem.any((element) => element == item);
  }

  void deleteItem(CartModel item) {
    CartM data;
    cartItem.forEach(
      (element) {
        if (element.cartItem.contains(item)) {
          data = element;
          if (selectedItem.contains(item)) {
            selectedItem.removeWhere((selectedItem) => selectedItem == item);
            totalAmount = totalAmount - (item.discountedPrice * item.quantity);
          }
          element.cartItem.removeWhere((e) => e == item);
          cartItemLength = cartItemLength - 1;
        }
      },
    );
    if (data.cartItem.isEmpty) {
      cartItem.removeWhere((cart) => cart == data);
    }
    cartRepo.addToCartList(cartItem);
    notifyListeners();
  }

  void incrementQty(CartModel item) {
    cartItem.forEach(
      (element) {
        if (element.cartItem.contains(item)) {
          var data = element.cartItem.singleWhere((e) => e == item);

          if (data.quantity < data.maxQuantity) {
            data.quantity += 1;
            if (selectedItem.contains(data)) {
              totalAmount = totalAmount + data.discountedPrice;
            }
          }
        }
      },
    );
    cartRepo.addToCartList(cartItem);
    notifyListeners();
  }

  void decrementQty(CartModel item) {
    cartItem.forEach((element) {
      if (element.cartItem.contains(item)) {
        var data = element.cartItem.singleWhere((e) => e == item);

        if (data.quantity > 1) {
          data.quantity -= 1;
          if (selectedItem.contains(data)) {
            totalAmount = totalAmount - data.discountedPrice;
          }
        }
      }
    });
    cartRepo.addToCartList(cartItem);
    notifyListeners();
  }

  void removeCheckout() {
    CartM cartItemData;
    cartItem.any((element) {
      cartItemData = element;
      if (element.seller == selectedItem[0].seller) {
        selectedItem.forEach((item) {
          element.cartItem.removeWhere((data) => data.id == item.id);
        });
      }
      print(selectedItem.length);
      return false;
    });

    if (cartItemData.cartItem.isEmpty) {
      cartItem.removeWhere((e) => e == cartItemData);
    }

    totalAmount = 0;

    cartRepo.addToCartList(cartItem);

    notifyListeners();
  }

  bool validCheckout() {
    bool valid;
    selectedItem.forEach((element) {
      if (element.seller.contains(selectedItem[0].seller)) {
        valid = true;
      } else {
        valid = false;
      }
    });

    return valid;
  }
}
