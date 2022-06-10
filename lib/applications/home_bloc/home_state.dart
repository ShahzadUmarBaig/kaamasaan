part of 'home_bloc.dart';

class HomeState {
  final bool isRecording;
  final RecorderController recorderController;
  final String lastRecordingPath;
  final PlayerController playerController;
  final bool isPlaying;
  final bool isFailedToConvert;

  HomeState({
    required this.isRecording,
    required this.recorderController,
    required this.lastRecordingPath,
    required this.playerController,
    required this.isPlaying,
    required this.isFailedToConvert,
  });

  factory HomeState.initial() => HomeState(
        isRecording: false,
        recorderController: RecorderController()
          ..androidEncoder = AndroidEncoder.aac
          ..androidOutputFormat = AndroidOutputFormat.mpeg4,
        lastRecordingPath: '',
        playerController: PlayerController(),
        isPlaying: false,
        isFailedToConvert: false,
      );

  HomeState copyWith({
    bool? isRecording,
    String? lastRecordingPath,
    bool? isPlaying,
    bool? isFailedToConvert,
  }) =>
      HomeState(
        isRecording: isRecording ?? this.isRecording,
        recorderController: this.recorderController,
        lastRecordingPath: lastRecordingPath ?? this.lastRecordingPath,
        playerController: this.playerController,
        isPlaying: isPlaying ?? this.isPlaying,
        isFailedToConvert: isFailedToConvert ?? this.isFailedToConvert,
      );
}
