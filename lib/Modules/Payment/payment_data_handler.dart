import 'package:Payment/Models/payment_intent_input_model.dart';
import 'package:dartz/dartz.dart';

import '../../Models/payment_intent_model.dart';
import '../../Utilities/api_end_point.dart';
import '../../core/API/generic_request.dart';
import '../../core/API/request_method.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';

class PaymentDataHandler {
  static Future<Either<Failure, PaymentIntentModel>> payment(
      {
        required String amount,
        required String currency ,
        required String stripeSecretKey,
      }) async {
    try {
      PaymentIntentModel response =
          await GenericRequest<PaymentIntentModel>(
              method: RequestApi.post(
                url: "https://api.stripe.com/v1/payment_intents",
                body: {
                  "amount": amount,
                  "currency": currency,
                },
                headers: {
                  "Authorization": "Bearer $stripeSecretKey", // Stripe secret key
                  "Content-Type":
                      "application/x-www-form-urlencoded", // أو application/json لو محتاج
                },
              ),
              fromMap: PaymentIntentModel.fromJson
          ).getObject();
      return Right(response);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}
