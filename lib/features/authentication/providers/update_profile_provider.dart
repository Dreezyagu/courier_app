import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/authentication/models/user_model.dart';
import 'package:ojembaa_courier/features/authentication/services/auth_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class UpdateProfileProvider extends StateNotifier<BaseNotifier<UserModel>> {
  UpdateProfileProvider() : super(BaseNotifier());

  void updateProfile(
      {required Map<String, dynamic> payload,
      required String id,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await AuthServices.updateProfile(payload, id);
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

final updateProfileProvider = StateNotifierProvider.family<
    UpdateProfileProvider, BaseNotifier<UserModel>, String>((ref, arg) {
  return UpdateProfileProvider();
});
