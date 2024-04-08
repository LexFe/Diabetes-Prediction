import 'package:dio/dio.dart';
import 'package:frontend/common/values/constant.dart';
import 'package:frontend/global.dart';


class HttpUtil {
  late Dio dio;
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(minutes: 10),
      receiveTimeout: const Duration(minutes: 10),
      responseType: ResponseType.json,
      validateStatus: (_) => true,
    );

    dio = Dio(options);
    // dio.options.headers["x-access-token"] =
    //     // ignore: unnecessary_string_interpolations
    //     '${Global.userService.getUserToken(AppConstants.STORAGE_USER_TOKEN_KEY)}';
    dio.options.validateStatus = (_) => true;
  }

  Future post(String path,
      {dynamic data,
      Options? options,
      Map<String, dynamic>? queryParameters}) async {
    Options reqOptions = options ?? Options();
    reqOptions.headers = reqOptions.headers ?? {};
    Map<String, dynamic>? login = getLoginTokenHaeder();
    // ignore: unnecessary_null_comparison
    if (login != null) {
      reqOptions.headers!.addAll(login);
      reqOptions.validateStatus = (_) => true;
    }

    var response = await dio.post(path,
        data: data, queryParameters: queryParameters, options: reqOptions);
    return response;
  }

  Map<String, dynamic> getLoginTokenHaeder() {
    var header = <String, dynamic>{};
    var accessToken = Global.userService.getUserToken();
    if (accessToken.isNotEmpty) {
      header["x-access-token"] = accessToken;
    }
    return header;
  }

  Future get(String path,
      {dynamic data,
      Options? options,
      Map<String, dynamic>? queryParameters}) async {
    Options reqOptions = options ?? Options();
    reqOptions.headers = reqOptions.headers ?? {};
    Map<String, dynamic>? login = getLoginTokenHaeder();
    // ignore: unnecessary_null_comparison
    if (login != null) {
      reqOptions.headers!.addAll(login);
      reqOptions.validateStatus = (_) => true;
    }

    reqOptions.followRedirects = false;
    final response = await dio.get(
      path,
      data: data,
      options: reqOptions,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future patch(String path,
      {dynamic data,
      Options? options,
      Map<String, dynamic>? queryParameters}) async {
    Options reqOptions = options ?? Options();
    reqOptions.headers = reqOptions.headers ?? {};
    Map<String, dynamic>? login = getLoginTokenHaeder();
    // ignore: unnecessary_null_comparison
    if (login != null) {
      reqOptions.headers!.addAll(login);
      reqOptions.validateStatus = (_) => true;
    }

    var response = await dio.patch(path,
        data: data, queryParameters: queryParameters, options: reqOptions);
    return response;
  }
}
