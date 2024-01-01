import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/homepage/services/home_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class UpdateStatusProvider extends StateNotifier<BaseNotifier<String>> {
  UpdateStatusProvider() : super(BaseNotifier<String>());

  void acceptDelivery(
      {VoidCallback? onSuccess,
      Function(String)? onError,
      required String id,
      required String status}) async {
    state = BaseNotifier.setLoading();
    final data2 = await HomeServices.updateStatus(id, status);
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

final updateStatusProvider =
    StateNotifierProvider<UpdateStatusProvider, BaseNotifier<String>>((ref) {
  return UpdateStatusProvider();
});
