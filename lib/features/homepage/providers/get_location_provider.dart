import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ojembaa_courier/features/homepage/services/home_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class GetLocationProvider extends StateNotifier<BaseNotifier<Position>> {
  GetLocationProvider() : super(BaseNotifier<Position>());

  void getCurrentLocation(
      {Function(Position)? onSuccess, Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data2 = await HomeServices.getCurrentLocation();
    if (data2.success is Position) {
      state = BaseNotifier.setDone<Position>(data2.success!);
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
}

final getLocationProvider =
    StateNotifierProvider<GetLocationProvider, BaseNotifier<Position>>((ref) {
  return GetLocationProvider();
});
