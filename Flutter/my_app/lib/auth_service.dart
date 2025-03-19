import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://192.168.100.12:8000/detection"; // Replace with your backend IP & port

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final String apiUrl = "$baseUrl/login/";
    print('Requesting URL: $apiUrl'); // Debug URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      // Validate response body before decoding
      if (response.body.isEmpty) {
        return {'success': false, 'message': 'Empty response from server'};
      }

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Ensure all fields are strings or provide defaults
        final message = responseData['message']?.toString() ?? 'Login successful!';
        final username = responseData['username']?.toString() ?? '';
        final email = responseData['email']?.toString() ?? '';

        return {
          'success': true,
          'message': message,
          'data': {'username': username, 'email': email},
        };
      } else if (response.statusCode == 400) {
        return {
          'success': false,
          'message': responseData['message']?.toString() ?? 'Invalid email or password',
        };
      } else if (response.statusCode == 404) {
        return {
          'success': false,
          'message': responseData['message']?.toString() ?? 'User not found',
        };
      } else {
        return {
          'success': false,
          'message': 'Login failed with status ${response.statusCode}: ${responseData['message']?.toString() ?? 'Unknown error'}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString().contains('SocketException')
            ? 'Network error: Check your connection'
            : 'An unexpected error occurred: $e',
      };
    }
  }
  /// Sign Up Method
  Future<Map<String, dynamic>> signUp(String name, String email, String password) async {
    final String apiUrl = "$baseUrl/signup/";  // Add a trailing slash// Backend API endpoint

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": name, // Added 'name' field
          "email": email,
          "password": password,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'Signup successful!',
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Signup failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  //update profile endpoint
  Future<Map<String, dynamic>> updateUserProfile({
    required String email, // Required to identify user
    String? username,
    String? newEmail,
    String? password,
    List<String>? allergies,
  }) async {
    final String apiUrl = "$baseUrl/update_user_profile/";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email, // Identify the user
          if (username != null) "username": username,
          if (newEmail != null) "newEmail": newEmail,
          if (password != null) "password": password,
          if (allergies != null) "allergies": allergies,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'Profile updated successfully!',
          'data': responseData,
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Profile update failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  /// Fetch user profile data from backend

  Future<Map<String, dynamic>> getUserProfile(String userEmail) async {
    final String apiUrl = "$baseUrl/get-user-profile/";

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": userEmail}),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': responseData,  // Send decoded response data
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to fetch profile',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }




}


