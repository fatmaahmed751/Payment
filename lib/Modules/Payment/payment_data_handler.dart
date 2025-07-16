import 'dart:convert';

import 'package:Payment/Models/payment_intent_input_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../Models/payment_intent_model.dart';
import '../../Utilities/api_end_point.dart';
import '../../core/API/generic_request.dart';
import '../../core/API/request_method.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../core/network/error_message_model.dart';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/API/request_method.dart';
import '../../Models/payment_intent_model.dart';

class PaymentDataHandler {
  static Future<Either<Failure, PaymentIntentModel>> payment({
    required String amount,
    required String currency,
    required String secretKey,
  }) async {
    final url = Uri.parse("https://api.stripe.com/v1/payment_intents");

    // نجهز requestApi يدويًا علشان نمرره في حالة الخطأ
    final requestApi = RequestApi.post(
      url: url.toString(),
      body: {
        "amount": amount,
        "currency": currency,
      },
      headers: {
        "Authorization": "Bearer $secretKey",
        "Content-Type": "application/x-www-form-urlencoded",
      },
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': amount,
          'currency': currency,
        },
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return Right(PaymentIntentModel.fromJson(jsonBody));
      } else {
        final jsonBody = json.decode(response.body);
        return Left(ServerFailure(
          ErrorMessageModel(
            statusCode: response.statusCode,
            statusMessage: jsonBody['error']?['message'] ?? "Bad Request",
            requestApi: requestApi,
            responseApi: jsonBody,
          ),
        ));
      }
    } catch (e) {
      return Left(ServerFailure(
        ErrorMessageModel(
          statusCode: 500,
          statusMessage: e.toString(),
          requestApi: requestApi,
        ),
      ));
    }
  }
}

// class PaymentDataHandler {
//   static Future<Either<Failure, PaymentIntentModel>> payment({
//     required String amount,
//     required String currency,
//     required String secretKey,
//   }) async {
//     try {
//       final url = Uri.parse("https://api.stripe.com/v1/payment_intents");
//
//       final response = await http.post(
//         url,
//         headers: {
//           'Authorization': 'Bearer $secretKey',
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: {
//           'amount': amount,
//           'currency': currency,
//         },
//       );
//       if (response.statusCode == 200) {
//         final jsonBody = json.decode(response.body);
//         return Right(PaymentIntentModel.fromJson(jsonBody));
//       }
//       else {
//          final jsonBody = json.decode(response.body);
//          return left((ServerFailure(
//            ErrorMessageModel(
//              statusCode: response.statusCode,
//              statusMessage: jsonBody['error']?['message'] ?? "Bad Request", requestApi:,
//            )) ));
//         // return Left(ServerFailure(failure.errorMessageModel));
//         //
//         }
//       }on ServerException catch (failure) {
//       return Left(ServerFailure((failure.errorMessageModel)));
//
//     }
//   }
// }

// class PaymentDataHandler {
//   static Future<PaymentIntentModel?> payment({
//     required String amount,
//     required String currency,
//     required String secretKey,
//   }) async {
//     final url = Uri.parse("https://api.stripe.com/v1/payment_intents");
//
//     final response = await http.post(
//       url,
//       headers: {
//         'Authorization': 'Bearer $secretKey',
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//       body: {
//         'amount': amount,
//         'currency': currency,
//       },
//     );
//
//     if (response.statusCode == 200) {
//       return PaymentIntentModel.fromJson(json.decode(response.body));
//     } else {
//       print(json.decode(response.body));
//       return null;
//     }
//   }
// }
//     {
//       required String amount,
//       required String currency ,
//       required String stripeSecretKey,
//     }) async {
//   try {
//     PaymentIntentModel response =
//         await GenericRequest<PaymentIntentModel>(
//             method: RequestApi.post(
//               url: "https://api.stripe.com/v1/payment_intents",
//               body: {
//                 "amount": amount,
//                 "currency": currency,
//               },
//               headers: {
//                 "Authorization": "Bearer $stripeSecretKey", // Stripe secret key
//                 "Content-Type":
//                     "application/x-www-form-urlencoded", // أو application/json لو محتاج
//               },
//             ),
//             fromMap: PaymentIntentModel.fromJson
//         ).getObject();
//     return Right(response);
//   } on ServerException catch (failure) {
//     return Left(ServerFailure(failure.errorMessageModel));
//   }
// }
