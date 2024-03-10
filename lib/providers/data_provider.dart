import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../data/models/user_model.dart';

class DataProvider with ChangeNotifier {
  bool isLoggedIn = false;
  bool cguAccepted = false;
  bool passwordChanged = false;
  bool profileSaved = false;
  LoginScreenState state = LoginScreenState.initial;
  String errorMessage = '';
  UserModel? user;
  // List<Activity> activities = [];
  // List<Pack> packs = [];
  String API = "http://api.prod";
  // String API = "http://localhost:8081";

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login(String username, String password) async {
    setState(LoginScreenState.loading);
    usernameController.text = username;
    passwordController.text = password;
    isLoggedIn = true;
    String tmplogin = RegExp(r'^[0-9]+$').hasMatch(username) ? username.substring(username.length - 9) : username;
    try {
      final response = await http.post(
        Uri.parse(API +'/api/auth/authenticate'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': tmplogin,
          'password': password,
          'mode': 'email'
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final accessToken = responseData['access_token'];

        // Store the access token in shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);

        final userJson = responseData['user'];
        user = UserModel.fromJson(userJson);
        isLoggedIn = true;
        passwordChanged = user?.passwordReset == 1;
        profileSaved = user?.customer.phone != '' || user?.customer.email != '';
        // cguAccepted = user?.cgu == 1;
        // await fetchActivities();
        // await fetchPacks();
        setState(LoginScreenState.loaded);
      } else {
        errorMessage =
            'Échec de la connexion. Veuillez vérifier vos informations d\'identification.';
        setState(LoginScreenState.error);
      }
    } catch (e) {
      errorMessage =
          'Une erreur s\'est produite. Veuillez réessayer plus tard.';
      if (kDebugMode) {
        print(e);
      }
      setState(LoginScreenState.error);
    }
  }

  void setState(LoginScreenState state) {
    this.state = state;
    notifyListeners();
  }

  // Retrieve the access token from shared preferences
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<void> resetPassword(String password) async {
    setState(LoginScreenState.loading);
    final accessToken = await getAccessToken();
    // passwordController.text = password;
    String url = API +'/api/member/user/${user?.id}/password/reset';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode({
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        passwordChanged = true;
        setState(LoginScreenState.loaded);
      } else {
        errorMessage =
        'Échec de la connexion. Veuillez vérifier vos informations d\'identification.';
        setState(LoginScreenState.error);
      }
    } catch (e) {
      errorMessage =
      'Une erreur s\'est produite. Veuillez réessayer plus tard.';
      if (kDebugMode) {
        print(e);
      }
      setState(LoginScreenState.error);
    }
  }

  Future<void> logout() async {
    // Clear user data and access token
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    user = null;
    usernameController.text = '';
    passwordController.text = '';

    // Clear activities and packs data
    // activities = [];
    // packs = [];

    // Update the login state
    isLoggedIn = false;
    notifyListeners();

    // Additional actions or redirection logic can be added here
  }

  Future<void> saveMemberInfos(String email, String phone) async {
    setState(LoginScreenState.loading);
    final accessToken = await getAccessToken();
    // passwordController.text = password;
    String url = API +'/api/member/user/${user?.customer.id}/member/infos';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode({
          'email': email,
          'phone': phone,
        }),
      );

      if (response.statusCode == 200) {
        profileSaved = true;
        setState(LoginScreenState.loaded);
      } else {
        errorMessage =
        'Échec de la connexion. Veuillez vérifier vos informations d\'identification.';
        setState(LoginScreenState.error);
      }
    } catch (e) {
      errorMessage =
      'Une erreur s\'est produite. Veuillez réessayer plus tard.';
      if (kDebugMode) {
        print(e);
      }
      setState(LoginScreenState.error);
    }
  }

  // Future<void> saveCguAccepted(bool value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('cgu_accepted', value);
  // }

  Future<void> forgotPassword(String username) async {
    setState(LoginScreenState.loading);
    final accessToken = await getAccessToken();
    // passwordController.text = password;
    String url = API +'/api/member/user/forgotpassword';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode({
          'username': usernameController.text,
        }),
      );

      if (response.statusCode == 200) {
        passwordChanged = true;
        setState(LoginScreenState.loaded);
      } else {
        errorMessage =
        'Échec de la connexion. Veuillez vérifier vos informations d\'identification.';
        setState(LoginScreenState.error);
      }
    } catch (e) {
      errorMessage =
      'Une erreur s\'est produite. Veuillez réessayer plus tard.';
      if (kDebugMode) {
        print(e);
      }
      setState(LoginScreenState.error);
    }
  }
}






enum LoginScreenState { initial, loading, loaded, error }
