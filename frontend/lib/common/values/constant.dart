class AppConstants {
  static const String baseUrl = "http://188.166.181.240:5558/api/v1/";

  //static const String baseUrl = "http://192.168.3.52:5558/api/v1/";

  static const String baseUrlImage =
      "http://188.166.181.240:5558/api/v1/image?image=market&image_id=";

  static const String locales = 'assets/locales';

  static const String baseUrlSlideImg =
      "http://188.166.181.240:5558/api/v1/image?image=slider&image_id=";

  static const String baseUrlCategory =
      "http://188.166.181.240:5558/api/v1/image?image=category&image_id=";

  static const String baseUrlProduct =
      "http://188.166.181.240:5558/api/v1/image?image=product&image_id=";

  static const String baseUrlUser =
      "http://188.166.181.240:5558/api/v1/image?image=customer&image_id=";

  // static const String baseUrlFavorites =
  //   "http://188.166.181.240:5558/api/v1/image?image=customer&image_id=";

  // ignore: constant_identifier_names
  static const String STORAGE_DEVICE_OPEN_FIRST_TIME = "device_first_time";

  // ignore: constant_identifier_names
  static const String STORAGE_USER_TOKEN_KEY = "user_token_key";

  // ignore: constant_identifier_names
  static const String STORAGE_USER_PROFLIE_KEY = "user_proflie_key";

  // ignore: constant_identifier_names
  static const String STORAGE_USER_ID_KEY = "user_id_key";
}

class ApiPath {
  static const String addToCart = "add-to-cart";
  static const String updateCart = "update-cart";
  static const String deliveryFee = "delivery-fee";
  static const String order = "order";
  static const String paymentDetail = "payment-detail";
  static const String address = "location";
  static const String history = "history";
  static const String orderComplete = "order-complete";
  static const String tracking = "tracking";
}

class ValueType {
  static const String undefined = "undefined";
  static const String delete = "delete";
  static const String all = "all";
}

class OrderType {
  static const delivery = "delivery";
  static const myself = "myself";
}

class OrderHistoryStatus {
  static const ordered = "ordered";
  static const completed = "completed";
  static const cancelled = "cancelled";
}
