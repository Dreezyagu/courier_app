import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ojembaa_courier/features/authentication/models/banks_model.dart';
import 'package:ojembaa_courier/features/authentication/models/user_model.dart';
import 'package:ojembaa_courier/utils/components/urls.dart';
import 'package:ojembaa_courier/utils/data_util/error_model.dart';
import 'package:ojembaa_courier/utils/helpers/http/http_helper.dart';
import 'package:path/path.dart';

class AuthServices {
  static final baseUrl = OjembaaUrls.getUrl("baseUrl");
  static const signUpUrl = "auth/sign-up";
  static const signInUrl = "auth/sign-in";
  static const getDetailsUrl = "me";
  static const verifyOtpUrl = "auth/verify-otp";
  static const resendOtpUrl = "auth/resend-otp";
  static const uploadAssetUrl = "assets/upload";
  static const updateProfileUrl = "users/update";
  static const addVehicleUrl = "couriers/delivery-tool";
  static const bankInfoUrl = "couriers/bank-info";
  static const guarantorUrl = "couriers/guarantor";

  static final HttpHelper dio = HttpHelper();

  static Future<({UserModel? success, String? error})> signUp(
    String firstName,
    lastName,
    phone,
    email,
    password,
  ) async {
    try {
      final response = await dio.post("$baseUrl$signUpUrl", data: {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "email": email,
        "password": password,
        "type": "COURIER"
      });

      if (response.data["status"] == "success") {
        final data = UserModel.fromMap(response.data["data"]);
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

  static Future<({Map<String, dynamic>? success, String? error})> signIn(
    String email,
    String password,
  ) async {
    try {
      final response = await dio.post("$baseUrl$signInUrl",
          data: {"email": email, "password": password});

      if (response.data["status"] == "success") {
        return (
          success: response.data["data"] as Map<String, dynamic>,
          error: null
        );
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

  static Future<({UserModel? success, String? error})> getDetails() async {
    try {
      final response = await dio.get(
        "$baseUrl$getDetailsUrl",
      );

      if (response.data["status"] == "success") {
        final data = UserModel.fromMap(response.data["data"]);
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

  static Future<({String? success, String? error})> uploadPicture(
      File file) async {
    try {
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path,
            contentType:
                MediaType('image', extension(file.path).replaceFirst(".", "")))
      });
      final response = await dio.post(
        "$baseUrl$uploadAssetUrl",
        data: formData,
      );

      if (response.data["status"] == "success") {
        return (success: response.data["data"]["url"] as String, error: null);
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

  static Future<({UserModel? success, String? error})> updateProfile(
      Map<String, dynamic> payload, String id) async {
    try {
      final response =
          await dio.patch("$baseUrl$updateProfileUrl/$id", body: payload);

      if (response.data["status"] == "success") {
        final data = UserModel.fromMap(response.data["data"]);
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

  static Future<({String? success, String? error})> verifyOtp(
      String email, otp) async {
    try {
      final response = await dio.post("$baseUrl$verifyOtpUrl",
          data: {"email": email, "otp": int.parse(otp)});

      if (response.data["status"] == "success") {
        return (success: response.data["data"].toString(), error: null);
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

  static Future<({String? success, String? error})> resendOtp(
      String email) async {
    try {
      final response =
          await dio.post("$baseUrl$resendOtpUrl", data: {"email": email});

      if (response.data["status"] == "success") {
        return (success: response.data["data"].toString(), error: null);
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

  static Future<({String? success, String? error})> addDeliveryVehicle(
      Map<String, dynamic> payload) async {
    try {
      final response = await dio.post("$baseUrl$addVehicleUrl", data: payload);

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

  static Future<({String? success, String? error})> bankInfo(
      Map<String, dynamic> payload) async {
    try {
      final response = await dio.post("$baseUrl$bankInfoUrl", data: payload);

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

  static Future<({String? success, String? error})> addGuarantor(
      Map<String, dynamic> payload) async {
    try {
      final response = await dio.post("$baseUrl$guarantorUrl", data: payload);

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

  static Future<({List<BanksModel>? success, String? error})>
      getBankList() async {
    try {
      final response = await dio.get("https://api.paystack.co/bank");
      if (response.statusCode == 200 && response.data["status"] == true) {
        final data = (response.data["data"] as List)
            .map((e) => BanksModel.fromMap(e))
            .toList();
        return (success: data, error: null);
      } else {
        ErrorModel? error;
        if (response.data != null) {
          error = ErrorModel.fromMap(response.data);
        }
        return (
          success: null,
          error: error?.error_message ?? "An error occured"
        );
      }
    } on DioException catch (e) {
      ErrorModel? error;
      if (e.response != null) {
        error = ErrorModel.fromMap(e.response?.data);
      }
      return (success: null, error: error?.error_message ?? "An error occured");
    } catch (e) {
      return (success: null, error: "An error occured");
    }
  }
}
