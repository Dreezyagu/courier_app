import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/authentication/models/banks_model.dart';
import 'package:ojembaa_courier/features/authentication/services/auth_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class GetBanksProvider extends StateNotifier<BaseNotifier<List<BanksModel>>> {
  GetBanksProvider() : super(BaseNotifier());

  void getBanks({VoidCallback? onSuccess, Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await AuthServices.getBankList();
    if (data.success is List<BanksModel>) {
      state = BaseNotifier.setDone<List<BanksModel>>(data.success!);
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

  // void verifyOtp(
  //     {required String email,
  //     required String otp,
  //     VoidCallback? onSuccess,
  //     Function(String)? onError}) async {
  //   state = BaseNotifier.setLoading();
  //   final data = await AuthServices.verifyOtp(email, otp);
  //   if (data.success is String) {
  //     state = BaseNotifier.setDone(data.success!);
  //     if (onSuccess != null) {
  //       onSuccess();
  //     }
  //   } else {
  //     state = BaseNotifier.setError(data.error ?? "An error ocurred");
  //     if (onError != null) {
  //       onError(data.error ?? "An error ocurred");
  //     }
  //   }
  // }
}

final getBanksProvider =
    StateNotifierProvider<GetBanksProvider, BaseNotifier<List<BanksModel>>>(
        (ref) {
  return GetBanksProvider();
});
