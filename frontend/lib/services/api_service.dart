// frontend/lib/services/api_service.dart

import 'dart:convert'; // Needed for jsonEncode and jsonDecode
import 'package:http/http.dart' as http; // Import the http package

class ApiService {
  // Define the base URL of our backend.
  // IMPORTANT: For Android Emulator, this is 'http://10.0.2.2:3000'.
  // For web (Chrome) and iOS Simulator, it's 'http://localhost:3000'.
  static const String _baseUrl = 'http://localhost:3000/api';

  // --- AUTHENTICATION METHODS ---

  // Method to register a new user
  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String phone,
    required String password,
  }) async {
    // Construct the full URL for the registration endpoint
    final Uri registerUrl = Uri.parse('$_baseUrl/auth/register');

    try {
      // Make the POST request to the server
      final response = await http.post(
        registerUrl,
        headers: {
          // Tell the server we are sending JSON data with the CORRECT encoding
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          // Encode the user data from our app into a JSON string
          'name': name,
          'phone': phone,
          'password': password,
        }),
      );

      // Decode the response body that the server sends back
      final responseData = jsonDecode(response.body);

      // Check if the request was successful (HTTP status codes 200-299)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // If successful, return a success object with the server's data
        return {'success': true, 'data': responseData};
      } else {
        // If the server returned an error code, return a failure object
        return {'success': false, 'message': responseData['message'] ?? 'An unknown server error occurred'};
      }
    } catch (e) {
      // This 'catch' block handles network errors (e.g., no internet, server is down)
      print('An error occurred in registerUser: $e');
      return {'success': false, 'message': 'Could not connect to the server. Please check your internet connection.'};
    }
  }

  // We will add more methods here later, like loginUser, etc.
}