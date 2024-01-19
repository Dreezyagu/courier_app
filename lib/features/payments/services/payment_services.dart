import 'package:dio/dio.dart';
import 'package:ojembaa_courier/features/payments/models/get_transactions_model.dart';
import 'package:ojembaa_courier/utils/components/urls.dart';
import 'package:ojembaa_courier/utils/data_util/error_model.dart';
import 'package:ojembaa_courier/utils/helpers/http/http_helper.dart';

class PaymentServices {
  static final baseUrl = OjembaaUrls.getUrl("baseUrl");

  static final HttpHelper dio = HttpHelper();

  static Future<({List<TransactionsModel>? success, String? error})>
      getTransactions(String id) async {
    try {
      final response = await dio.get("${baseUrl}couriers/$id/transactions");

      if (response.data["status"] == "success") {
        final data = (response.data["data"] as List)
            .map((e) => TransactionsModel.fromMap(e))
            .toList();
        return (success: data, error: null);
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

  static Future<({String? success, String? error})> reconciliation(
      String id, Map<String, dynamic> payload) async {
    try {
      final response =
          await dio.post("${baseUrl}couriers/$id/payment", data: payload);

      if (response.data["status"] == "success") {
        return (success: "Success", error: null);
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
