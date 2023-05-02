import 'package:equatable/equatable.dart';
import 'package:flutter_less/flutter_less.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '_service.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => List.empty();
}

class InitialAuthState extends AuthState {
  const InitialAuthState();
}

class PendingAuthState extends AuthState {
  const PendingAuthState();
}

class FailureAuthState extends AuthState {
  const FailureAuthState({
    required this.message,
  });
  final String message;
}

class SmsCodeSentAuthState extends AuthState {
  const SmsCodeSentAuthState({
    required this.verificationId,
    required this.resendToken,
    required this.phoneNumber,
    required this.timeout,
  });
  final String verificationId;
  final String phoneNumber;
  final Duration timeout;
  final int? resendToken;

  @override
  List<Object?> get props => [
        verificationId,
        resendToken,
        phoneNumber,
        timeout,
      ];
}

class CodeAutoRetrievalTimeoutAuthState extends AuthState {
  const CodeAutoRetrievalTimeoutAuthState({
    required this.verificationId,
    required this.phoneNumber,
    required this.timeout,
  });
  final String verificationId;
  final String phoneNumber;
  final Duration timeout;
  @override
  List<Object?> get props => [
        verificationId,
        phoneNumber,
        timeout,
      ];
}

class PhoneNumberVerifiedAuthState extends AuthState {
  const PhoneNumberVerifiedAuthState({required this.credential});
  final PhoneAuthCredential credential;
}

class UserSignedAuthState extends AuthState {
  const UserSignedAuthState({required this.user});
  final User user;
}

class SignedOutAuthState extends AuthState {
  const SignedOutAuthState();
}

/// AuthService
class AuthService extends LessService<AuthState> {
  AuthService([super.value = const InitialAuthState()]);

  FirebaseAuth get firebaseAuth => FirebaseService.firebaseAuth;

  Future<void> verifyPhoneNumber({
    timeout = const Duration(seconds: 30),
    required String phoneNumber,
    int? resendToken,
  }) async {
    try {
      return firebaseAuth.verifyPhoneNumber(
        codeAutoRetrievalTimeout: (verificationId) {
          emit(CodeAutoRetrievalTimeoutAuthState(
            verificationId: verificationId,
            phoneNumber: phoneNumber,
            timeout: timeout,
          ));
        },
        verificationCompleted: (credential) {
          emit(PhoneNumberVerifiedAuthState(
            credential: credential,
          ));
        },
        codeSent: (verificationId, resendToken) {
          emit(SmsCodeSentAuthState(
            verificationId: verificationId,
            phoneNumber: phoneNumber,
            resendToken: resendToken,
            timeout: timeout,
          ));
        },
        verificationFailed: (exception) {
          emit(FailureAuthState(
            message: exception.message!,
          ));
        },
        forceResendingToken: resendToken,
        phoneNumber: phoneNumber,
        timeout: timeout,
      );
    } catch (error) {
      emit(FailureAuthState(
        message: error.toString(),
      ));
    }
  }

  Future<void> updatePhoneNumber({required PhoneAuthCredential credential}) async {
    try {
      emit(const PendingAuthState());
      await firebaseAuth.currentUser!.updatePhoneNumber(credential);
      emit(UserSignedAuthState(user: firebaseAuth.currentUser!));
    } catch (error) {
      emit(FailureAuthState(message: error.toString()));
    }
  }

  Future<void> signIn({required AuthCredential credential}) async {
    try {
      emit(const PendingAuthState());
      final userCredential = await firebaseAuth.signInWithCredential(credential);
      emit(UserSignedAuthState(user: userCredential.user!));
    } catch (error) {
      emit(FailureAuthState(message: error.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      emit(const PendingAuthState());
      await firebaseAuth.signOut();
      emit(const SignedOutAuthState());
    } catch (error) {
      emit(FailureAuthState(message: error.toString()));
    }
  }
}
