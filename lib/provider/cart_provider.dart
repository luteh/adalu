import 'package:flutter/material.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/cart.dart';
import '../data/model/response/cart_model.dart';
import '../data/model/response/new_cart_model.dart';
import '../data/repository/cart_repo.dart';
import '../helper/api_checker.dart';
import 'package:collection/collection.dart';

class CartProvider extends ChangeNotifier {
  final CartRepo cartRepo;
  CartProvider({@required this.cartRepo});

  List<CartModel> _cartList = [];

  List<CartModel> get cartList => _cartList;

  List<CartM> cartItem = [];
  List<CartModel> selectedItem = [];
  double totalAmount = 0.0;
  int cartItemLength = 0;

  bool isLoadingAddCartItem = false;
  bool shouldConfirmStock = false;
  bool isLoadingConfirmStock = false;
  bool isLoadingDeleteCartItem = false;

  void getCartData() {
    cartItem.clear();
    cartItem.addAll(cartRepo.getCartList());
    cartItem.forEach((element) {
      cartItemLength = cartItemLength + element.cartItem.length;
    });
  }

  Future<void> getCartsRemote(BuildContext context) async {
    ApiResponse apiResponse = await cartRepo.getCartListRemote();
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      apiResponse.response.data['cart'].forEach((item) {
        final data = NewCartModel.fromJson(item);
        final cart = CartModel(
          data.id,
          data.thumbnail,
          data.name,
          '',
          data.price.toDouble(),
          (data.price - data.discount).toDouble(),
          data.quantity,
          data.quantity,
          data.variant,
          null,
          data.discount.toDouble(),
          '',
          data.tax.toDouble(),
          '',
          0,
          data.statusConfirmation,
          data.statusMsg,
          data.quantityConfirmed,
        );
        _cartList.clear();
        cartItem.clear();
        cartRepo.clearCartList();
        cartItemLength = 0;
        selectedItem.clear();
        totalAmount = 0;
        addCartItem(context, cart, '');
      });
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
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

  void addCartItemRemote(BuildContext context, CartModel cart, String address,
      Function callback) async {
    final isProductExist =
        cartItem.any((e) => e.cartItem.any((element) => element.id == cart.id));
    if (isProductExist) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item is already in the cart'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    isLoadingAddCartItem = true;
    notifyListeners();

    try {
      ApiResponse apiResponse =
          await cartRepo.addToCartListRemote(cart.id, cart.quantity);
      if (apiResponse.response != null &&
          apiResponse.response.statusCode == 200) {
        await getCartsRemote(context);
        callback?.call();
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
    } finally {
      isLoadingAddCartItem = false;
      notifyListeners();
    }
  }

  bool containProduct(List<CartM> cart, CartModel item) {
    return cart.any((element) => element.cartItem.contains(item));
  }

  void selectItem(CartModel item) {
    if (containProduct(cartItem, item)) {
      if (selectedItem.contains(item)) {
        selectedItem.remove(item);
        totalAmount = totalAmount - (item.discountedPrice * item.quantity);
      } else {
        selectedItem.add(item);
        totalAmount = totalAmount + (item.discountedPrice * item.quantity);
      }
    }

    final notConfirmedItem = selectedItem.firstWhereOrNull(
        (element) => element.statusConfirmation == 'NOT_SUBMITED');
    shouldConfirmStock = notConfirmedItem != null;
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

  void deleteItemRemote(BuildContext context, CartModel item) async {
    isLoadingDeleteCartItem = true;
    notifyListeners();

    try {
      final apiResponse = await cartRepo.deleteCart(item.id);

      if (apiResponse.response != null &&
          apiResponse.response.statusCode == 200) {
        deleteItem(item);
        getCartsRemote(context);
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
    } finally {
      isLoadingDeleteCartItem = false;
      notifyListeners();
    }
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
    bool valid = false;
    selectedItem.forEach((element) {
      if (element.seller.contains(selectedItem[0].seller)) {
        valid = true;
      } else {
        valid = false;
      }
    });

    return valid;
  }

  void confirmStock(BuildContext context) async {
    isLoadingConfirmStock = true;
    notifyListeners();

    final apiResponse = await cartRepo.confirmStock();

    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      getCartsRemote(context);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }

    isLoadingConfirmStock = false;
    notifyListeners();
  }

  void refresh(BuildContext context) {
    getCartsRemote(context);
  }

  bool anyStockOnConfirmation() {
    final anyStockOnConfirmation =
        selectedItem.any((element) => element.statusConfirmation == 'REVIEW');
    return anyStockOnConfirmation;
  }
  bool anyNotAvailableStock() {
    final anyNotAvailableStock =
        selectedItem.any((element) => element.statusConfirmation == 'NOT_AVAILABLE');
    return anyNotAvailableStock;
  }
}
