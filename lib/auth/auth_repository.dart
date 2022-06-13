import 'dart:convert';
import 'package:guestay/auth/user.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  User _user = User();
  User get user => _user;
  final String url = 'morning-coast-93264.herokuapp.com';
  final String urlSignIn = '/users/sign_in.json';
  final String urlSignUp = '/users.json';

  Future<User> attemptAutoLogin() async {
    await Future.delayed(Duration(seconds: 2));
    throw Exception('Not signed in');
  }

  Future<User> login({required String email, required String password}) async {
    try {
      final response = await http.post(Uri.https(url, urlSignIn),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'user': {
              'email': email,
              'password': password,
            }
          }));
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _user = User.fromJson(response.headers, jsonDecode(response.body));
        return user;
      } else {
        throw Exception('Could not authorize');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> signUp({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String name,
    required String lastName,
    required String username,
  }) async {
    try {
      final response = await http.post(Uri.https(url, urlSignUp),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'user': {
              'name': name,
              'lastname': lastName,
              'username': username,
              'email': email,
              'password': password,
              'password_confirmation': passwordConfirmation,
            }
          }));
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _user = User.fromJson(response.headers, jsonDecode(response.body));
        return user;
      } else {
        throw Exception('Could not sign up');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  User signOut() {
    // _user = User();

    return User();
  }
}
