// payment_client.dart

import 'package:dio/dio.dart';
import '../../Utilities/api_keys.dart';

// payment_api_client.dart

import 'package:dio/dio.dart';
import '../../core/API/request_method.dart';
 // مهم: استورد الكلاس الأم


class PaymentApiClient {
  static final PaymentApiClient _instance = PaymentApiClient._internal();
  factory PaymentApiClient() => _instance;
  late Dio dio;
  PaymentApiClient._internal() {
    //dio = Dio();
dio.options.baseUrl = "https://api.stripe.com/v1";
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.headers.addAll({
      'Authorization': 'Bearer ${ApiKeys.paymentApiSecretKey}',
      'Stripe-Version': '2025-06-30.basil',
      'Content-Type': 'application/x-www-form-urlencoded',
    });
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) {
    return dio.post(
      path,
     data: data,
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );
  }

  Future<Response> postWithKey(String path, {Map<String, dynamic>? data, required String secretKey}) {
    return dio.post(
      path,
      data:data,
      options: Options(
        contentType: 'application/x-www-form-urlencoded',
        headers: {'Authorization': 'Bearer $secretKey'},
      ),
    );
  }
}