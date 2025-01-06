import 'package:flutter/widgets.dart';

extension AsyncSnapshotHelper<T> on AsyncSnapshot<T> {
  bool get doneWithData => hasData;
  bool get doneWithoutData =>
      connectionState == ConnectionState.done && !hasData;
  bool get doneWithError => connectionState == ConnectionState.done && hasError;

  Widget when({
    required Widget Function(T data) data,
    required Widget Function() loading,
    required Widget Function(Object? error, StackTrace? stackTrace) failure,
  }) {
    if (doneWithData) {
      return data(requireData);
    } else if (doneWithError) {
      return failure(error, stackTrace);
    } else {
      return loading();
    }
  }
}
