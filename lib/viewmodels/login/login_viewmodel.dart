import 'package:flutter/foundation.dart';
import 'package:mvvm_project/data/implementations/repositories/auth_repository.dart';
import 'package:mvvm_project/domain/entities/auth_session.dart';

class LoginViewmodel extends ChangeNotifier {
  final AuthRepository repo;
  LoginViewmodel(this.repo);

  bool loading = false;
  String? error;
  AuthSession? session;

  Future<bool> login(String userName, String password) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final u = userName.trim();
      final p = password.trim();

      if (u.isEmpty || p.isEmpty) {
        error = 'Username or password cannot be empty';
        loading = false;
        notifyListeners();
        return false;
      }
      session = await repo.login(u, p);///tra Entity
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      session = null;
      error = e.toString().replaceAll('Exception: ', '');
      loading = false;
      notifyListeners();
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void cleanError() {
    if (error != null) {
      error = null;
      notifyListeners();
    }
  }
}
