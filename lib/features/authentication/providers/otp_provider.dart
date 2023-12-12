import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/authentication/services/auth_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class OtpProvider extends StateNotifier<BaseNotifier<String>> {
  OtpProvider() : super(BaseNotifier());

  void resendOtp(
      {required String email,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await AuthServices.resendOtp(email);
    if (data.success is String) {
      state = BaseNotifier.setDone(data.success!);
      if (onSuccess != null) {
        onSuccess();
      }
    } else {
      state = BaseNotifier.setError(data.error ?? "An error ocurred");
      if (onError != null) {
        onError(data.error ?? "An error ocurred");
      }
    }
  }

  void verifyOtp(
      {required String email,
      required String otp,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await AuthServices.verifyOtp(email, otp);
    if (data.success is String) {
      state = BaseNotifier.setDone(data.success!);
      if (onSuccess != null) {
        onSuccess();
      }
    } else {
      state = BaseNotifier.setError(data.error ?? "An error ocurred");
      if (onError != null) {
        onError(data.error ?? "An error ocurred");
      }
    }
  }
}

final otpProvider = StateNotifierProvider<OtpProvider, BaseNotifier>((ref) {
  return OtpProvider();
});
