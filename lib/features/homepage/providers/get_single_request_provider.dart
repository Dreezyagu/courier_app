import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/homepage/model/delivery_model.dart';
import 'package:ojembaa_courier/features/homepage/services/home_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class GetSingleRequestProvider
    extends StateNotifier<BaseNotifier<DeliveryModel>> {
  GetSingleRequestProvider() : super(BaseNotifier());

  void getSingleRequest(String deliveryId,
      {Function(DeliveryModel)? onSuccess, Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await HomeServices.getSingleRequest(deliveryId);
    if (data.success is DeliveryModel) {
      state = BaseNotifier.setDone<DeliveryModel>(data.success!);
      if (onSuccess != null) {
        onSuccess(data.success!);
      }
    } else {
      state = BaseNotifier.setError(data.error ?? "An error ocurred");
      if (onError != null) {
        onError(data.error ?? "An error ocurred");
      }
    }
  }
}

final getSingleRequestProvider = StateNotifierProvider<GetSingleRequestProvider,
    BaseNotifier<DeliveryModel>>((ref) {
  return GetSingleRequestProvider();
});
