import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_less/flutter_less.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '_service.dart';

extension on GeoPoint {
  // ~1 mile of lat and lon in degrees
  static const double _lat = 0.0144927536231884;
  static const double _lon = 0.0181818181818182;

  GeoPoint lower(double radius) {
    return GeoPoint(latitude - (_lat * radius), longitude - (_lon * radius));
  }

  GeoPoint greater(double radius) {
    return GeoPoint(latitude + (_lat * radius), longitude + (_lon * radius));
  }
}

abstract class TripState extends Equatable {
  const TripState();
  @override
  List<Object?> get props => List.empty();
}

class InitialTripState extends TripState {
  const InitialTripState();
}

class PendingTripState extends TripState {
  const PendingTripState();
}

class FailureTripState extends TripState {
  const FailureTripState({
    required this.message,
  });
  final String message;
}

class SubscriptionTripState extends TripState {
  const SubscriptionTripState({
    required this.subscription,
  });
  final StreamSubscription subscription;
  @override
  List<Object?> get props => [subscription];
}

class ItemTripState extends TripState {
  const ItemTripState({required this.data});
  final TripSchema data;
  @override
  List<Object?> get props => [data];
}

class ItemListTripState extends TripState {
  const ItemListTripState({required this.data});
  final Iterable<TripSchema> data;
  @override
  List<Object?> get props => [data];
}

class TripService extends LessService<TripState> {
  TripService([super.value = const InitialTripState()]);

  FirebaseFirestore get firebaseFirestore => FirebaseService.firebaseFirestore;

  Future<void> queryTrips({
    GetOptions? getOptions,
    bool stream = false,
    // Trip Fields
    int? seats,
    double? price,
    TripStatus? status,
    int? seatsAvailable,
    PlaceSchema? departure,
    String? departureName,
    double? departureRadius,
    GeoPoint? departurePosition,
    DateTime? departureDateTime,
    PlaceSchema? destination,
    String? destinationName,
    double? destinationRadius,
    GeoPoint? destinationPosition,
    DateTime? destinationDateTime,
    DocumentReference<UserSchema?>? driver,
  }) async {
    try {
      emit(const PendingTripState());
      final CollectionReference<TripSchema> collection = TripSchema.toFirestoreCollection(
        firebaseFirestore.collection(TripSchema.schema),
      );
      final Query<TripSchema> query = collection
          .where(
            TripSchema.seatsKey,
            isEqualTo: seats,
          )
          .where(
            TripSchema.seatsAvailableKey,
            isEqualTo: seatsAvailable,
          )
          .where(
            TripSchema.priceKey,
            isEqualTo: price,
          )
          .where(
            TripSchema.statusKey,
            isEqualTo: status,
          )
          .where(
            TripSchema.driverKey,
            isEqualTo: driver,
          )
          .where(
            TripSchema.departureKey,
            isEqualTo: departure,
          )
          .where(
            '${TripSchema.departureKey}.${PlaceSchema.positionKey}',
            isLessThan: departurePosition?.greater(departureRadius!),
            isGreaterThan: departurePosition?.lower(departureRadius!),
          )
          .where(
            TripSchema.destinationKey,
            isEqualTo: destination,
          )
          .where(
            '${TripSchema.destinationKey}.${PlaceSchema.positionKey}',
            isLessThan: destinationPosition?.greater(destinationRadius!),
            isGreaterThan: destinationPosition?.lower(destinationRadius!),
          );
      if (stream) {
        final StreamSubscription subscription = query.snapshots().listen((snapshot) {
          final data = snapshot.docs.where((doc) => doc.exists).map((doc) => doc.data());
          emit(ItemListTripState(data: data));
        });
        emit(SubscriptionTripState(subscription: subscription));
      } else {
        final QuerySnapshot<TripSchema> snapshot = await query.get(getOptions);
        final Iterable<TripSchema> data = snapshot.docs.where((doc) => doc.exists).map((doc) => doc.data());
        emit(ItemListTripState(data: data));
      }
    } catch (error) {
      emit(FailureTripState(message: error.toString()));
    }
  }

  Future<void> getTrip({
    required DocumentReference<TripSchema> reference,
    GetOptions? getOptions,
  }) async {
    try {
      emit(const PendingTripState());
      final DocumentSnapshot<TripSchema> snapshot = await reference.get(getOptions);
      if (snapshot.exists) {
        final TripSchema data = snapshot.data()!;
        emit(ItemTripState(data: data));
      } else {
        emit(const FailureTripState(message: 'no-found'));
      }
    } catch (error) {
      emit(FailureTripState(message: error.toString()));
    }
  }

  Future<void> createTrip({
    required TripSchema data,
  }) async {
    try {
      emit(const PendingTripState());
      final CollectionReference<TripSchema> collection = TripSchema.toFirestoreCollection(
        firebaseFirestore.collection(TripSchema.schema),
      );
      final DocumentReference<TripSchema> reference = await collection.add(data);
      emit(ItemTripState(data: data.copyWith(reference: reference)));
    } catch (error) {
      emit(FailureTripState(message: error.toString()));
    }
  }

  Future<void> updateTrip({
    required TripSchema data,
    // Trip Fields
    int? seats,
    double? price,
    TripStatus? status,
    int? seatsAvailable,
    PlaceSchema? departure,
    DateTime? departureDate,
    PlaceSchema? destination,
    DateTime? destinationDate,
    DocumentReference<UserSchema?>? driver,
  }) async {
    assert(data.reference != null, 'Trip.reference must be non nullable');
    try {
      emit(const PendingTripState());
      await data.reference!.update({
        TripSchema.seatsKey: seats,
        TripSchema.priceKey: price,
        TripSchema.statusKey: status,
        TripSchema.driverKey: driver,
        TripSchema.seatsAvailableKey: seatsAvailable,
        TripSchema.departureKey: departure,
        TripSchema.departureDateKey: departureDate,
        TripSchema.destinationKey: destination,
        TripSchema.destinationDateKey: destinationDate,
      }..removeWhere((key, value) => value == null));
      emit(ItemTripState(
        data: data.copyWith(
          seats: seats,
          price: price,
          status: status,
          seatsAvailable: seatsAvailable,
        ),
      ));
    } catch (error) {
      emit(FailureTripState(message: error.toString()));
    }
  }

  Future<void> deleteTrip({
    required TripSchema data,
  }) async {
    assert(data.reference != null, 'Trip.reference must be non nullable');
    try {
      emit(const PendingTripState());
      await data.reference!.delete();
      emit(ItemTripState(data: data));
    } catch (error) {
      emit(FailureTripState(message: error.toString()));
    }
  }
}
