import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Payment/Modules/Splash/splash_data_handler.dart';
import '../../Utilities/shared_preferences.dart';
import '../Cart/my_cart_screen.dart';

class SplashController extends ControllerMVC {
  // singleton
  factory SplashController() {
    _this ??= SplashController._();
    return _this!;
  }
  static SplashController? _this;
  SplashController._();



  Future init(BuildContext context)async{
    await SplashDataHandler.getCurrentUser();
    // await Future.delayed(const Duration(seconds: 2));
    // if(context.mounted) {
    //   GoRouter.of(context).go(MyCartScreen.routeName);
      if(SharedPref.isLogin()){
      GoRouter.of(context).goNamed(MyCartScreen.routeName);
      }else{
       GoRouter.of(context).goNamed(MyCartScreen.routeName);
      }
    }
  }

