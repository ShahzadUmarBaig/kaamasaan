part of 'home_bloc.dart';

class HomeState {
  final bool isRecording;
  final RecorderController recorderController;
  final String lastRecordingPath;
  final PlayerController playerController;
  final bool isPlaying;

  HomeState({
    required this.isRecording,
    required this.recorderController,
    required this.lastRecordingPath,
    required this.playerController,
    required this.isPlaying,
  });

  factory HomeState.initial() => HomeState(
        isRecording: false,
        recorderController: RecorderController()
          ..androidEncoder = AndroidEncoder.aac
          ..androidOutputFormat = AndroidOutputFormat.,
        lastRecordingPath: '',
        playerController: PlayerController(),
        isPlaying: false,
      );

  HomeState copyWith(
          {bool? isRecording, String? lastRecordingPath, bool? isPlaying}) =>
      HomeState(
        isRecording: isRecording ?? this.isRecording,
        recorderController: this.recorderController,
        lastRecordingPath: lastRecordingPath ?? this.lastRecordingPath,
        playerController: this.playerController,
        isPlaying: isPlaying ?? this.isPlaying,
      );
}
