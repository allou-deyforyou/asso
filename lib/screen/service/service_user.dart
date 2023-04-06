import 'package:flutter_less/flutter_less.dart';

abstract class UserState {}

class InitialUserState extends UserState {}

class PendingUserState extends UserState {}

class FailureUserState extends UserState {}

abstract class UserEvent extends LessEvent<UserState> {}

class QueryUsers extends UserEvent {
  @override
  Future<void> execute(LessNotifier<UserState> notifier) async {
    notifier.value = PendingUserState();
    try {
      notifier.value = FailureUserState();
    } catch (error) {
      notifier.value = FailureUserState();
    }
  }
}

class QueryUser extends UserEvent {
  @override
  Future<void> execute(LessNotifier<UserState> notifier) async {
    notifier.value = PendingUserState();
    try {
      notifier.value = FailureUserState();
    } catch (error) {
      notifier.value = FailureUserState();
    }
  }
}

class CreateUser extends UserEvent {
  @override
  Future<void> execute(LessNotifier<UserState> notifier) async {
    notifier.value = PendingUserState();
    try {
      notifier.value = FailureUserState();
    } catch (error) {
      notifier.value = FailureUserState();
    }
  }
}

class UpdateUser extends UserEvent {
  @override
  Future<void> execute(LessNotifier<UserState> notifier) async {
    notifier.value = PendingUserState();
    try {
      notifier.value = FailureUserState();
    } catch (error) {
      notifier.value = FailureUserState();
    }
  }
}

class DeleteUser extends UserEvent {
  @override
  Future<void> execute(LessNotifier<UserState> notifier) async {
    notifier.value = PendingUserState();
    try {
      notifier.value = FailureUserState();
    } catch (error) {
      notifier.value = FailureUserState();
    }
  }
}
