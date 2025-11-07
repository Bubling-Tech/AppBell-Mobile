import 'package:flutter/foundation.dart';

enum ResultStatus { idle, loading, success, empty, error }

class Result<T> {
  final ResultStatus status;
  final T? data;
  final String? message;

  const Result._(this.status, {this.data, this.message});

  factory Result.idle({T? data}) => Result._(ResultStatus.idle, data: data);

  factory Result.loading() => const Result._(ResultStatus.loading);

  factory Result.success(T data) => Result._(ResultStatus.success, data: data);

  factory Result.empty({String? message}) =>
      Result._(ResultStatus.empty, message: message);

  factory Result.error(String message, {T? data}) =>
      Result._(ResultStatus.error, message: message, data: data);

  bool get isLoading => status == ResultStatus.loading;

  @override
  String toString() {
    return 'Result(status: ' + describeEnum(status) + ', data: ' +
        data.toString() + ', message: ' + (message ?? '-') + ')';
  }
}
