// To parse this JSON data, do
//
//     final itemsListModel = itemsListModelFromJson(jsonString);

import 'dart:convert';

ItemsListModel itemsListModelFromJson(String str) => ItemsListModel.fromJson(json.decode(str));

String itemsListModelToJson(ItemsListModel data) => json.encode(data.toJson());

class ItemsListModel {
  final List<OrderOfItem>? items;

  ItemsListModel({
    this.items,
  });

  factory ItemsListModel.fromJson(Map<String, dynamic> json) => ItemsListModel(
    items: json["items"] == null ? [] : List<OrderOfItem>.from(json["items"]!.map((x) => OrderOfItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class OrderOfItem {
  final String? name;
  final int? quantity;
  final String? price;
  final String? currency;

  OrderOfItem({
    this.name,
       this.quantity,
     this.price,
     this.currency,
  });

  factory OrderOfItem.fromJson(Map<String, dynamic> json) => OrderOfItem(
    name: json["name"],
    quantity: json["quantity"],
    price: json["price"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "quantity": quantity,
    "price": price,
    "currency": currency,
  };
}
