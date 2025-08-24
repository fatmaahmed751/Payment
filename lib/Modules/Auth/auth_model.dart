import 'package:equatable/equatable.dart';
import '../../Models/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final UserModel user;
  
  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;
  
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthValidationError extends AuthState {
  final Map<String, String> errors;
  
  const AuthValidationError(this.errors);

  @override
  List<Object?> get props => [errors];
}

class AuthFormState extends Equatable {
  final String email;
  final String password;
  final bool isPasswordVisible;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isFormValid;

  const AuthFormState({
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.isEmailValid = true,
    this.isPasswordValid = true,
    this.isFormValid = false,
  });

  AuthFormState copyWith({
    String? email,
    String? password,
    bool? isPasswordVisible,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isFormValid,
  }) {
    return AuthFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    isPasswordVisible,
    isEmailValid,
    isPasswordValid,
    isFormValid,
  ];
}
