import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'Modules/Auth/auth_provider.dart';
import 'core/API/request_method.dart';
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
import 'package:clarity_flutter/clarity_flutter.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  //   final client = ApiClient();
  //
  // try {
  //   final dio = Dio();
  //
  //   final response = await dio.get(
  //     "https://newsapi.org/v2/everything",
  //     queryParameters: {
  //       "q": "tesla",
  //       "from": "2025-08-09",
  //       "sortBy": "publishedAt",
  //       "apiKey": "77ef2ede7d4c4255a48ef0c8ce9d93a7", // ✅ ضيفي apiKey هنا صراحة
  //     },
  //   );
  //
  //   print("✅✅✅ نجاح خارق:");
  //   print(response.data);
  //
  //   if (response.data is Map && response.data.containsKey('articles')) {
  //     final articles = response.data['articles'] as List;
  //     print('📰 عدد الأخبار: ${articles.length}');
  //   }
  //
  // } catch (e) {
  //   print("🔥🔥🔥 خطأ مباشر: $e");
  //   if (e is DioException) {
  //     print("📄 Response Body: ${e.response?.data}");
  //     print("🔢 Status Code: ${e.response?.statusCode}");
  //   }
  // }
  //
  //   //   final response = await client.get(
  //   //     "everything",
  //   //     query: {
  //   //       "q": "tesla",
  //   //       "from": "2024-08-09", // ⚠️ تاريخ في المستقبل! غيّره لـ تاريخ سابق
  //   //       "sortBy": "publishedAt",
  //   //       // apiKey هيتضاف تلقائيًا من الـ interceptor
  //   //     },
  //   //   );
  //   //
  //   //   // ✅ طباعة الرد في الكونسول
  //   //   print("✅ Response Data:");
  //   //   print(response.data);
  //   //
  //   //   // لو عاوزة تطبع عدد الأخبار مثلاً
  //   //   if (response.data is Map && response.data.containsKey('articles')) {
  //   //     final articles = response.data['articles'] as List;
  //   //     print('📰 عدد الأخبار: ${articles.length}');
  //   //   }
  //   //
  //   // // } on DioException catch (e) {
  //   // //   print("❌ Error: ${e.message}");
  //   // //   if (e.response != null) {
  //   // //     print("Status Code: ${e.response?.statusCode}");
  //   // //     print("Response Data: ${e.response?.data}");
  //   // //   }
  //   // } catch (e) {
  //   //   print("❌❌ خطأ عام: $e"); // ✅ هتطلعي لك التفاصيل الحقيقية هنا
  //   //   if (e is DioException && e.response != null) {
  //   //     print("📄 Response Body: ${e.response?.data}");
  //   //     print("🔢 Status Code: ${e.response?.statusCode}");
  //   //   }
  //   // }

  final config = ClarityConfig(
    projectId: "stuj6bv89f", // من لوحة Clarity
    logLevel: LogLevel.Verbose, // استعماله التدريجي؛ في البيئة الحية يستخدم None
  );
  Stripe.publishableKey = ApiKeys.paymentPublishedKey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
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
          ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ],
        child:  ClarityWidget(
          app: const EntryPoint(),
          clarityConfig: config,
        )));
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