import 'dart:convert';

import 'package:Payment/Models/payment_intent_input_model.dart';
import 'package:Payment/Modules/Payment/payment_client.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../Models/ephemral_key_model.dart';
import '../../Models/payment_intent_model.dart';
import '../../Utilities/api_end_point.dart';
import '../../Utilities/api_keys.dart';
import '../../core/API/generic_request.dart';
import '../../core/API/request_method.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';

import '../../core/network/error_message_model.dart';



class PaymentDataHandler {

  static Future<Either<Failure, PaymentIntentModel>> createPaymentIntent({
    required String amount,
    required String currency,
    required String customerId,
    required String secretKey,
  }) async {
    try {
      final paymentClient = PaymentApiClient();
      final response = await paymentClient.postWithKey(
        "/payment_intents",
        data: {
          "amount": amount,
          "currency": currency,
          "customer": customerId,
        },
        secretKey: secretKey,
      );

      final result = PaymentIntentModel.fromJson(response.data);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel));
    } catch (e) {
      return Left(ServerFailure(ErrorMessageModel.local(statusMessage: e.toString())));
    }
  }
  // static Future<Either<Failure, PaymentIntentModel>> createPaymentIntent({
  //   required String amount,
  //   required String currency,
  //   required String customerId,
  //   required String secretKey,
  // }) async {
  //   try {
  //     // أخذ نسخة من العميل العام
  //     final apiClient = ApiClient();
  //
  //     // حفظ الإعدادات القديمة (اختياري - لو حابب ترجع لها)
  //     final originalBaseUrl = apiClient.dio.options.baseUrl;
  //     final originalHeaders = Map.of(apiClient.dio.options.headers);
  //
  //     try {
  //       // تعديل المؤقت لـ Stripe
  //       apiClient.dio.options.baseUrl = "https://api.stripe.com/v1";
  //       apiClient.dio.options.headers.addAll({
  //         'Authorization': 'Bearer $secretKey',
  //         'Stripe-Version': '2025-06-30.basil',
  //         'Content-Type': 'application/x-www-form-urlencoded',
  //       });
  //
  //       final request = GenericRequest<PaymentIntentModel>(
  //         fromMap: PaymentIntentModel.fromJson,
  //         client: apiClient, // ✅ من نوع ApiClient
  //         path: "/payment_intents",
  //         method: RequestMethod.POST,
  //         body: {
  //           "amount": amount,
  //           "currency": currency,
  //           "customer": customerId,
  //         },
  //         useFormUrlEncoded: true,
  //       );
  //
  //       final result = await request.getObject();
  //       return Right(result);
  //     } finally {
  //       // إعادة الإعدادات القديمة (مهم لو في طلبات عادية بعدين)
  //       apiClient.dio.options.baseUrl = originalBaseUrl;
  //       apiClient.dio.options.headers.clear();
  //       apiClient.dio.options.headers.addAll(originalHeaders);
  //     }
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.errorMessageModel));
  //   } catch (e) {
  //     return Left(ServerFailure(
  //       ErrorMessageModel.local(statusMessage: e.toString()),
  //     ));
  //   }
  // }
  static Future<Either<Failure, EphemeralKeyModel>> createEphemeralKey({
    required String customerId,
    required String secretKey, // نمرره من برة (يفضل من backend، لكن للتجربة نستخدمه هنا)
  }) async {
    try {
      final paymentClient = PaymentApiClient();

      final response = await paymentClient.postWithKey(
        "/ephemeral_keys",
       data: {
          "customer": customerId,
        //  "expand[]": "customer", // اختياري: لو عايز تجيب بيانات العميل كمان
        },
        secretKey: secretKey,
      );

      final ephemeralKey = EphemeralKeyModel.fromJson(response.data);
      return Right(ephemeralKey);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel));
    } catch (e) {
      return Left(ServerFailure(
        ErrorMessageModel.local(statusMessage: "Error creating ephemeral key: $e"),
      ));
    }
  }
  /// إنشاء Ephemeral Key
  // static Future<Either<Failure, EphemeralKeyModel>> createEphemeralKey({
  //   required String customerId,
  // }) async {
  //   try {
  //     final apiClient = ApiClient();
  //     final originalBaseUrl = apiClient.dio.options.baseUrl;
  //     final originalHeaders = Map.of(apiClient.dio.options.headers);
  //
  //     try {
  //       apiClient.dio.options.baseUrl = "https://api.stripe.com/v1";
  //       apiClient.dio.options.headers.addAll({
  //         'Authorization': 'Bearer ${ApiKeys.paymentApiSecretKey}',
  //         'Stripe-Version': '2025-06-30.basil',
  //         'Content-Type': 'application/x-www-form-urlencoded',
  //       });
  //
  //       final request = GenericRequest<EphemeralKeyModel>(
  //         fromMap: EphemeralKeyModel.fromJson,
  //         client: apiClient,
  //         path: "/ephemeral_keys",
  //         method: RequestMethod.POST,
  //         body: {
  //           "customer": customerId,
  //         },
  //         useFormUrlEncoded: true,
  //       );
  //
  //       final result = await request.getObject();
  //       return Right(result);
  //     } finally {
  //       // إعادة الإعدادات
  //       apiClient.dio.options.baseUrl = originalBaseUrl;
  //       apiClient.dio.options.headers.clear();
  //       apiClient.dio.options.headers.addAll(originalHeaders);
  //     }
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.errorMessageModel));
  //   } catch (e) {
  //     return Left(ServerFailure(
  //       ErrorMessageModel.local(statusMessage: e.toString()),
  //     ));
  //   }
  // }
}
// class PaymentDataHandler {
//   // 1. إنشاء Payment Intent مع تمرير secretKey
//   static Future<Either<Failure, PaymentIntentModel>> createPaymentIntent({
//     required String amount,
//     required String currency,
//     required String customerId,
//     required String secretKey,
//   }) async {
//     try {
//       // غير الهيدر المؤقت
//       final paymentClient = PaymentApiClient();
//       paymentClient.dio.options.headers['Authorization'] = 'Bearer $secretKey';
//
//       final request = GenericRequest<PaymentIntentModel>(
//         fromMap: PaymentIntentModel.fromJson,
//         client: paymentClient, // ✅ هنا: client من نوع PaymentApiClient
//         path: "/payment_intents",
//         method: RequestMethod.POST,
//         body: {
//           "amount": amount,
//           "currency": currency,
//           "customer": customerId,
//         },
//         useFormUrlEncoded: true,
//       );
//
//       final result = await request.getObject();
//       return Right(result);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.errorMessageModel));
//     } catch (e) {
//       return Left(ServerFailure(ErrorMessageModel.local(statusMessage: e.toString())));
//     }
//   }
//
//   // 2. إنشاء Ephemeral Key
//   static Future<Either<Failure, EphemeralKeyModel>> createEphemeralKey({
//     required String customerId,
//   }) async {
//     try {
//       final paymentClient = PaymentApiClient(); // يستخدم ApiKeys.paymentApiSecretKey
//
//       final request = GenericRequest<EphemeralKeyModel>(
//         fromMap: EphemeralKeyModel.fromJson,
//         client: paymentClient, // ✅ من نوع PaymentApiClient
//         path: "/ephemeral_keys",
//         method: RequestMethod.POST,
//         body: {
//           "customer": customerId,
//         },
//         useFormUrlEncoded: true,
//       );
//
//       final result = await request.getObject();
//       return Right(result);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.errorMessageModel));
//     } catch (e) {
//       return Left(ServerFailure(ErrorMessageModel.local(statusMessage: e.toString())));
//     }
//   }
// }
// class PaymentDataHandler {
//   // 1. إنشاء Payment Intent
//   static Future<Either<Failure, PaymentIntentModel>> createPaymentIntent({
//     required String amount,
//     required String currency,
//     required String customerId,
//     required String secretKey,
//   }) async {
//     try {
//       final paymentClient = PaymentApiClient();
//       paymentClient.dio.options.headers['Authorization'] = 'Bearer $secretKey';
//       final request = GenericRequest<PaymentIntentModel>(
//         fromMap: PaymentIntentModel.fromJson,
//         client: paymentClient, // استخدم الـ Dio من PaymentClient
//         path: "/payment_intents",
//         method: RequestMethod.POST,
//         body: {
//           "amount": amount,
//           "currency": currency,
//           "customer": customerId,
//         },
//         useFormUrlEncoded: true, // مهم لـ Stripe
//       );
//
//       final result = await request.getObject();
//       return Right(result);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.errorMessageModel));
//     } catch (e) {
//       return Left(ServerFailure(ErrorMessageModel.local(statusMessage: e.toString())));
//     }
//   }
//
//   // 2. إنشاء Ephemeral Key
//   static Future<Either<Failure, EphemeralKeyModel>> createEphemeralKey({
//     required String customerId,
//   }) async {
//     try {
//       final paymentClient = PaymentApiClient();
//       final request = GenericRequest<EphemeralKeyModel>(
//         fromMap: EphemeralKeyModel.fromJson,
//         client: paymentClient,
//         path: "/ephemeral_keys",
//         method: RequestMethod.POST,
//         body: {
//           "customer": customerId,
//         },
//         useFormUrlEncoded: true,
//       );
//
//       final result = await request.getObject();
//       return Right(result);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.errorMessageModel));
//     } catch (e) {
//       return Left(ServerFailure(ErrorMessageModel.local(statusMessage: e.toString())));
//     }
//   }
// }
// class PaymentDataHandler {
//   static Future<Either<Failure, PaymentIntentModel>> payment({
//     required String amount,
//     required String currency,
//     required String secretKey,
//     required String customerId
//   }) async {
//     try {
//       PaymentIntentModel response = await GenericRequest<PaymentIntentModel>(
//         method: RequestApi.post(
//           url: "https://api.stripe.com/v1/payment_intents",
//           body: {
//             "amount": amount,
//             "customer": customerId,
//             "currency": currency,
//           },
//           headers: {
//             "Authorization": "Bearer $secretKey",
//             "Content-Type": "application/x-www-form-urlencoded",
//           },
//         ),
//         fromMap: PaymentIntentModel.fromJson,
//       ).getObject(asFormUrlEncoded: true);
//       return Right(response);
//     } on ServerException catch (failure) {
//       return Left(ServerFailure(failure.errorMessageModel));
//     }
//   }
//   static Future<Either<Failure, EphemeralKeyModel>> createEphemeralKey({
//     required String customerId,
//   }) async {
//     try {
//       EphemeralKeyModel response = await GenericRequest<EphemeralKeyModel>(
//         method: RequestApi.post(
//           url: "https://api.stripe.com/v1/ephemeral_keys",
//           body: {
//             "customer": customerId,
//           },
//           headers: {
//             "Authorization": "Bearer ${ApiKeys.paymentApiSecretKey}",
//             "Content-Type": "application/x-www-form-urlencoded",
//             "Stripe-Version":"2025-06-30.basil"
//           },
//         ),
//         fromMap: EphemeralKeyModel.fromJson,
//       ).getObject(asFormUrlEncoded: true);
//       return Right(response);
//     } on ServerException catch (failure) {
//       return Left(ServerFailure(failure.errorMessageModel));
//     }
//   }
// }


