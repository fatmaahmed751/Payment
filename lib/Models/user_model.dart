
import 'dart:convert';
import 'dart:io';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);


class UserModel {
  final int? id;
  final String? name;
  final String? address;
  final String? phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? verified;
  final String? email;
  final String? profileImage;
  final String? firebaseToken;
  final int? cityId;
  final String? token;
  final City? cityInfo;
  final String? profileImagePath;
  final City? city;

  UserModel({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.verified,
    this.email,
    this.profileImage,
    this.firebaseToken,
    this.cityId,
    this.token,
    this.cityInfo,
    this.profileImagePath,
    this.city,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? address,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? verified,
    String? email,
    String? profileImage,
    String? firebaseToken,
    int? cityId,
    String? token,
    City? cityInfo,
    String? profileImagePath,
    City? city,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        verified: verified ?? this.verified,
        email: email ?? this.email,
        profileImage: profileImage ?? this.profileImage,
        firebaseToken: firebaseToken ?? this.firebaseToken,
        cityId: cityId ?? this.cityId,
        token: token ?? this.token,
        cityInfo: cityInfo ?? this.cityInfo,
        profileImagePath: profileImagePath ?? this.profileImagePath,
        city: city ?? this.city,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    phone: json["phone"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    verified: json["verified"],
    email: json["email"],
    profileImage: json["profile_image"],
    firebaseToken: json["firebase_token"],
    cityId: json["city_id"],
    token: json["token"],
    cityInfo: json["city_info"] == null ? null : City.fromJson(json["city_info"]),
    profileImagePath: json["profile_image_path"],
    city: json["city"] == null ? null : City.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "phone": phone,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "verified": verified,
    "email": email,
    "profile_image": profileImage,
    "firebase_token": firebaseToken,
    "city_id": cityId,
    "token": token,
    "city_info": cityInfo?.toJson(),
    "profile_image_path": profileImagePath,
    "city": city?.toJson(),
  };
}

class City {
  final int? id;
  final int? shippingFees;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final List<Translation>? translations;

  City({
    this.id,
    this.shippingFees,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.translations,
  });

  City copyWith({
    int? id,
    int? shippingFees,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    List<Translation>? translations,
  }) =>
      City(
        id: id ?? this.id,
        shippingFees: shippingFees ?? this.shippingFees,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
        translations: translations ?? this.translations,
      );

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    shippingFees: json["shipping_fees"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    name: json["name"],
    translations: json["translations"] == null ? [] : List<Translation>.from(json["translations"]!.map((x) => Translation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shipping_fees": shippingFees,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "name": name,
    "translations": translations == null ? [] : List<dynamic>.from(translations!.map((x) => x.toJson())),
  };
}

class Translation {
  final int? id;
  final int? cityId;
  final String? name;
  final String? locale;

  Translation({
    this.id,
    this.cityId,
    this.name,
    this.locale,
  });

  Translation copyWith({
    int? id,
    int? cityId,
    String? name,
    String? locale,
  }) =>
      Translation(
        id: id ?? this.id,
        cityId: cityId ?? this.cityId,
        name: name ?? this.name,
        locale: locale ?? this.locale,
      );

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    id: json["id"],
    cityId: json["city_id"],
    name: json["name"],
    locale: json["locale"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city_id": cityId,
    "name": name,
    "locale": locale,
  };
}

// class UserModel {
//   final int? id;
//   final String? name;
//   final String? address;
//   final String? phone;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? verified;
//   final String? email;
//   final dynamic profileImage;
//   final dynamic firebaseToken;
//   final String? token;
//   final dynamic profileImagePath;
//   dynamic cityId;
//   String? cityName;
//
//   UserModel({
//     this.id,
//     this.name,
//     this.address,
//     this.phone,
//     this.createdAt,
//     this.updatedAt,
//     this.verified,
//     this.email,
//     this.profileImage,
//     this.firebaseToken,
//     this.token,
//     this.profileImagePath,
//     this.cityId,
//     this.cityName,
//   });
//   UserModel copyWith({
//     String? name,
//     String? address,
//     String? phone,
//     DateTime? updatedAt,
//     dynamic profileImage,
//     dynamic profileImagePath,
//     dynamic cityId,
//     dynamic cityName,
//   }) {
//     return UserModel(
//         id: id,
//         name: name ?? this.name,
//         address: address ?? this.address,
//         phone: phone ?? this.phone,
//         createdAt: createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         verified: verified,
//         email: email,
//         firebaseToken: firebaseToken,
//         token: token,
//         cityName: cityName,
//         cityId: cityId ?? this.cityId,
//         profileImage: profileImage ?? this.profileImage,
//         profileImagePath: profileImagePath ?? this.profileImagePath
//     );
//   }
//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//     id: json["id"],
//     name: json["name"],
//     address: json["address"],
//     phone: json["phone"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     verified: json["verified"],
//     email: json["email"],
//     profileImage: json['profileImagePath'] != null ? File(json['profileImagePath']) : null,
//     firebaseToken: json["firebase_token"],
//     token: json["token"],
//     cityName: json["city"],
//     cityId: json["city_id"] ,
//     profileImagePath: json["profile_image_path"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "address": address,
//     "phone": phone,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "verified": verified,
//     "email": email,
//     "city_id": cityId,// Ensure CitiesModel has a toJson method
//     'profileImagePath': profileImage?.path,
//     "firebase_token": firebaseToken,
//     "token": token,
//     "city": cityName,
//     "profile_image_path": profileImagePath,
//   };
//
//   // @override
//   // String toString() {
//   //   return 'UserModel(cityId:$cityId,token: $token  )';
//   //   // id: $id, name: $name, address: $address, phone: $phone, email: $email, verified: $verified, token: $token, profileImagePath: $profileImagePath,'
//   //
//   // }
// }
