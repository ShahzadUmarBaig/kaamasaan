part of 'home_bloc.dart';

class HomeState {
  final bool isRecording;
  final bool isPlaying;
  final bool isFailedToConvert;
  final bool isLoading;
  final bool isTranslated;

  final RecorderController recorderController;
  final String lastRecordingPath;
  final PlayerController playerController;
  final AudioTranslationModel? translation;

  HomeState({
    required this.isRecording,
    required this.recorderController,
    required this.lastRecordingPath,
    required this.playerController,
    required this.isPlaying,
    required this.isFailedToConvert,
    required this.isLoading,
    required this.translation,
    required this.isTranslated,
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
        isLoading: false,
        translation: null,
        isTranslated: false,
      );

  HomeState copyWith({
    bool? isRecording,
    String? lastRecordingPath,
    bool? isPlaying,
    bool? isFailedToConvert,
    bool? isLoading,
    AudioTranslationModel? translation,
    bool? isTranslated,
  }) =>
      HomeState(
        isRecording: isRecording ?? this.isRecording,
        recorderController: this.recorderController,
        lastRecordingPath: lastRecordingPath ?? this.lastRecordingPath,
        playerController: this.playerController,
        isPlaying: isPlaying ?? this.isPlaying,
        isFailedToConvert: isFailedToConvert ?? this.isFailedToConvert,
        isLoading: isLoading ?? this.isLoading,
        translation: translation ?? this.translation,
        isTranslated: isTranslated ?? this.isTranslated,
      );
}
