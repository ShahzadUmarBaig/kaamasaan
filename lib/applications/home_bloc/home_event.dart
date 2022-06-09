part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class OnRecordingStarted extends HomeEvent {}

class OnRecordingStopped extends HomeEvent {}

class OnPlayerSetup extends HomeEvent {
  final String path;

  OnPlayerSetup(this.path);
}

class OnPlayerStarted extends HomeEvent {}

class OnPlayerStopped extends HomeEvent {}
