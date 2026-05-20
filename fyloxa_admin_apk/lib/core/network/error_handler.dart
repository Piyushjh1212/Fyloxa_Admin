import 'package:dio/dio.dart';

class Failure {
  final String message;
  Failure(this.message);
}

class ErrorHandler {
  static String handle(dynamic error) {
    if (error is DioException) {
      switch (error.response?.statusCode) {
        case 400: return "Bad Request";
        case 401: return "Unauthorized - Please login again";
        case 404: return "Resource not found";
        case 500: return "Internal Server Error";
        default: return "Something went wrong";
      }
    }
    return "Unexpected error occurred";
  }
}