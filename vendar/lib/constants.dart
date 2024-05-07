class Constants {
  // API URL Constants
  static const String baseUrl = "http://3.122.250.29:8080";

  // API Endpoints
  static const String loginEndpoint = "/login";
  static const String registerEndpoint = "/register";

  static const String getUserEndpoint = "/api/user";
  static const String getProductsEndpoint = "/api/product/m";
  static const String getUserProductsEndpoint = "/api/product/userId=";
  static const String getFavouriteProductsEndpoint = "/api/user/fav";
  static const String getRecommendedProductsEndpoint = "/api/product/r";

  static const String addFavouritesEndpoint = "/api/user/a/id=";
  static const String removeFavouriteEndpoint = "/api/user/r/id=";

  static const String addNewProductEndpoint = "/api/product";
  static const String addNewModelEndpoint = "/api/model";

  static const String getUser = "/api/user";
  static const String changePhoneNumberEndpoint = "/api/user/phone=";
  static const String changePasswordEndpoint = "/api/user/password=";
  static const String changeEmailNumberEndpoint = "/api/user/email=";
  static const String logoutEndpoint = "";
}
