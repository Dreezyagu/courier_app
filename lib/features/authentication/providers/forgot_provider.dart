import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/authentication/services/auth_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class ForgotProvider extends StateNotifier<BaseNotifier<String>> {
  ForgotProvider() : super(BaseNotifier<String>());

  void forgotPass(
      {required String email,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();

    final data2 = await AuthServices.forgotPass(email);

    if (data2.success is String) {
      state = BaseNotifier.setDone<String>(data2.success!);
      if (onSuccess != null) {
        onSuccess();
      }
    } else {
      state = BaseNotifier.setError(data2.error ?? "An error ocurred");

      if (onError != null) {
        onError(data2.error ?? "An error ocurred");
      }
    }
  }

  void resetPass(
      {required String otp,
      required String password,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();

    final data2 =
        await AuthServices.resetPass({"otp": otp, "password": password});

    if (data2.success is String) {
      state = BaseNotifier.setDone<String>(data2.success!);
      if (onSuccess != null) {
        onSuccess();
      }
    } else {
      state = BaseNotifier.setError(data2.error ?? "An error ocurred");

      if (onError != null) {
        onError(data2.error ?? "An error ocurred");
      }
    }
  }
}

final forgotProvider =
    StateNotifierProvider<ForgotProvider, BaseNotifier<String>>((ref) {
  return ForgotProvider();
});
