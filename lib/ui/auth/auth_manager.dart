import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../services/pocketbase_client.dart';

class AuthManager with ChangeNotifier {
  late final AuthService _authService;
  User? _loggedInUser;

  User? get loggedInUser => _loggedInUser;
  bool get isAuth => _loggedInUser != null;

  AuthManager() {
    _authService = AuthService(onAuthChange: (User? user) {
      _loggedInUser = user;
      notifyListeners();
    });
  }

  Future<User> signup(String email, String password) async {
    return _authService.signup(email, password);
  }

  Future<User> login(String email, String password) async {
    return _authService.login(email, password);
  }

  Future<void> tryAutoLogin() async {
    final user = await _authService.getUserFromStore();
    if (user != null) {
      _loggedInUser = user;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    return _authService.logout();
  }
}
