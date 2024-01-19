import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/payments/services/payment_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class ReconciliationProvider extends StateNotifier<BaseNotifier<String>> {
  ReconciliationProvider() : super(BaseNotifier());

  void reconciliation(String id, Map<String, dynamic> payload,
      {VoidCallback? onSuccess, Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await PaymentServices.reconciliation(id, payload);
    if (data.success is String) {
      state = BaseNotifier.setDone<String>(data.success!);
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

final reconciliationProvider =
    StateNotifierProvider<ReconciliationProvider, BaseNotifier<String>>((ref) {
  return ReconciliationProvider();
});
