import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/authentication/models/user_model.dart';
import 'package:ojembaa_courier/features/authentication/services/auth_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';
import 'package:ojembaa_courier/utils/helpers/storage/storage_helper.dart';
import 'package:ojembaa_courier/utils/helpers/storage/storage_keys.dart';

class SignInProvider extends StateNotifier<BaseNotifier<UserModel>> {
  SignInProvider() : super(BaseNotifier<UserModel>());

  void signIn(
      {required String email,
      required String password,
      Function(UserModel)? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await AuthServices.signIn(email, password);
    if (data.success is Map<String, dynamic>) {
      StorageHelper.setString(
          StorageKeys.accessToken, data.success?["accessToken"]);
      StorageHelper.setString(
          StorageKeys.refreshToken, data.success?["refreshToken"]);

      final data2 = await AuthServices.getDetails();

      if (data2.success is UserModel) {
        state = BaseNotifier.setDone<UserModel>(data2.success!);
        if (onSuccess != null) {
           onSuccess(data2.success!);
        }
      } else {
        state = BaseNotifier.setError(data2.error ?? "An error ocurred");

        if (onError != null) {
          onError(data2.error ?? "An error ocurred");
        }
      }
    } else {
      state = BaseNotifier.setError(data.error ?? "An error ocurred");
      if (onError != null) {
        onError(data.error ?? "An error ocurred");
      }
    }
  }
}

final signInProvider =
    StateNotifierProvider<SignInProvider, BaseNotifier<UserModel>>((ref) {
  return SignInProvider();
});
