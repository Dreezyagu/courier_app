import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/homepage/services/home_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class OnlineStatusProvider extends StateNotifier<BaseNotifier<String>> {
  OnlineStatusProvider() : super(BaseNotifier<String>());

  void onlineStatus(
      {VoidCallback? onSuccess,
      Function(String)? onError,
      required String id,
      required bool status}) async {
    state = BaseNotifier.setLoading();
    final data2 = await HomeServices.onlineStatus(id, status);
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

  void updateLocation(
      {VoidCallback? onSuccess,
      Function(String)? onError,
      required String id,
      required Map<String, double> payload}) async {
    state = BaseNotifier.setLoading();
    final data2 = await HomeServices.updateLocation(id, payload);
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

final onlineStatusProvider =
    StateNotifierProvider<OnlineStatusProvider, BaseNotifier<String>>((ref) {
  return OnlineStatusProvider();
});
