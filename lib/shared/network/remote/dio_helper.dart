import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://newsapi.org',
        receiveDataWhenStatusError: true,
    ));
  }


  ///!
  /// functions not use on this app
  /// amr osama
  /// used on salla app
  static Future<Response> getData(
      {
        required String url,
        Map<String, dynamic>? query,
        String lang = 'en',
        String? token
      }) async
  {
    dio!.options.headers =
    {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token??'',
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String path,
      dynamic query,
      required dynamic data,
      String lang = 'en',
      String? token
      }) async {
    dio!.options.headers =
    {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token??'',
    };
    return await dio!.post(path, queryParameters: query, data: data);
  }

  static Future<Response> updateData(
      {required String path,
        dynamic query,
        dynamic data,
        String lang = 'en',
        String? token
      }) async {
    dio!.options.headers =
    {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token??'',
    };
    return await dio!.put(path, queryParameters: query, data: data);
  }

  static Future<Response> deleteData(
      {required String path,
        dynamic query,
        dynamic data,
        String lang = 'en',
        String? token
      }) async {
    dio!.options.headers =
    {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token??'',
    };
    return await dio!.delete(path, queryParameters: query, data: data);
  }
}
