import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/payments/services/payment_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class GetBalanceProvider extends StateNotifier<BaseNotifier<String>> {
  GetBalanceProvider() : super(BaseNotifier());

  Future<bool> getBalance(
      {VoidCallback? onSuccess, Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await PaymentServices.getBalance();
    if (data.success is String) {
      state = BaseNotifier.setDone<String>(data.success!);
      if (onSuccess != null) {
        onSuccess();
      }
      return true;
    } else {
      state = BaseNotifier.setError(data.error ?? "An error ocurred");
      if (onError != null) {
        onError(data.error ?? "An error ocurred");
      }
      return false;
    }
  }
}

final getBalanceProvider =
    StateNotifierProvider<GetBalanceProvider, BaseNotifier<String>>((ref) {
  return GetBalanceProvider();
});
