import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_less/flutter_less.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '_service.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object?> get props => List.empty();
}

class InitialUserState extends UserState {
  const InitialUserState();
}

class PendingUserState extends UserState {
  const PendingUserState();
}

class FailureUserState extends UserState {
  const FailureUserState({
    required this.message,
  });
  final String message;
}

class SubscriptionUserState extends UserState {
  const SubscriptionUserState({
    required this.subscription,
  });
  final StreamSubscription subscription;
  @override
  List<Object?> get props => [subscription];
}

class ItemUserState extends UserState {
  const ItemUserState({required this.data});
  final UserSchema data;
  @override
  List<Object?> get props => [data];
}

class ItemListUserState extends UserState {
  const ItemListUserState({required this.data});
  final Iterable<UserSchema> data;
  @override
  List<Object?> get props => [data];
}

class UserService extends LessService<UserState> {
  UserService([super.value = const InitialUserState()]);

  FirebaseFirestore get firebaseFirestore => FirebaseService.firebaseFirestore;

  Future<void> queryUsers({
    GetOptions? getOptions,
    bool stream = false,
    // User Fields
    DocumentReference<CountrySchema?>? country,
    bool? isNullableDriver,
    String? profileImage,
    bool? isDriver,
    String? name,
  }) async {
    try {
      emit(const PendingUserState());
      final collection = UserSchema.toFirestoreCollection(
        firebaseFirestore.collection(UserSchema.schema),
      );
      final query = collection
          .where(
            UserSchema.nameKey,
            isEqualTo: name,
          )
          .where(
            UserSchema.countryKey,
            isEqualTo: country,
          )
          .where(
            UserSchema.isDriverKey,
            isNull: isNullableDriver,
            isEqualTo: isDriver,
          )
          .where(
            UserSchema.profileImageKey,
            isEqualTo: profileImage,
          );
      if (stream) {
        final subscription = query.snapshots().listen((snapshot) {
          final data = snapshot.docs.where((doc) => doc.exists).map((doc) => doc.data());
          emit(ItemListUserState(data: data));
        });
        emit(SubscriptionUserState(subscription: subscription));
      } else {
        final snapshot = await query.get(getOptions);
        final data = snapshot.docs.where((doc) => doc.exists).map((doc) => doc.data());
        emit(ItemListUserState(data: data));
      }
    } catch (error) {
      emit(FailureUserState(message: error.toString()));
    }
  }

  Future<void> getUser({
    DocumentReference<UserSchema>? reference,
    GetOptions? getOptions,
    String? uid,
  }) async {
    assert(uid != null || reference != null, 'uid or reference must be non nullable');
    try {
      emit(const PendingUserState());
      reference ??= UserSchema.toFirestoreDocument(
        firebaseFirestore.doc('${UserSchema.schema}/$uid'),
      );
      final snapshot = await reference.get(getOptions);
      if (snapshot.exists) {
        final data = snapshot.data()!;
        emit(ItemUserState(data: data));
      } else {
        emit(const FailureUserState(message: 'no-found'));
      }
    } catch (error) {
      emit(FailureUserState(message: error.toString()));
    }
  }

  Future<void> createUser({
    required UserSchema data,
    required String uid,
  }) async {
    try {
      emit(const PendingUserState());
      final reference = UserSchema.toFirestoreDocument(
        firebaseFirestore.doc('${UserSchema.schema}/$uid'),
      );
      await reference.set(data);
      emit(ItemUserState(data: data.copyWith(reference: reference)));
    } catch (error) {
      emit(FailureUserState(message: error.toString()));
    }
  }

  Future<void> updateUser({
    required UserSchema data,
    // User Fields
    String? name,
    String? phone,
    bool? isDriver,
    DateTime? createdAt,
    String? profileImage,
    DocumentReference<CountrySchema?>? country,
  }) async {
    assert(data.reference != null, 'User.reference must be non nullable');
    try {
      emit(const PendingUserState());
      await data.reference!.update({
        UserSchema.nameKey: name,
        UserSchema.phoneKey: phone,
        UserSchema.countryKey: country,
        UserSchema.isDriverKey: isDriver,
        UserSchema.createdAtKey: createdAt,
        UserSchema.profileImageKey: profileImage,
      }..removeWhere((key, value) => value == null));
      emit(ItemUserState(
        data: data.copyWith(
          name: name,
          phone: phone,
          country: country,
          isDriver: isDriver,
          createdAt: createdAt,
          profileImage: profileImage,
        ),
      ));
    } catch (error) {
      emit(FailureUserState(message: error.toString()));
    }
  }

  Future<void> deleteUser({
    required UserSchema data,
  }) async {
    assert(data.reference != null, 'User.reference must be non nullable');
    try {
      emit(const PendingUserState());
      await data.reference!.delete();
      emit(ItemUserState(data: data));
    } catch (error) {
      emit(FailureUserState(message: error.toString()));
    }
  }
}
