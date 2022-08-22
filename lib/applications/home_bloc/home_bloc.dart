import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:bloc/bloc.dart';
import 'package:kaamasaan/models/audio.dart';
import 'package:kaamasaan/services/api_service.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ApiService apiService = ApiService();
  StreamSubscription? audioStream;
  HomeBloc() : super(HomeState.initial()) {
    on<OnRecordingStarted>((event, emit) async {
      state.recorderController.refresh();
      await state.recorderController.record();
      if (state.recorderController.isRecording) {
        state.playerController.stopPlayer();
        emit(state.copyWith(isRecording: true));
      }
    });
    on<OnRecordingStopped>((event, emit) async {
      final path = await state.recorderController.stop();
      if (path != null) {
        add(OnPlayerSetup(path));
      }
    });

    on<OnPlayerSetup>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await state.playerController.preparePlayer(event.path);
      try {
        String newFilePath = await apiService.convertAudioToWav(event.path);
        Audio audio = await apiService.sendAudioFile(newFilePath);
        emit(state.copyWithAudio(audio: audio));
        emit(state.copyWith(failure: ApiException("")));
      } on ApiException catch (e) {
        emit(state.copyWith(failure: e));
      }
      emit(state.copyWith(
          lastRecordingPath: event.path, isRecording: false, isLoading: false));
    });

    on<OnPlayerStarted>((event, emit) async {
      await state.playerController.seekTo(0);
      await state.playerController
          .startPlayer(finishMode: FinishMode.stop)
          .then((value) => null);
      emit(state.copyWith(isPlaying: true));
    });
    on<OnPlayerStopped>((event, emit) async {
      await state.playerController.pausePlayer();
      emit(state.copyWith(isPlaying: false));
    });
  }
}
