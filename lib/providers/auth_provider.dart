import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _user != null;
  String? get userName => _user?.userMetadata?['full_name'] as String?;

  AuthProvider() {
    _initializeAuth();
  }

  void _initializeAuth() {
    // Verificar se já existe um usuário logado
    _user = _authService.currentUser;
    
    // Escutar mudanças no estado de autenticação
    _authService.authStateChanges.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;
      
      switch (event) {
        case AuthChangeEvent.signedIn:
          _user = session?.user;
          _errorMessage = null;
          notifyListeners();
          break;
        case AuthChangeEvent.signedOut:
          _user = null;
          _errorMessage = null;
          notifyListeners();
          break;
        case AuthChangeEvent.userUpdated:
          _user = session?.user;
          notifyListeners();
          break;
        default:
          break;
      }
    });
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    _clearError();
    
    try {
      final response = await _authService.signInWithEmail(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        _user = response.user;
        _setLoading(false);
        return true;
      } else {
        _setError('Falha no login. Tente novamente.');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError(_getErrorMessage(e));
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signUp(String email, String password, {String? fullName}) async {
    _setLoading(true);
    _clearError();
    
    try {
      final response = await _authService.signUpWithEmail(
        email: email,
        password: password,
        fullName: fullName,
      );
      
      if (response.user != null) {
        _user = response.user;
        _setLoading(false);
        return true;
      } else {
        _setError('Falha no registo. Tente novamente.');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError(_getErrorMessage(e));
      _setLoading(false);
      return false;
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    _clearError();
    
    try {
      await _authService.signOut();
      _user = null;
      _setLoading(false);
    } catch (e) {
      _setError(_getErrorMessage(e));
      _setLoading(false);
    }
  }

  Future<void> resetPassword(String email) async {
    _setLoading(true);
    _clearError();
    
    try {
      await _authService.resetPassword(email);
      _setLoading(false);
    } catch (e) {
      _setError(_getErrorMessage(e));
      _setLoading(false);
    }
  }

  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    _clearError();
    
    try {
      final success = await _authService.signInWithGoogle();
      
      if (success) {
        _setLoading(false);
        return true;
      } else {
        _setError('Falha no login com Google. Tente novamente.');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError(_getErrorMessage(e));
      _setLoading(false);
      return false;
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  String _getErrorMessage(dynamic error) {
    if (error is AuthException) {
      switch (error.message) {
        case 'Invalid login credentials':
          return 'Email ou palavra-passe incorretos.';
        case 'Email not confirmed':
          return 'Email não confirmado. Verifique a sua caixa de correio.';
        case 'User already registered':
          return 'Este email já está registado.';
        case 'Password should be at least 6 characters':
          return 'A palavra-passe deve ter pelo menos 6 caracteres.';
        default:
          return 'Erro: ${error.message}';
      }
    }
    return 'Ocorreu um erro inesperado. Tente novamente.';
  }
}
