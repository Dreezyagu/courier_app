import 'package:flutter/material.dart';
import 'package:ojembaa_courier/utils/data_util/state_enum.dart';

class BaseNotifier<T> {
  final StateEnum? loadState;
  final T? data;
  final String? error;

  BaseNotifier({this.loadState, this.data, this.error});

  static BaseNotifier<T> setDone<T>(T data) {
    return BaseNotifier<T>(loadState: StateEnum.success, data: data);
  }

  static BaseNotifier<T> setError<T>(String error) {
    return BaseNotifier(loadState: StateEnum.error, error: error);
  }

  static BaseNotifier<T> setLoading<T>() {
    return BaseNotifier(loadState: StateEnum.loading);
  }

  static BaseNotifier<T> setInitial<T>() {
    return BaseNotifier(loadState: StateEnum.initial);
  }

  bool get isLoading => loadState == StateEnum.loading;

  Widget when({
    required Widget? loading,
    required Widget Function(String) error,
    required Widget Function(T) done,
  }) {
    return switch (loadState) {
          StateEnum.loading => loading,
          StateEnum.error => error(this.error ?? ''),
          StateEnum.success => done(data as T),
          _ => const SizedBox()
        } ??
        const SizedBox();
  }
}
