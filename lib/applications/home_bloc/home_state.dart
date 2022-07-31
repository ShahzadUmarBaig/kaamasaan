part of 'home_bloc.dart';

class HomeState {
  final bool isRecording;
  final RecorderController recorderController;
  final String lastRecordingPath;
  final PlayerController playerController;
  final bool isPlaying;
  final ApiException failure;
  final Audio? audio;

  HomeState({
    required this.isRecording,
    required this.recorderController,
    required this.lastRecordingPath,
    required this.playerController,
    required this.isPlaying,
    required this.failure,
    required this.audio,
  });

  factory HomeState.initial() => HomeState(
        isRecording: false,
        recorderController: RecorderController()
          ..androidEncoder = AndroidEncoder.aac
          ..androidOutputFormat = AndroidOutputFormat.mpeg4,
        lastRecordingPath: '',
        playerController: PlayerController(),
        isPlaying: false,
        failure: ApiException(""),
        audio: null,
      );

  HomeState copyWith({
    bool? isRecording,
    String? lastRecordingPath,
    bool? isPlaying,
    ApiException? failure,
  }) =>
      HomeState(
        isRecording: isRecording ?? this.isRecording,
        recorderController: this.recorderController,
        lastRecordingPath: lastRecordingPath ?? this.lastRecordingPath,
        playerController: this.playerController,
        isPlaying: isPlaying ?? this.isPlaying,
        failure: failure ?? this.failure,
        audio: audio,
      );

  HomeState copyWithAudio({Audio? audio}) => HomeState(
        isRecording: isRecording,
        recorderController: recorderController,
        lastRecordingPath: lastRecordingPath,
        playerController: playerController,
        isPlaying: isPlaying,
        failure: failure,
        audio: audio,
      );
}
