import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ApiService {
  static const String baseUrl="http://10.0.2.2:3000";
  //static const String baseUrl="http://10.229.214.86:3000";



  static Future<void> testConnection() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/"),
      ).timeout(const Duration(seconds: 5));

      print("‼️‼️‼️‼️API Status: ${response.statusCode}");
      print("‼️‼️‼️‼️API Response: ${response.body}");
    } catch (e) {
      print("API Connection Error: $e");
    }
  }




  //Register User
  static Future<Map<String,dynamic>> registerUser({
    required String fullName,
    required String mobile,
    required String email,
    required String password
}) async{
    try{
      final response=await http.post(
        Uri.parse("$baseUrl/api/auth/register"),
        headers: {
          "Content-Type":"application/json",
        },
        body: jsonEncode({
          "fullName":fullName,
          "mobile":mobile,
          "email":email,
          "password":password
        }),
      );
      final data =jsonDecode(response.body);
      print("‼️‼️Register Status: ${response.statusCode} ‼️‼️");
      print("‼️‼️ Register Response: $data ‼️‼️");

      return data;

    }catch(e){
      return{
        "success":false,
        "message":"Unable to connect to the server"
      };
    }
  }



//// Login User APi
  static Future<Map<String,dynamic>> loginUser({
    required String email,
    required String password,
}) async {
    try{
      final response =await http.post(
        Uri.parse('$baseUrl/api/auth/login'),
        headers: 
          {
            'Content-Type':'application/json',
          },
        body: jsonEncode({
          'email':email,
          'password':password,
        })
      );
      final data=jsonDecode(response.body);
      print("‼️‼️Login Status: ${response.statusCode} ‼️‼️");
      print("Login Response: ${response.body}");
      return {
        'statusCode':response.statusCode,
        'data':data
      };
    }catch(e){

      print("login error: $e");
      return{
        'statusCode':500,
        'data':{
          'success':false,
          'message':'Unable to connect to server',
        }
      };
    }
  }

  //Update User Profile API
  static Future<Map<String,dynamic>> updateProfile({
    required String token,
    required String fullName,
    required String mobile,
    required String email,
    String? bloodGroup,
    double? height,
    String? birthDate,
}) async{
    try{
      final response= await http.put(
        Uri.parse("$baseUrl/api/user/profile"),
        headers: {
          "Content-Type":"application/json",
          "Authorization":"Bearer $token",
        },
        body: jsonEncode({
          "fullName":fullName,
          "mobile":mobile,
          "email":email,
          "bloodGroup":bloodGroup,
          "height":height,
          "birthDate":birthDate,
        }),
      );
      final data =jsonDecode(response.body);

      print("‼️‼️ Update Profile Status:${response.statusCode}");
      print("‼️‼️ Update Profile Response:${response.body}");

      return{
        "statusCode":response.statusCode,
        "data":data
      };
    }catch(e){
      print("Update profile error: $e");
      return{
        "statusCode":500,
        "data":{
          "success":false,
          "message":"Unable to connect to server"
        }
      };
    }
  }

  static Future<Map<String, dynamic>> uploadProfileImage({
    required String token,
    required String imagePath,
  }) async {
    try {
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse("$baseUrl/api/user/profile/image"),
      );

      request.headers['Authorization'] = 'Bearer $token';

      final mimeType = lookupMimeType(imagePath);

      if (mimeType == null) {
        return {
          "statusCode": 400,
          "data": {
            "success": false,
            "message": "Invalid image file",
          }
        };
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'profileImage',
          imagePath,
          contentType: MediaType.parse(mimeType),
        ),
      );

      final response = await request.send();

      final responseBody =
      await response.stream.bytesToString();

      print("‼️‼️ Upload Image Status: ${response.statusCode}");
      print("‼️‼️ Upload Image Response: $responseBody");

      final data = jsonDecode(responseBody);

      return {
        "statusCode": response.statusCode,
        "data": data,
      };
    } catch (e) {
      print("Upload profile image error: $e");

      return {
        "statusCode": 500,
        "data": {
          "success": false,
          "message": "Unable to connect to server",
        }
      };
    }
  }







  static Future<Map<String, dynamic>> getProfile() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        return {
          "statusCode": 401,
          "data": {
            "success": false,
            "message": "User is not logged in"
          }
        };
      }

      final response = await http.get(
        Uri.parse("$baseUrl/api/user/profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final data = jsonDecode(response.body);

      print("‼️‼️ Get Profile Status: ${response.statusCode}");
      print("‼️‼️ Get Profile Response: ${response.body}");

      return {
        "statusCode": response.statusCode,
        "data": data,
      };
    } catch (e) {
      print("Get profile error: $e");

      return {
        "statusCode": 500,
        "data": {
          "success": false,
          "message": "Unable to connect to server"
        }
      };
    }
  }

  static Future<String?> getSavedFullName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("fullName");
  }

  static Future<String?> getSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("email");
  }

  static Future<void> saveLoginSession({
    required String token,
    required Map<String,dynamic> user,
}) async{
    final prefs=await SharedPreferences.getInstance();

    await prefs.setString("token", token);
    await prefs.setString("userId", user["id"].toString());
    await prefs.setString("fullName", user["fullName"] ?? "");
    await prefs.setString("mobile", user["mobile"] ?? "");
    await prefs.setString("email", user["email"]??"");
    
    await prefs.setString("profileImage", user["profileImage"] ?? "");
  }
  static Future<String?> getToken() async{
    final prefs= await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
  static Future<String?> getProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("profileImage");
  }

  static Future<bool> isLoggedIn() async{
    final prefs=await SharedPreferences.getInstance();
    final token=prefs.getString("token");
    return token!=null && token.isNotEmpty;
  }
  static Future<void> logout() async{
    final prefs=await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<String> validateToken() async {
    final token = await getToken();
    if (token == null || token.isEmpty) return 'invalid';

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/user/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return 'valid';
        }
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        return 'invalid';
      }
      return 'valid'; // Other server errors assume valid temporarily
    } catch (e) {
      print('Token validation network error: $e');
      // Treat network errors as valid to allow offline access to cached session
      return 'network_error';
    }
  }
}