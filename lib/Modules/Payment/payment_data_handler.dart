import 'dart:convert';

import 'package:Payment/Models/payment_intent_input_model.dart';
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
    required String customerId
  }) async {
    try {
      PaymentIntentModel response = await GenericRequest<PaymentIntentModel>(
        method: RequestApi.post(
          url: "https://api.stripe.com/v1/payment_intents",
          body: {
            "amount": amount,
            "customer": customerId,
            "currency": currency,
          },
          headers: {
            "Authorization": "Bearer $secretKey",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
        fromMap: PaymentIntentModel.fromJson,
      ).getObject(asFormUrlEncoded: true);
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
  static Future<Either<Failure, EphemeralKeyModel>> createEphemeralKey({
    required String customerId,
  }) async {
    try {
      EphemeralKeyModel response = await GenericRequest<EphemeralKeyModel>(
        method: RequestApi.post(
          url: "https://api.stripe.com/v1/ephemeral_keys",
          body: {
            "customer": customerId,
          },
          headers: {
            "Authorization": "Bearer ${ApiKeys.paymentApiSecretKey}",
            "Content-Type": "application/x-www-form-urlencoded",
            "Stripe-Version":"2025-06-30.basil"
          },
        ),
        fromMap: EphemeralKeyModel.fromJson,
      ).getObject(asFormUrlEncoded: true);
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}


