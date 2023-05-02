import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '_schema.dart';

enum TripStatus {
  active,
  created,
  canceled,
  completed;

  static TripStatus fromString(String value) {
    switch (value) {
      case 'active':
        return active;
      case 'created':
        return created;
      case 'completed':
        return completed;
      default:
        return canceled;
    }
  }
}

class TripSchema extends Equatable {
  const TripSchema({
    this.reference,
    required this.seats,
    required this.price,
    required this.driver,
    required this.departure,
    required this.destination,
    required this.departureDate,
    required this.seatsAvailable,
    required this.destinationDate,
    this.status = TripStatus.created,
  });

  static const String schema = 'trips';

  static const String seatsKey = 'seats';
  static const String priceKey = 'price';
  static const String driverKey = 'driver';
  static const String statusKey = 'status';
  static const String departureKey = 'departure';
  static const String destinationKey = 'destination';
  static const String departureDateKey = 'departure_date';
  static const String seatsAvailableKey = 'seats_available';
  static const String destinationDateKey = 'destination_date';

  final DocumentReference<TripSchema?>? reference;

  final int seats;
  final double price;
  final TripStatus status;
  final int seatsAvailable;
  final PlaceSchema departure;
  final DateTime? departureDate;
  final PlaceSchema destination;
  final DateTime? destinationDate;
  final DocumentReference<UserSchema?> driver;

  @override
  List<Object?> get props {
    return [
      seats,
      price,
      driver,
      status,
      reference,
      departure,
      destination,
      departureDate,
      seatsAvailable,
      destinationDate,
    ];
  }

  TripSchema copyWith({
    int? seats,
    double? price,
    TripStatus? status,
    int? seatsAvailable,
    PlaceSchema? departure,
    DateTime? departureDate,
    DateTime? destinationDate,
    PlaceSchema? destination,
    DocumentReference<UserSchema?>? driver,
    DocumentReference<TripSchema?>? reference,
  }) {
    return TripSchema(
      seats: seats ?? this.seats,
      price: price ?? this.price,
      driver: driver ?? this.driver,
      status: status ?? this.status,
      departure: departure ?? this.departure,
      reference: reference ?? this.reference,
      destination: destination ?? this.destination,
      departureDate: departureDate ?? this.departureDate,
      seatsAvailable: seatsAvailable ?? this.seatsAvailable,
      destinationDate: destinationDate ?? this.destinationDate,
    );
  }

  TripSchema clone() {
    return copyWith(
      seats: seats,
      price: price,
      driver: driver,
      status: status,
      reference: reference,
      departure: departure,
      destination: destination,
      departureDate: departureDate,
      seatsAvailable: seatsAvailable,
      destinationDate: destinationDate,
    );
  }

  static TripSchema fromMap(Map<String, dynamic> data) {
    return TripSchema(
      seats: data[seatsKey],
      price: data[priceKey],
      driver: data[driverKey],
      seatsAvailable: data[seatsAvailableKey],
      status: TripStatus.fromString(data[statusKey]),
      departure: PlaceSchema.fromMap(data[departureKey]),
      destination: PlaceSchema.fromMap(data[destinationKey]),
      departureDate: (data[departureDateKey] as Timestamp).toDate(),
      destinationDate: (data[destinationDateKey] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      seatsKey: seats,
      priceKey: price,
      driverKey: driver,
      statusKey: status,
      departureKey: departure.toMap(),
      departureDateKey: departureDate,
      seatsAvailableKey: seatsAvailable,
      destinationKey: destination.toMap(),
      destinationDateKey: destinationDate,
    }..removeWhere((key, value) => value == null);
  }

  static List<TripSchema> fromListJson(String source) {
    return List.of((jsonDecode(source) as List).map((value) => fromMap(value)));
  }

  static TripSchema fromJson(String source) {
    return fromMap(jsonDecode(source));
  }

  static String toListJson(List<TripSchema> values) {
    return jsonEncode(values.map((value) => value.toMap()));
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static DocumentReference<TripSchema> toFirestoreDocument(DocumentReference<Map<String, dynamic>> reference) {
    return reference.withConverter<TripSchema>(
      fromFirestore: (snapshot, options) {
        return fromMap(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toMap();
      },
    );
  }

  static CollectionReference<TripSchema> toFirestoreCollection(CollectionReference<Map<String, dynamic>> reference) {
    return reference.withConverter<TripSchema>(
      fromFirestore: (snapshot, options) {
        return fromMap(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toMap();
      },
    );
  }
}
