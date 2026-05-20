import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // .env use karne ke liye
import '../storage/secure_storage.dart'; // Token nikalne ke liye

class ApiClient {
  late Dio dio;
  final SecureStorage _secureStorage = SecureStorage();

  ApiClient() {
    dio = Dio(
      BaseOptions(
        // ApiConstants.baseUrl ki jagah ab ye direct .env file se URL uthayega
        baseUrl: dotenv.env['API_BASE_URL'] ?? 'http://10.34.204.36:5000/api/v1/a7x20261/fyloxa/', 
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Interceptors add karna
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // SecureStorage se token nikal kar automatically har API call ke header mein attach karega
          final token = await _secureStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }
}