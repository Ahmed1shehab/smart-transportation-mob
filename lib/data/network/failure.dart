// lib/data/network/failure.dart
enum ApiInternalStatus {
  success,
  failure,
  noInternetConnection,
}

class Failure {
  final ApiInternalStatus status;
  final String message;

  Failure(this.status, this.message);
}