import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/homepage/model/delivery_model.dart';
import 'package:ojembaa_courier/features/homepage/services/home_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class GetRequestsProvider
    extends StateNotifier<BaseNotifier<List<DeliveryModel>>> {
  GetRequestsProvider() : super(BaseNotifier());

  void getRequests({VoidCallback? onSuccess, Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await HomeServices.getRequests();
    if (data.success is List<DeliveryModel>) {
      state = BaseNotifier.setDone<List<DeliveryModel>>(data.success!);
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

final getRequestsProvider = StateNotifierProvider<GetRequestsProvider,
    BaseNotifier<List<DeliveryModel>>>((ref) {
  return GetRequestsProvider();
});
