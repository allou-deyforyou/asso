import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '_schema.dart';

class UserSchema extends Equatable {
  const UserSchema({
    required this.name,
    required this.phone,
    required this.isDriver,
    required this.createdAt,
    required this.country,
    this.profileImage,
    this.reference,
  });

  static const String schema = 'users';

  static const String nameKey = 'name';
  static const String phoneKey = 'phone';
  static const String countryKey = 'country';
  static const String isDriverKey = 'is_driver';
  static const String createdAtKey = 'created_at';
  static const String profileImageKey = 'profile_image';

  final DocumentReference<UserSchema?>? reference;

  final String name;
  final String phone;
  final bool isDriver;
  final DateTime? createdAt;
  final String? profileImage;
  final DocumentReference<CountrySchema?> country;

  @override
  List<Object?> get props {
    return [
      name,
      phone,
      country,
      isDriver,
      createdAt,
      reference,
      profileImage,
    ];
  }

  UserSchema copyWith({
    String? name,
    String? phone,
    bool? isDriver,
    DateTime? createdAt,
    String? profileImage,
    DocumentReference<UserSchema?>? reference,
    DocumentReference<CountrySchema?>? country,
  }) {
    return UserSchema(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      isDriver: isDriver ?? this.isDriver,
      createdAt: createdAt ?? this.createdAt,
      reference: reference ?? this.reference,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  UserSchema clone() {
    return copyWith(
      name: name,
      phone: phone,
      country: country,
      isDriver: isDriver,
      createdAt: createdAt,
      reference: reference,
      profileImage: profileImage,
    );
  }

  static UserSchema fromMap(Map<String, dynamic> data) {
    return UserSchema(
      name: data[nameKey],
      phone: data[phoneKey],
      isDriver: data[isDriverKey],
      profileImage: data[profileImageKey],
      createdAt: (data[createdAtKey] as Timestamp?)?.toDate(),
      country: CountrySchema.toFirestoreDocument(data[countryKey]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      nameKey: name,
      phoneKey: phone,
      countryKey: country,
      isDriverKey: isDriver,
      createdAtKey: createdAt,
      profileImageKey: profileImage,
    }..removeWhere((key, value) => value == null);
  }

  static List<UserSchema> fromListJson(String source) {
    return List.of((jsonDecode(source) as List).map((value) => fromMap(value)));
  }

  static UserSchema fromJson(String source) {
    return fromMap(jsonDecode(source));
  }

  static String toListJson(List<UserSchema> values) {
    return jsonEncode(values.map((value) => value.toMap()));
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static DocumentReference<UserSchema> toFirestoreDocument(DocumentReference<Map<String, dynamic>> reference) {
    return reference.withConverter<UserSchema>(
      fromFirestore: (snapshot, options) {
        return fromMap(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toMap();
      },
    );
  }

  static CollectionReference<UserSchema> toFirestoreCollection(CollectionReference<Map<String, dynamic>> reference) {
    return reference.withConverter<UserSchema>(
      fromFirestore: (snapshot, options) {
        return fromMap(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toMap();
      },
    );
  }
}
