import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import '../constants/app/app_constants.dart';

class NetworkManager {
  Dio _dio;
  static NetworkManager _instance = NetworkManager._init();
  static NetworkManager get instance => _instance;

  NetworkManager._init() {
    final _baseOptions = BaseOptions(
      baseUrl: ApplicationConstants.BASE_URL,
    );

    _dio = Dio(_baseOptions);

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request) {
        request.headers['Content-Type'] = 'application/json';
        return request;
      },
      onResponse: (response) {
        return response;
      },
      onError: (error) {
        print("dio error");
        print(error);
        return error;
        // return BaseError(message: error.message);
      },
    ));
  }

  Future get({String path, dynamic data}) async {
    final response = await _dio.get(path);

    return responseControl(response);
  }

  Future post({String path, dynamic data, Options options}) async {
    try {
      final response = await _dio.post(path, data: data, options: options);
      print("network response");
      print(response);
      return responseControl(response);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future put({String path, dynamic data}) async {
    final response = await _dio.put(path, data: data);

    return responseControl(response);
  }

  Future delete({String path, dynamic data}) async {
    final response = await _dio.delete(path, data: data);

    return responseControl(response);
  }

  Future download({String path, String savePath}) async {
    final response = await _dio.download(path, savePath);

    return responseControl(response);
  }

  dynamic responseControl(Response response) {
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = response.data;

        print("responseBody");
        print(responseBody);

        return responseBody;
        break;
      default:
        return false;
    }
  }
}
