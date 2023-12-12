import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/authentication/services/auth_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class VehicleProvider extends StateNotifier<BaseNotifier<String>> {
  VehicleProvider() : super(BaseNotifier());

  void createVehicle(
      {required Map<String, dynamic> payload,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await AuthServices.addDeliveryVehicle(payload);
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

  void bankInfo(
      {required Map<String, dynamic> payload,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await AuthServices.bankInfo(payload);
    if (data.success is String) {
      state = BaseNotifier.setDone(data.success!);
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

  void addGuarantor(
      {required Map<String, dynamic> payload,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await AuthServices.addGuarantor(payload);
    if (data.success is String) {
      state = BaseNotifier.setDone(data.success!);
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

final vehicleProvider =
    StateNotifierProvider<VehicleProvider, BaseNotifier>((ref) {
  return VehicleProvider();
});
