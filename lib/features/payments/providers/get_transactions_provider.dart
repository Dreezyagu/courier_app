import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/payments/models/get_transactions_model.dart';
import 'package:ojembaa_courier/features/payments/services/payment_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class GetTransactionsProvider
    extends StateNotifier<BaseNotifier<List<TransactionsModel>>> {
  GetTransactionsProvider() : super(BaseNotifier());

  void getRequests(String id,
      {VoidCallback? onSuccess, Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await PaymentServices.getTransactions(id);
    if (data.success is List<TransactionsModel>) {
      state = BaseNotifier.setDone<List<TransactionsModel>>(data.success!);
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

final getTransactionsProvider = StateNotifierProvider<GetTransactionsProvider,
    BaseNotifier<List<TransactionsModel>>>((ref) {
  return GetTransactionsProvider();
});
