import 'package:dio/dio.dart'; // Isko import karna mat bhoolna bhai
import '../../../../core/network/api_client.dart';
import '../../../../core/network/error_handler.dart';
import '../../../../core/storage/secure_storage.dart';

class AuthRepositoryImpl {
  final ApiClient apiClient;

  AuthRepositoryImpl(this.apiClient);

  // 1. Login Logic
  Future<void> login(String email, String password) async {
    try {
      final response = await apiClient.dio.post(
        'auth/login', 
        data: {
          'email': email, 
          'password': password,
        },
      );

      final String token = response.data['token']; 
      final storage = SecureStorage(); 
      await storage.saveToken(token);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  // 2. Register Logic (With Deep Debugging)
  Future<void> register({
    required String name, 
    required String email, 
    required String phone, 
    required String password,
  }) async {
    try {
      // TERMINAL PRINT: Pehle check karein data ja kya raha hai
      print("🚀 SENDING DATA TO BACKEND:");
      print({
        'fullName': name,
        'email': email,
        'phoneNumber': phone,
        'password': password,
      });

      final response = await apiClient.dio.post(
        'auth/register', 
        data: {
          'fullName': name,
          'email': email,
          'phoneNumber': phone,
          'password': password,
        },
      );

      if (response.data != null && response.data['token'] != null) {
        final String token = response.data['token']; 
        final storage = SecureStorage(); 
        await storage.saveToken(token);
      }
    } on DioException catch (e) {
      // 🔥 YEH PRINTS AAPKO TERMINAL MEIN ASLI GALTIE BATAYENGE
      print("❌ DIO ERROR CAUGHT!");
      if (e.response != null) {
        print("STATUS CODE: ${e.response?.statusCode}");
        print("BACKEND REAL MESSAGE: ${e.response?.data}");
        
        // Agar backend koi message bhej raha hai toh use exception bana kar throw karo
        if (e.response?.data != null && e.response?.data['message'] != null) {
          throw Exception(e.response?.data['message']);
        }
      } else {
        print("ERROR WITHOUT RESPONSE: ${e.message}");
      }
      throw ErrorHandler.handle(e);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}