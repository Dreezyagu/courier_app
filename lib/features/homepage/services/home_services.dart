import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ojembaa_courier/utils/components/urls.dart';
import 'package:ojembaa_courier/utils/data_util/error_model.dart';
import 'package:ojembaa_courier/utils/helpers/http/http_helper.dart';

class HomeServices {
  static final baseUrl = OjembaaUrls.getUrl("baseUrl");

  static final HttpHelper dio = HttpHelper();

  static const updateLocationUrl = "auth/verify-otp";

  static Future<({Position? success, String? error})> getCurrentLocation(
      {Position? success, String? error}) async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      return (success: position, error: null);
    } catch (e) {
      return (success: null, error: "An error occurred");
    }
  }

  static Future<({String? success, String? error})> updateLocation(
      String id, Map<String, double> payload) async {
    try {
      final response =
          await dio.post("${baseUrl}couriers/$id/location", data: payload);

      if (response.data["status"] == "success") {
        return (success: response.data["message"].toString(), error: null);
      } else {
        final error = ErrorModel.fromMap(response.data);
        return (success: null, error: error.message ?? "An error occured");
      }
    } on DioException catch (e) {
      ErrorModel? error;
      if (e.response != null) {
        error = ErrorModel.fromMap(e.response?.data);
      }
      return (success: null, error: error?.message ?? "An error occured");
    } catch (e) {
      return (success: null, error: "An error occured");
    }
  }

  static Future<({String? success, String? error})> onlineStatus(
      String id, bool status) async {
    try {
      final response = await dio.patch("${baseUrl}couriers/$id/online-status",
          body: {"isOnline": status});

      if (response.data["status"] == "success") {
        return (success: response.data["message"].toString(), error: null);
      } else {
        final error = ErrorModel.fromMap(response.data);
        return (success: null, error: error.message ?? "An error occured");
      }
    } on DioException catch (e) {
      ErrorModel? error;
      if (e.response != null) {
        error = ErrorModel.fromMap(e.response?.data);
      }
      return (success: null, error: error?.message ?? "An error occured");
    } catch (e) {
      return (success: null, error: "An error occured");
    }
  }
}
