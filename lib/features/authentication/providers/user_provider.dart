import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/authentication/models/user_model.dart';
import 'package:ojembaa_courier/features/authentication/services/auth_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class UserProvider extends StateNotifier<BaseNotifier<UserModel>> {
  UserProvider() : super(BaseNotifier<UserModel>());

  void getDetails(
      {Function(UserModel)? onSuccess, Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
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
  }

  void updateUserModel(UserModel user) {
    state = BaseNotifier.setLoading();
    state = BaseNotifier.setDone<UserModel>(user);
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, BaseNotifier<UserModel>>((ref) {
  return UserProvider();
});
