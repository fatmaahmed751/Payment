import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../Widgets/custom_button_widget.dart';
import '../../Widgets/custom_text.dart';
import '../../Utilities/theme_helper.dart';
import '../../Utilities/text_style_helper.dart';
import '../../Models/user_model.dart';
import 'auth_provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Welcome',
          // style: TextStyleHelper.of(context).h_20.copyWith(
          //   color: Colors.white,
          // ),
        ),
        backgroundColor: ThemeClass.of(context).primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: BackGroundClass.backgroundGradiant,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // User Info Card
                _buildUserInfoCard(context),
                
                SizedBox(height: 32.h),
                
                // Welcome Message
                _buildWelcomeMessage(context),
                
                SizedBox(height: 32.h),
                
                // Action Buttons
                _buildActionButtons(context),
                
                const Spacer(),
                
                // Logout Button
                _buildLogoutButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoCard(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final user = authProvider.currentUser;
        if (user == null) return const SizedBox.shrink();
        
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
            children: [
              // Avatar
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: ThemeClass.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40.r),
                ),
                child: Icon(
                  Icons.person,
                  size: 40.w,
                  color: ThemeClass.of(context).primaryColor,
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // User Name
              CustomText(
                text: user.name ?? 'User',
              //   style: TextStyleHelper.of(context).h_20.copyWith(
              //   color: ThemeClass.of(context).mainBlack,
              // ),
              ),
              
              SizedBox(height: 8.h),
              
              // User Email
              CustomText(
                text: user.email ?? '',
                // style: TextStyleHelper.of(context).b_16.copyWith(
                //   color: ThemeClass.of(context).secondaryBlackColor,
                // ),
              ),
              
              if (user.phone != null) ...[
                SizedBox(height: 8.h),
                CustomText(
                  text: user.phone!,
                  // style: TextStyleHelper.of(context).b_14.copyWith(
                  //   color: ThemeClass.of(context).secondaryBlackColor,
                  // ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildWelcomeMessage(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.check_circle,
            size: 48.w,
            color: ThemeClass.of(context).success,
          ),
          
          SizedBox(height: 16.h),
          
          CustomText(
            text: 'Login Successful!',
            // style: TextStyleHelper.of(context).h_18.copyWith(
            //   color: ThemeClass.of(context).success,
            // ),
          ),
          
          SizedBox(height: 8.h),
          
          CustomText(
            text: 'You are now logged into your account',
            // style: TextStyleHelper.of(context).b_16.copyWith(
            //   color: ThemeClass.of(context).secondaryBlackColor,
            //   textAlign: TextAlign.center,
            // ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        CustomButtonWidget.primary(
          onTap: () {
            // Navigate to payment screen
            context.go('/payment');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.payment,
                color: Colors.white,
                size: 20.w,
              ),
              SizedBox(width: 12.w),
              CustomText(
                text: 'Go to Payment',
                // style: TextStyleHelper.of(context).h_16.copyWith(
                //   color: Colors.white,
                // ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: 16.h),
        
        CustomButtonWidget.secondary(
          onTap: () {
            // Navigate to clarity test screen
            context.go('/clarity-test');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.analytics,
                color: ThemeClass.of(context).mainSecondary,
                size: 20.w,
              ),
              SizedBox(width: 12.w),
              CustomText(
                text: 'Analytics Test',
                // style: TextStyleHelper.of(context).h_16.copyWith(
                //   color: ThemeClass.of(context).mainSecondary,
                // ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return CustomButtonWidget.outline(
      onTap: () => _showLogoutDialog(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.logout,
            color: ThemeClass.of(context).secondaryBlackColor,
            size: 20.w,
          ),
          SizedBox(width: 12.w),
          CustomText(
            text: 'Logout',
            // style: TextStyleHelper.of(context).h_16.copyWith(
            //   color: ThemeClass.of(context).secondaryBlackColor,
            // ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: CustomText(
            text: 'Logout',
            // style: TextStyleHelper.of(context).h_18.copyWith(
            //   color: ThemeClass.of(context).mainBlack,
            // ),
          ),
          content: CustomText(
            text: 'Are you sure you want to logout?',
            // style: TextStyleHelper.of(context).b_16.copyWith(
            //   color: ThemeClass.of(context).secondaryBlackColor,
            // ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: CustomText(
                text: 'Cancel',
                // style: TextStyleHelper.of(context).b_16.copyWith(
                //   color: ThemeClass.of(context).secondaryBlackColor,
                // ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleLogout(context);
              },
              child: CustomText(
                text: 'Logout',
                // style: TextStyleHelper.of(context).h_16.copyWith(
                //   color: ThemeClass.of(context).cancel,
                // ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleLogout(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    authProvider.logout();
    
    // Navigate back to login screen
    context.go('/login');
  }
}
