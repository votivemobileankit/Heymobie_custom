import 'package:equatable/equatable.dart';

import '../utils/utils.dart';

class NetworkApiCallState<T> extends Equatable {
  final NetworkRequestStatus? status;
  final T? data;
  final String? message;
  final String? statusValue;
  final NetworkErrorType? errorType;

  NetworkApiCallState.loading(this.message, this.statusValue)
      : status = NetworkRequestStatus.LOADING,
        data = null,
        errorType = null;

  NetworkApiCallState.completed(this.data, this.message, this.statusValue)
      : status = NetworkRequestStatus.COMPLETED,
        errorType = null;

  NetworkApiCallState.error(this.message, this.statusValue, this.errorType)
      : status = NetworkRequestStatus.ERROR,
        data = null;

  NetworkApiCallState.pending(this.message, this.statusValue, this.errorType)
      : status = NetworkRequestStatus.PENDING,
        data = null;

  @override
  String toString() {
    return "Status : $status \n StatusValue:$statusValue \n Message : $message \n Data : $data \n errorType = $errorType";
  }

  @override
  List<Object> get props => [status!, statusValue!, data!, message!, errorType!];
}
