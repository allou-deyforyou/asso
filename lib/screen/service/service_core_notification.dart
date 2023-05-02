import 'package:equatable/equatable.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
  @override
  List<Object?> get props => List.empty();
}

class InitialNotificationState extends NotificationState {
  const InitialNotificationState();
}

class PendingNotificationState extends NotificationState {
  const PendingNotificationState();
}
