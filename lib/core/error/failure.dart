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

class ApiFailure extends Failure {
  final int? statusCode;
  ApiFailure({
    this.statusCode,
    required super.message,
  });
}
