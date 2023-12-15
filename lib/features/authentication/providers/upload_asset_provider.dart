import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_courier/features/authentication/services/auth_services.dart';
import 'package:ojembaa_courier/utils/data_util/base_notifier.dart';

class UploadAssetProvider extends StateNotifier<BaseNotifier<String>> {
  UploadAssetProvider() : super(BaseNotifier());

  void uploadPicture(
      {required File file,
      Function(String)? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await AuthServices.uploadPicture(file);
    if (data.success is String) {
      state = BaseNotifier.setDone<String>(data.success!);
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

final uploadAssetProvider = StateNotifierProvider.family<UploadAssetProvider,
    BaseNotifier<String>, String>((ref, arg) {
  return UploadAssetProvider();
});
