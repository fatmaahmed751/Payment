// To parse this JSON data, do
//
//     final amountModel = amountModelFromJson(jsonString);

import 'dart:convert';

AmountModel amountModelFromJson(String str) => AmountModel.fromJson(json.decode(str));

String amountModelToJson(AmountModel data) => json.encode(data.toJson());

class AmountModel {
  final String? total;
  final String? currency;
  final Details? details;

  AmountModel({
    required this.total,
    required this.currency,
    required this.details,
  });

  factory AmountModel.fromJson(Map<String, dynamic> json) => AmountModel(
    total: json["total"],
    currency: json["currency"],
    details: json["details"] == null ? null : Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "currency": currency,
    "details": details?.toJson(),
  };
}

class Details {
  final String? subtotal;
  final String? shipping;
  final int? shippingDiscount;

  Details({
  required  this.subtotal,
    required this.shipping,
    required this.shippingDiscount,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    subtotal: json["subtotal"],
    shipping: json["shipping"],
    shippingDiscount: json["shipping_discount"],
  );

  Map<String, dynamic> toJson() => {
    "subtotal": subtotal,
    "shipping": shipping,
    "shipping_discount": shippingDiscount,
  };
}
