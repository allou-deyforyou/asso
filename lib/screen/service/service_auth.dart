import 'dart:ui';

import 'package:flutter_less/flutter_less.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '_service.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class PendingAuthState extends AuthState {}

class FailureAuthState extends AuthState {
  FailureAuthState({required this.message, this.event});
  final AuthEvent? event;
  final String message;
}

class SmsCodeSentState extends AuthState {
  SmsCodeSentState({
    required this.verificationId,
    required this.resendToken,
    required this.phoneNumber,
    required this.timeout,
  });
  final String verificationId;
  final String phoneNumber;
  final Duration timeout;
  final int? resendToken;
}

class PhoneNumberVerifiedState extends AuthState {
  PhoneNumberVerifiedState({required this.credential});
  final PhoneAuthCredential credential;
}

class UserSignedState extends AuthState {
  UserSignedState({required this.user});
  final User user;
}

abstract class AuthEvent extends LessEvent<AuthState> {
  static final LessNotifier instance = LessNotifier<AuthState>(InitialAuthState());

  final FirebaseAuth firebaseAuth = FirebaseService.firebaseAuth;
}

class VerifyPhoneNumberAuthEvent extends AuthEvent {
  VerifyPhoneNumberAuthEvent({
    this.timeout = const Duration(seconds: 30),
    required this.phoneNumber,
    this.resendToken,
  });

  final String phoneNumber;
  final int? resendToken;

  final Duration timeout;

  @override
  Future<void> execute(LessNotifier<AuthState> notifier) async {
    notifier.value = PendingAuthState();
    try {
      await firebaseAuth.setLanguageCode(window.locale.languageCode);
      await firebaseAuth.verifyPhoneNumber(
        codeAutoRetrievalTimeout: (verificationId) {},
        codeSent: (verificationId, resendToken) {
          notifier.value = SmsCodeSentState(
            verificationId: verificationId,
            phoneNumber: phoneNumber,
            resendToken: resendToken,
            timeout: timeout,
          );
        },
        verificationCompleted: (credential) {
          notifier.value = PhoneNumberVerifiedState(
            credential: credential,
          );
        },
        verificationFailed: (exception) {
          notifier.value = FailureAuthState(
            message: exception.message!,
            event: this,
          );
        },
        forceResendingToken: resendToken,
        phoneNumber: phoneNumber,
        timeout: timeout,
      );
    } catch (error) {
      notifier.value = FailureAuthState(
        message: error.toString(),
        event: this,
      );
    }
  }
}

class SignInOrUpdateAuthEvent extends AuthEvent {
  SignInOrUpdateAuthEvent({
    required this.verificationId,
    required this.smsCode,
    this.update = false,
    this.credential,
  });

  PhoneAuthCredential? credential;
  final String verificationId;
  final String smsCode;
  final bool update;

  @override
  Future<void> execute(LessNotifier<AuthState> notifier) async {
    notifier.value = PendingAuthState();
    try {
      credential ??= PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      if (update) {
        await firebaseAuth.currentUser!.updatePhoneNumber(credential!);
      } else {
        await firebaseAuth.signInWithCredential(credential!);
      }
      notifier.value = UserSignedState(user: firebaseAuth.currentUser!);
    } catch (error) {
      notifier.value = FailureAuthState(
        message: error.toString(),
        event: this,
      );
    }
  }
}

class UpdatePhoneNumberAuthEvent extends AuthEvent {
  UpdatePhoneNumberAuthEvent({required this.credential});

  final PhoneAuthCredential credential;

  @override
  Future<void> execute(LessNotifier<AuthState> notifier) async {
    notifier.value = PendingAuthState();
    try {
      await firebaseAuth.currentUser!.updatePhoneNumber(credential);
      notifier.value = UserSignedState(user: firebaseAuth.currentUser!);
    } catch (error) {
      notifier.value = FailureAuthState(
        message: error.toString(),
        event: this,
      );
    }
  }
}

class SignOutAuthEvent extends AuthEvent {
  SignOutAuthEvent();

  @override
  Future<void> execute(LessNotifier<AuthState> notifier) async {
    notifier.value = PendingAuthState();
    try {
      await firebaseAuth.signOut();
      notifier.value = InitialAuthState();
    } catch (error) {
      notifier.value = FailureAuthState(
        message: error.toString(),
        event: this,
      );
    }
  }
}
