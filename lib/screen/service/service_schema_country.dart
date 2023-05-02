import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_less/flutter_less.dart';

import '_service.dart';

abstract class CountryState extends Equatable {
  const CountryState();
  @override
  List<Object?> get props => List.empty();
}

class InitialCountryState extends CountryState {
  const InitialCountryState();
}

class PendingCountryState extends CountryState {
  const PendingCountryState();
}

class FailureCountryState extends CountryState {
  const FailureCountryState({
    required this.message,
  });
  final String message;
}

class SubscriptionCountryState extends CountryState {
  const SubscriptionCountryState({
    required this.subscription,
  });
  final StreamSubscription subscription;
  @override
  List<Object?> get props => [subscription];
}

class ItemCountryState extends CountryState {
  const ItemCountryState({required this.data});
  final CountrySchema data;
  @override
  List<Object?> get props => [data];
}

class ItemListCountryState extends CountryState {
  const ItemListCountryState({required this.data});
  final Iterable<CountrySchema> data;
  @override
  List<Object?> get props => [data];
}

class CountryService extends LessService<CountryState> {
  CountryService([super.value = const InitialCountryState()]);

  FirebaseFirestore get firebaseFirestore => FirebaseService.firebaseFirestore;

  Future<void> queryCountries({
    GetOptions? getOptions,
    bool stream = false,
    // Country Fields
    String? name,
    String? dial,
    String? code,
  }) async {
    try {
      emit(const PendingCountryState());
      final collection = CountrySchema.toFirestoreCollection(
        firebaseFirestore.collection(CountrySchema.schema),
      );
      final query = collection
          .where(
            CountrySchema.nameKey,
            isEqualTo: name,
          )
          .where(
            CountrySchema.dialKey,
            isEqualTo: dial,
          )
          .where(
            CountrySchema.codeKey,
            isEqualTo: code,
          );
      if (stream) {
        final subscription = query.snapshots().listen((snapshot) {
          final data = snapshot.docs.where((doc) => doc.exists).map((doc) => doc.data());
          emit(ItemListCountryState(data: data));
        });
        emit(SubscriptionCountryState(subscription: subscription));
      } else {
        final snapshot = await query.get(getOptions);
        final data = snapshot.docs.where((doc) => doc.exists).map((doc) => doc.data());
        emit(ItemListCountryState(data: data));
      }
    } catch (error) {
      emit(FailureCountryState(message: error.toString()));
    }
  }

  Future<void> getCountry({
    required DocumentReference<CountrySchema> reference,
    GetOptions? getOptions,
  }) async {
    try {
      emit(const PendingCountryState());
      final snapshot = await reference.get(getOptions);
      if (snapshot.exists) {
        final data = snapshot.data()!;
        emit(ItemCountryState(data: data));
      } else {
        emit(const FailureCountryState(message: 'no-found'));
      }
    } catch (error) {
      emit(FailureCountryState(message: error.toString()));
    }
  }

  Future<void> createCountry({
    required CountrySchema data,
  }) async {
    try {
      emit(const PendingCountryState());
      final collection = CountrySchema.toFirestoreCollection(
        firebaseFirestore.collection(CountrySchema.schema),
      );
      final reference = await collection.add(data);
      emit(ItemCountryState(data: data.copyWith(reference: reference)));
    } catch (error) {
      emit(FailureCountryState(message: error.toString()));
    }
  }

  Future<void> updateCountry({
    required CountrySchema data,
    // Country Fields
    String? name,
    String? dial,
    String? code,
  }) async {
    assert(data.reference != null, 'Country.reference must be non nullable');
    try {
      emit(const PendingCountryState());
      await data.reference!.update({
        CountrySchema.nameKey: name,
        CountrySchema.dialKey: code,
        CountrySchema.codeKey: code,
      }..removeWhere((key, value) => value == null));
      emit(ItemCountryState(
        data: data.copyWith(
          name: name,
          dial: dial,
          code: code,
        ),
      ));
    } catch (error) {
      emit(FailureCountryState(message: error.toString()));
    }
  }

  Future<void> deleteCountry({
    required CountrySchema data,
  }) async {
    assert(data.reference != null, 'Country.reference must be non nullable');
    try {
      emit(const PendingCountryState());
      await data.reference!.delete();
      emit(ItemCountryState(data: data));
    } catch (error) {
      emit(FailureCountryState(message: error.toString()));
    }
  }
}
