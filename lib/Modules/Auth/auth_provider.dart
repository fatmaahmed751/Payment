import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../Models/user_model.dart';
import '../../Utilities/shared_preferences.dart';
import 'auth_model.dart';

class AuthProvider extends ChangeNotifier {
  AuthState _authState = const AuthInitial();
  AuthFormState _formState = const AuthFormState();
  UserModel? _currentUser;

  // Getters
  AuthState get authState => _authState;
  AuthFormState get formState => _formState;
  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  // Initialize auth provider
  Future<void> initialize() async {
    await _loadCurrentUser();
  }

  // Load current user from shared preferences
  Future<void> _loadCurrentUser() async {
    try {
      final user = SharedPref.getCurrentUser();
      if (user != null) {
        _currentUser = user;
        _authState = AuthSuccess(user);
        notifyListeners();
      }
    } catch (e) {
      _authState = AuthError('Failed to load user data');
      notifyListeners();
    }
  }

  // Update form state
  void updateFormState(AuthFormState newState) {
    _formState = newState;
    notifyListeners();
  }

  // Update email
  void updateEmail(String email) {
    final isValid = _validateEmail(email);
    final newState = _formState.copyWith(
      email: email,
      isEmailValid: isValid,
      isFormValid: isValid && _formState.isPasswordValid && email.isNotEmpty && _formState.password.isNotEmpty,
    );
    updateFormState(newState);
  }

  // Update password
  void updatePassword(String password) {
    final isValid = _validatePassword(password);
    final newState = _formState.copyWith(
      password: password,
      isPasswordValid: isValid,
      isFormValid: isValid && _formState.isEmailValid && password.isNotEmpty && _formState.email.isNotEmpty,
    );
    updateFormState(newState);
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    final newState = _formState.copyWith(
      isPasswordVisible: !_formState.isPasswordVisible,
    );
    updateFormState(newState);
  }

  // Validate email
  bool _validateEmail(String email) {
    if (email.isEmpty) return true; // Don't show error for empty field initially
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Validate password
  bool _validatePassword(String password) {
    if (password.isEmpty) return true; // Don't show error for empty field initially
    return password.length >= 6;
  }

  // Login
  Future<void> login() async {
    if (!_formState.isFormValid) {
      _authState =  AuthValidationError({
        'email': _formState.isEmailValid ? '' : 'Please enter a valid email',
        'password': _formState.isPasswordValid ? '' : 'Password must be at least 6 characters',
      });
      notifyListeners();
      return;
    }

    _authState = const AuthLoading();
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock authentication - replace with actual API call
      if (_formState.email == 'demo@example.com' && _formState.password == 'password123') {
        final user = UserModel(
          id: '1',
          email: _formState.email,
          name: 'Test User',
          token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
          phone: '+1234567890',
          createdAt: DateTime.now(),
        );
        
        await _saveUserAndUpdateState(user);
      } else {
        _authState = const AuthError('Invalid email or password');
        notifyListeners();
      }
    } catch (e) {
      _authState = AuthError('Login failed: ${e.toString()}');
      notifyListeners();
    }
  }

  // Save user and update state
  Future<void> _saveUserAndUpdateState(UserModel user) async {
    try {
      await SharedPref.saveCurrentUser(user:user);
      _currentUser = user;
      _authState = AuthSuccess(user);
      notifyListeners();
    } catch (e) {
      _authState = AuthError('Failed to save user data');
      notifyListeners();
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await SharedPref.logout();
      _currentUser = null;
      _authState = const AuthInitial();
      _formState = const AuthFormState();
      notifyListeners();
    } catch (e) {
      _authState = AuthError('Logout failed: ${e.toString()}');
      notifyListeners();
    }
  }

  // Clear errors
  void clearErrors() {
    if (_authState is AuthError || _authState is AuthValidationError) {
      _authState = const AuthInitial();
      notifyListeners();
    }
  }

  // Reset form
  void resetForm() {
    _formState = const AuthFormState();
    notifyListeners();
  }
}
