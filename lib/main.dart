import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'Utilities/api_keys.dart';
import 'Utilities/git_it.dart';
import 'Utilities/router_config.dart';
import 'core/Font/font_provider.dart';
import 'core/Language/app_languages.dart';
import 'core/Language/locales.dart';
import 'core/Theme/theme_provider.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = ApiKeys.paymentPublishedKey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await GitIt.initGitIt();
  HttpOverrides.global = MyHttpOverrides();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AppLanguage>(create: (_) => AppLanguage()),
          ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
          ChangeNotifierProvider<FontProvider>(create: (_) => FontProvider()),
        ],
        child: const EntryPoint(),
      )
  );
}


class EntryPoint extends StatelessWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLan = Provider.of<AppLanguage>(context);
    final appTheme = Provider.of<ThemeProvider>(context);
    appLan.fetchLocale(context);
    appTheme.fetchTheme();
    return ScreenUtilInit(
      designSize: const Size(393,852),
      builder:(_,__)=> MaterialApp.router(
        scrollBehavior: MyCustomScrollBehavior(),
        routerConfig: GoRouterConfig.router,
        debugShowCheckedModeBanner: false,
        title: 'Payment',
        locale: Locale(appLan.appLang.name),
        theme: appTheme.appThemeMode,
        supportedLocales: Languages.values.map((e) => Locale(e.name)).toList(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultMaterialLocalizations.delegate
        ],
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
// paymentintent object<=create payment intent (amount/currency/customerId) required
//keySecret createEphemeralKey(stripe version/customerId)
//init paymentSheet(merchant display name,intent client secret,EphemeralKeySecret)
//presentPaymentSheet
//cus_ShPPxjuZGB5viQ
// git rm --cached lib/Utilities/api_keys.dart