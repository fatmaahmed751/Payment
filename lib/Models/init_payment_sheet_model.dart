class InitPaymentSheetModel{

  final String clientSecret;
  final String customerId;
  final String ephemeralKeySecret;

  InitPaymentSheetModel({
      required  this.clientSecret,
    required  this.customerId,
    required this.ephemeralKeySecret
      });
}