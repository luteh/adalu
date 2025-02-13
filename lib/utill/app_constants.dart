import 'package:flutter_rekret_ecommerce/data/model/response/language_model.dart';

class AppConstants {
  static const String BASE_URL = 'https://www.adalu.id/';
  static const String BASE_URL_ASSETS = 'https://www.adalu.id';
  static const String USER_ID = 'userId';
  static const String NAME = 'name';
  static const String CATEGORIES_URI = 'api/v1/categories';
  static const String BRANDS_URI = 'api/v1/brands';
  static const String BRAND_PRODUCT_URI = 'api/v1/brands/products/';
  static const String CATEGORY_PRODUCT_URI = 'api/v1/categories/products/';
  static const String REGISTRATION_URI = 'api/v1/auth/register';
  static const String LOGIN_URI = 'api/v1/auth/login';
  static const String LATEST_PRODUCTS_URI =
      'api/v1/products/latest?limit=10&&offset=';
  static const String PRODUCT_DETAILS_URI = 'api/v1/products/details/';
  static const String PRODUCT_REVIEW_URI = 'api/v1/products/reviews/';
  static const String SEARCH_URI = 'api/v1/products/search?name=';
  static const String CONFIG_URI = 'api/v1/config';
  static const String REMOVE_ACCOUNT_URI = 'api/v1/customer/account_delete';
  static const String ADD_WISH_LIST_URI =
      'api/v1/customer/wish-list/add?product_id=';
  static const String REMOVE_WISH_LIST_URI =
      'api/v1/customer/wish-list/remove?product_id=';
  static const String UPDATE_PROFILE_URI = 'api/v1/customer/update-profile';
  static const String CUSTOMER_URI = 'api/v1/customer/info';
  static const String ADDRESS_LIST_URI = 'api/v1/customer/address/list';
  static const String REMOVE_ADDRESS_URI =
      'api/v1/customer/address?address_id=';
  static const String ADD_ADDRESS_URI = 'api/v1/customer/address/add';
  static const String WISH_LIST_GET_URI = 'api/v1/customer/wish-list';
  static const String SUPPORT_TICKET_URI =
      'api/v1/customer/support-ticket/create';
  static const String MAIN_BANNER_URI =
      'api/v1/banners?banner_type=main_banner';
  static const String FOOTER_BANNER_URI =
      'api/v1/banners?banner_type=footer_banner';
  static const String RELATED_PRODUCT_URI = 'api/v1/products/related-products/';
  static const String ORDER_URI = 'api/v1/customer/order/list';
  static const String ORDER_DETAILS_URI =
      'api/v1/customer/order/details?order_id=';
  static const String ORDER_PLACE_URI = 'api/v1/customer/order/place';
  static const String SELLER_URI = 'api/v1/seller?seller_id=';
  static const String SELLER_PRODUCT_URI = 'api/v1/seller/';
  static const String TRACKING_URI = 'api/v1/order/track?order_id=';
  static const String FORGET_PASSWORD_URI = 'api/v1/auth/forgot-password';
  static const String SUPPORT_TICKET_GET_URI =
      'api/v1/customer/support-ticket/get';
  static const String SUBMIT_REVIEW_URI = 'api/v1/products/reviews/submit';
  static const String FLASH_DEAL_URI = 'api/v1/flash-deals';
  static const String FLASH_DEAL_PRODUCT_URI = 'api/v1/flash-deals/products/';
  static const String COUNTER_URI = 'api/v1/products/counter/';
  static const String SOCIAL_LINK_URI = 'api/v1/products/social-share-link/';
  static const String SHIPPING_URI = 'api/v1/products/shipping-methods';
  static const String COUPON_URI = 'api/v1/coupon/apply-voucher';
  static const String MESSAGES_URI = 'api/v1/customer/chat/messages?shop_id=';
  static const String CHAT_INFO_URI = 'api/v1/customer/chat';
  static const String CHAT_DIALOG_BUYER = 'api/v1/customer/chat/dialog';
  static const String SEND_MESSAGE_URI = 'api/v1/customer/chat/send-message';
  static const String TOKEN_URI = 'api/v1/customer/cm-firebase-token';
  static const String NOTIFICATION_URI = 'api/v1/notifications';
  static const String GET_PROVINCE = 'api/v1/area/get_province';
  static const String GET_CITY = 'api/v1/area/get_city';
  static const String GET_DISTRICT = 'api/v1/area/get_district';
  static const String GET_SERVICE = 'api/v1/area/get_service';
  static const String GET_SERVICE_FEE = 'api/v1/area/get_service_fee';
  static const String PAYMENT_PROCESS = 'api/v1/customer/area/payment_process';
  static const String TRACKING_ORDER = 'api/v1/area/track_order?order_id=';
  static const String INSURANCE = 'api/v1/customer/area/insurance_fee';
  static const String ORDER_DELIVERED_LIST = 'api/v1/mycart/orderdeliveredlist';
  static const String SUBMIT_TICKET_RETURN = 'api/v1/mycart/submitticketreturn';
  static const String PICKUP_REQUEST = 'api/v1/mycart/pickuprequest';
  static const String SUPPORT_TICKET_CONV =
      'api/v1/customer/support-ticket/conv';
  static const String SUPPORT_TICKET_COMMENT =
      'api/v1/customer/support-ticket/comment';
  static const String GET_CART = 'api/v1/mycart/get_cart';
  static const String ADD_TO_TABLE_CART = 'api/v1/mycart/addtotablecart';
  static const String CONFIRM_STOCK_CUST = 'api/v1/mycart/confirmstockcust';
  static const String GENERATE_RESI = 'api/v1/mycart/generateresi';
  static const String GET_AWB = 'api/v1/mycart/getawb';
  static const String DELETE_CART = 'api/v1/mycart/delete_cart';

  // sharePreference
  static const String TOKEN = 'token';
  static const String USER = 'user';
  static const String USER_EMAIL = 'user_email';
  static const String USER_PASSWORD = 'user_password';
  static const String HOME_ADDRESS = 'home_address';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String OFFICE_ADDRESS = 'office_address';
  static const String CART_LIST = 'cart_list';
  static const String CONFIG = 'config';
  static const String GUEST_MODE = 'guest_mode';
  static const String CURRENCY = 'currency';
  static const String LANG_KEY = 'lang';

  // order status
  static const String PENDING = 'pending';
  static const String CONFIRMED = 'confirmed';
  static const String PROCESSING = 'processing';
  static const String PROCESSED = 'processed';
  static const String DELIVERED = 'delivered';
  static const String FAILED = 'failed';
  static const String RETURNED = 'returned';
  static const String CANCELLED = 'canceled';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String THEME = 'theme';
  static const String TOPIC = 'oglo.id';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: '',
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
  ];
}
