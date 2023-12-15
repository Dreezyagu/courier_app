import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/authentication/models/user_model.dart';
import 'package:ojembaa_courier/features/authentication/services/auth_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class SignUpProvider extends StateNotifier<BaseNotifier<UserModel>> {
  SignUpProvider() : super(BaseNotifier());

  String? errorMessage;
  UserModel? userModel;

  void signUp(
      {required String firstName,
      required String lastName,
      required String phone,
      required String email,
      required String password,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data =
        await AuthServices.signUp(firstName, lastName, phone, email, password);
    if (data.success is UserModel) {
      state = BaseNotifier.setDone<UserModel>(data.success!);
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

final signUpProvider =
    StateNotifierProvider<SignUpProvider, BaseNotifier<UserModel>>((ref) {
  return SignUpProvider();
});
