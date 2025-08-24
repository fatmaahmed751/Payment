# Authentication Module

This module provides a complete authentication system for the Payment app with different states and proper state management.

## Features

- **Login Screen** with email and password validation
- **State Management** using Provider pattern
- **Form Validation** with real-time feedback
- **Error Handling** for various authentication scenarios
- **Persistent Login** using SharedPreferences
- **Responsive Design** using ScreenUtil
- **Theme Integration** with the app's design system

## Architecture

### Models
- `UserModel`: Represents user data with JSON serialization
- `AuthState`: Abstract class for different authentication states
- `AuthFormState`: Manages form input states and validation

### States
- `AuthInitial`: Initial state
- `AuthLoading`: Loading state during authentication
- `AuthSuccess`: Successful authentication with user data
- `AuthError`: Authentication error with message
- `AuthValidationError`: Form validation errors

### Provider
- `AuthProvider`: Manages authentication state and business logic
- Handles login, logout, and form validation
- Integrates with SharedPreferences for persistent storage

## Usage

### Demo Credentials
For testing purposes, use these credentials:
- **Email**: `demo@example.com`
- **Password**: `password123`

### Navigation Flow
1. **Splash Screen** → Checks if user is logged in
2. **Login Screen** → If not logged in
3. **Home Screen** → After successful login
4. **Logout** → Returns to login screen

### Integration

The authentication system is integrated into the main app:

1. **Provider Setup**: Added to main.dart MultiProvider
2. **Router Integration**: Login and Home routes added to GoRouter
3. **Splash Logic**: Updated to redirect based on authentication status

## Customization

### Adding Real API
Replace the mock authentication in `AuthProvider.login()` with actual API calls:

```dart
// Replace this section in auth_provider.dart
try {
  // Make actual API call
  final response = await authService.login(
    email: _formState.email,
    password: _formState.password,
  );
  
  if (response.success) {
    final user = UserModel.fromJson(response.userData);
    await _saveUserAndUpdateState(user);
  } else {
    _authState = AuthError(response.message);
    notifyListeners();
  }
} catch (e) {
  _authState = AuthError('Network error: ${e.toString()}');
  notifyListeners();
}
```

### Adding New Fields
To add new user fields:

1. Update `UserModel` with new properties
2. Update `AuthFormState` if needed
3. Add validation logic in `AuthProvider`
4. Update UI components

### Styling
The login screen uses the app's theme system:
- Colors from `ThemeClass.of(context)`
- Text styles from `TextStyleHelper.of(context)`
- Responsive sizing with `ScreenUtil`

## Dependencies

- `provider`: State management
- `equatable`: Value equality for states
- `shared_preferences`: Local storage
- `go_router`: Navigation
- `flutter_screenutil`: Responsive design

## Testing

The system includes comprehensive state handling:
- Form validation errors
- Network errors
- Loading states
- Success states

Test different scenarios by:
- Entering invalid credentials
- Testing form validation
- Checking loading states
- Verifying navigation flow
