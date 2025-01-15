abstract class Failure {
  final String message;

  Failure({
    required this.message,
  });
}

//local database ko failure
class LocalDatabaseFailure extends Failure {
  LocalDatabaseFailure({
    required super.message,
  });
}

//local database ko failure
class WebApiFailure extends Failure {
  final int statusCode;
  WebApiFailure({
    required super.message,
    required this.statusCode,
  });
}
