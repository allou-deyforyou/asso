import 'package:flutter_less/flutter_less.dart';

abstract class CountryState {}

class InitialCountryState extends CountryState {}

class PendingCountryState extends CountryState {}

class FailureCountryState extends CountryState {}

abstract class CountryEvent extends LessEvent<CountryState> {}

class QueryCountrys extends CountryEvent {
  @override
  Future<void> execute(LessNotifier<CountryState> notifier) async {
    notifier.value = PendingCountryState();
    try {
      notifier.value = FailureCountryState();
    } catch (error) {
      notifier.value = FailureCountryState();
    }
  }
}

class QueryCountry extends CountryEvent {
  @override
  Future<void> execute(LessNotifier<CountryState> notifier) async {
    notifier.value = PendingCountryState();
    try {
      notifier.value = FailureCountryState();
    } catch (error) {
      notifier.value = FailureCountryState();
    }
  }
}

class CreateCountry extends CountryEvent {
  @override
  Future<void> execute(LessNotifier<CountryState> notifier) async {
    notifier.value = PendingCountryState();
    try {
      notifier.value = FailureCountryState();
    } catch (error) {
      notifier.value = FailureCountryState();
    }
  }
}

class UpdateCountry extends CountryEvent {
  @override
  Future<void> execute(LessNotifier<CountryState> notifier) async {
    notifier.value = PendingCountryState();
    try {
      notifier.value = FailureCountryState();
    } catch (error) {
      notifier.value = FailureCountryState();
    }
  }
}

class DeleteCountry extends CountryEvent {
  @override
  Future<void> execute(LessNotifier<CountryState> notifier) async {
    notifier.value = PendingCountryState();
    try {
      notifier.value = FailureCountryState();
    } catch (error) {
      notifier.value = FailureCountryState();
    }
  }
}
