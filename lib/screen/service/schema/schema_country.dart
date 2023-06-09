import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CountrySchema extends Equatable {
  const CountrySchema({
    required this.name,
    required this.dial,
    required this.code,
    this.reference,
  });

  static const String schema = 'countries';

  static const String nameKey = 'name';
  static const String dialKey = 'dial';
  static const String codeKey = 'code';

  final DocumentReference<CountrySchema?>? reference;

  final String name;
  final String dial;
  final String code;

  @override
  List<Object?> get props {
    return [
      code,
      name,
      dial,
      reference,
    ];
  }

  @override
  String toString() {
    return toMap().toString();
  }

  CountrySchema copyWith({
    String? name,
    String? dial,
    String? code,
    DocumentReference<CountrySchema?>? reference,
  }) {
    return CountrySchema(
      name: name ?? this.name,
      dial: dial ?? this.dial,
      code: code ?? this.code,
      reference: reference ?? this.reference,
    );
  }

  CountrySchema clone() {
    return copyWith(
      name: name,
      dial: dial,
      code: code,
      reference: reference,
    );
  }

  static List<CountrySchema> fromMapList(List<Map<String, dynamic>> data) {
    return data.map((e) => fromMap(e)).toList();
  }

  static CountrySchema fromMap(Map<String, dynamic> data) {
    return CountrySchema(
      code: data[codeKey],
      name: data[nameKey],
      dial: data[dialKey],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      codeKey: code,
      nameKey: name,
      dialKey: dial,
    }..removeWhere((key, value) => value == null);
  }

  static List<CountrySchema> fromJsonList(String source) {
    return List.of((jsonDecode(source) as List).map((value) => fromMap(value)));
  }

  static CountrySchema fromJson(String source) {
    return fromMap(jsonDecode(source));
  }

  static String toListJson(List<CountrySchema> values) {
    return jsonEncode(values.map((value) => value.toMap()));
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static DocumentReference<CountrySchema> toFirestoreDocument(DocumentReference<Map<String, dynamic>> reference) {
    return reference.withConverter<CountrySchema>(
      fromFirestore: (snapshot, options) {
        return fromMap(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toMap();
      },
    );
  }

  static CollectionReference<CountrySchema> toFirestoreCollection(CollectionReference<Map<String, dynamic>> reference) {
    return reference.withConverter<CountrySchema>(
      fromFirestore: (snapshot, options) {
        return fromMap(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toMap();
      },
    );
  }
}
