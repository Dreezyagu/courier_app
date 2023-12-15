import 'dart:async';
import 'package:dio/dio.dart';
import 'package:ojembaa_courier/utils/helpers/storage/storage_helper.dart';
import 'package:ojembaa_courier/utils/helpers/storage/storage_keys.dart';

class HttpHelper {
  static Dio? _client;

  static Future<Map<String, String>> _getHeaders({String? contentType}) async {
    final accessToken = await StorageHelper.getString(StorageKeys.accessToken);
    Map<String, String> headers = {};
    headers['Content-Type'] = contentType ?? 'application/json';
    if (accessToken != null) headers['Authorization'] = 'Bearer $accessToken';

    return headers;
  }

  static Future<Dio> _getInstance(
      {bool enabledDioLogger = false, String? contentType}) async {
    _client ??= Dio();

    _client!.options.headers = await _getHeaders(contentType: contentType);

    return _client!;
  }

  Future<Response> get(String url, {Options? options}) async {
    final instance = await (_getInstance(enabledDioLogger: false));
    return instance.get(url, options: options);
  }

  Future<Response> post(String url,
      {dynamic data,
      Options? options,
      ProgressCallback? progressCallback,
      String? contentType}) async {
    final instance =
        await (_getInstance(contentType: contentType, enabledDioLogger: true));
    return instance.post(url,
        data: data, onSendProgress: progressCallback, options: options);
  }

  Future<Response> put(String url, {dynamic body}) async {
    final instance = await (_getInstance());
    return instance.put(url, data: body);
  }

  Future<Response> patch(String url, {dynamic body}) async {
    final instance = await (_getInstance());
    return instance.patch(url, data: body);
  }

  Future<Response> delete(String url, {dynamic body}) async {
    final instance = await (_getInstance());
    return instance.delete(url);
  }
}
