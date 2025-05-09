import 'dart:convert';
import '../constant.dart';
import '../models/api_response.dart';
import 'package:http/http.dart' as http ;
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


// login
Future<APIResponse> login(String email, String password) async {
  APIResponse apiResponse = APIResponse();
  try {
    final response = await http.post(
      Uri.parse(loginURL),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['error'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403 :
        apiResponse.error = jsonDecode(response.body)['message'];
        break;

        default:
          apiResponse.error = somethingWentWrong;
          break ;
    }
  } catch (e) {
    apiResponse.error = somethingWentWrong;
  }
  return apiResponse;
}




// Register
Future<APIResponse> register(String name , String email, String password) async {
  APIResponse apiResponse = APIResponse();
  try {
    final response = await http.post(
      Uri.parse(registerURL),
      headers: {'Accept': 'application/json'},
      body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation':password
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['error'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403 :
        apiResponse.error = jsonDecode(response.body)['message'];
        break;

      default:
        apiResponse.error = somethingWentWrong;
        break ;
    }
  } catch (e) {
    apiResponse.error = somethingWentWrong;
  }
  return apiResponse;
}


// get User Details
Future<APIResponse> getUserDetail() async {
  APIResponse apiResponse = APIResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(userURL),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    switch (response.statusCode) {
      case 200:
        final data = jsonDecode(response.body);
        apiResponse.data = User.fromJsonWithoutToken(data['user']);
        break;
      case 422:
        final errors = jsonDecode(response.body)['error'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = somethingWentWrong;
  }
  return apiResponse;
}



// get token
Future<String> getToken() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '' ;
}

// get user id
Future<int> getId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('UserId') ?? 0;
}

// logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('token');
}





