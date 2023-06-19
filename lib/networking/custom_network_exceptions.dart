
import 'package:grambunny_customer/utils/utils.dart';

class CustomNetworkException implements Exception {
  final message;
  final prefix;
  final NetworkErrorType? errorType;

  CustomNetworkException([
    this.message,
    this.prefix,
     this.errorType,
  ]);

  String toString() {
    return "$prefix$message";
  }
}

class NoInternetNetworkException extends CustomNetworkException {
  NoInternetNetworkException()
      : super("You are not connected to internet", "No Internet: ",
            NetworkErrorType.NO_INTERNET);
}

class FetchDataNetworkException extends CustomNetworkException {
  FetchDataNetworkException([String? message, NetworkErrorType? errorType])
      : super(message, "Error During Communication: ", errorType);
}

class BadRequestNetworkException extends CustomNetworkException {
  BadRequestNetworkException([message, errorType])
      : super(message, "Invalid Request: ", errorType);
}

class UnauthorisedNetworkException extends CustomNetworkException {
  UnauthorisedNetworkException([message, errorType])
      : super(message, "Unauthorised: ", errorType);
}

class InvalidInputNetworkException extends CustomNetworkException {
  InvalidInputNetworkException([String? message, NetworkErrorType? errorType])
      : super(message, "Invalid Input: ", errorType);
}
