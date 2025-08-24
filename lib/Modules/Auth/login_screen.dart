import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../Widgets/custom_button_widget.dart';
import '../../Widgets/custom_textfield_widget.dart';
import '../../Widgets/custom_text.dart';
import '../../Utilities/theme_helper.dart';
import '../../Utilities/text_style_helper.dart';
import '../../generated/assets.dart';
import 'auth_provider.dart';
import 'auth_model.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    
    // Listen to auth state changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();
      authProvider.addListener(_onAuthStateChanged);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    
    // Remove auth listener
    try {
      final authProvider = context.read<AuthProvider>();
      authProvider.removeListener(_onAuthStateChanged);
    } catch (e) {
      // Context might not be available during dispose
    }
    
    super.dispose();
  }

  void _onEmailChanged() {
    final authProvider = context.read<AuthProvider>();
    authProvider.updateEmail(_emailController.text);
  }

  void _onPasswordChanged() {
    final authProvider = context.read<AuthProvider>();
    authProvider.updatePassword(_passwordController.text);
  }

  void _handleLogin() {
    final authProvider = context.read<AuthProvider>();
    authProvider.login();
  }

  void _onAuthStateChanged() {
    final authProvider = context.read<AuthProvider>();
    if (authProvider.authState is AuthSuccess) {
      context.go('/home');
    }
  }

  void _handleForgotPassword() {
    // Navigate to forgot password screen
    // context.go('/forgot-password');
  }

  void _handleSignUp() {
    // Navigate to sign up screen
    // context.go('/signup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: BackGroundClass.backgroundGradiant,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40.h),
                
                // Logo and Title
                _buildHeader(),
                
                SizedBox(height: 40.h),
                
                // Login Form
                _buildLoginForm(),
                
                SizedBox(height: 24.h),
                
                // Forgot Password
                _buildForgotPassword(),
                
                SizedBox(height: 32.h),
                
                // Sign Up Link
                _buildSignUpLink(),
                
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Logo
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(60.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.payment,
              size: 60.w,
              color: ThemeClass.of(context).primaryColor,
            ),
          ),
        ),
        
        SizedBox(height: 24.h),
        
        // Title
        CustomText(
          text: 'Welcome Back',
          // style: TextStyleHelper.of(context).h_24.copyWith(
          //   color: ThemeClass.of(context).mainBlack,
          // ),
        ),
        
        SizedBox(height: 8.h),
        
        // Subtitle
        CustomText(
          text: 'Sign in to continue to your account',
          // style: TextStyleHelper.of(context).b_16.copyWith(
          //   color: ThemeClass.of(context).secondaryBlackColor,
          // ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final formState = authProvider.formState;
        final authState = authProvider.authState;
        
        return Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Email Field
              CustomTextFieldWidget(
                controller: _emailController,
                hint: 'Email Address',
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: ThemeClass.of(context).secondaryBlackColor,
                  size: 20.w,
                ),
                focusedBorderColor: formState.isEmailValid 
                    ? ThemeClass.of(context).primaryColor
                    : ThemeClass.of(context).cancel,
                borderColor: formState.isEmailValid 
                    ? ThemeClass.of(context).secondary
                    : ThemeClass.of(context).cancel,
                validator: (value) {
                  if (authState is AuthValidationError) {
                    final errors = (authState).errors;
                    return errors['email']?.isNotEmpty == true ? errors['email'] : null;
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 20.h),
              
              // Password Field
              CustomTextFieldWidget(
                controller: _passwordController,
                hint: 'Password',
                obscure: !formState.isPasswordVisible,
                textInputType: TextInputType.visiblePassword,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: ThemeClass.of(context).secondaryBlackColor,
                  size: 20.w,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    formState.isPasswordVisible 
                        ? Icons.visibility_off 
                        : Icons.visibility,
                    color: ThemeClass.of(context).secondaryBlackColor,
                  ),
                  onPressed: () => authProvider.togglePasswordVisibility(),
                ),
                focusedBorderColor: formState.isPasswordValid 
                    ? ThemeClass.of(context).primaryColor
                    : ThemeClass.of(context).cancel,
                borderColor: formState.isPasswordValid 
                    ? ThemeClass.of(context).secondary
                    : ThemeClass.of(context).cancel,
                validator: (value) {
                  if (authState is AuthValidationError) {
                    final errors = (authState).errors;
                    return errors['password']?.isNotEmpty == true ? errors['password'] : null;
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 24.h),
              
              // Login Button
              _buildLoginButton(authProvider, authState),
              
              // Error Messages
              if (authState is AuthError) ...[
                SizedBox(height: 16.h),
                _buildErrorMessage(authState.message),
              ],
              
              // Demo Credentials Helper
              SizedBox(height: 16.h),
              _buildDemoCredentialsHelper(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoginButton(AuthProvider authProvider, AuthState authState) {
    final isLoading = authState is AuthLoading;
    final isFormValid = authProvider.formState.isFormValid;
    
    return CustomButtonWidget.primary(
      onTap: isLoading || !isFormValid ? null : _handleLogin,
      child: isLoading
          ? SizedBox(
              width: 24.w,
              height: 24.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            )
          : Text(
              'Sign In',
              style: TextStyleHelper.of(context).h_18.copyWith(
                color: Colors.white,
              ),
            ),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ThemeClass.of(context).cancel.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ThemeClass.of(context).cancel.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: ThemeClass.of(context).cancel,
            size: 20.w,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: CustomText(
              text: message,
              // style: TextStyleHelper.of(context).b_14.copyWith(
              //   color: ThemeClass.of(context).cancel,
              // ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Center(
      child: TextButton(
        onPressed: _handleForgotPassword,
        child: CustomText(
          text: 'Forgot Password?',
          // style: TextStyleHelper.of(context).b_16.copyWith(
          //   color: ThemeClass.of(context).primaryColor,
          //   decoration: TextDecoration.underline,
          // ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: "Don't have an account? ",
          // style: TextStyleHelper.of(context).b_16.copyWith(
          //   color: ThemeClass.of(context).secondaryBlackColor,
          // ),
        ),
        TextButton(
          onPressed: _handleSignUp,
          child: CustomText(
            text: 'Sign Up',
            // style: TextStyleHelper.of(context).h_16.copyWith(
            //   color: ThemeClass.of(context).primaryColor,
            //   decoration: TextDecoration.underline,
            // ),
          ),
        ),
      ],
    );
  }

  Widget _buildDemoCredentialsHelper() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Demo Credentials',
            // style: TextStyleHelper.of(context).h_16.copyWith(
            //   color: Colors.white,
            // ),
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: 'Email: demo@example.com',
            // style: TextStyleHelper.of(context).b_14.copyWith(
            //   color: Colors.white.withOpacity(0.8),
            // ),
          ),
          CustomText(
            text: 'Password: password123',
            // style: TextStyleHelper.of(context).b_14.copyWith(
            //   color: Colors.white.withOpacity(0.8),
            // ),
          ),
        ],
      ),
    );
  }
}
