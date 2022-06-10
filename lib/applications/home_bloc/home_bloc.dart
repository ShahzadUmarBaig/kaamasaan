import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:bloc/bloc.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:kaamasaan/domain/AudioTranslationModel.dart';
import 'package:kaamasaan/services/api_service.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ApiService apiService = ApiService();
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
      emit(state.copyWith(
        isLoading: true,
        isRecording: false,
        isTranslated: false,
      ));
      if (path != null) {
        add(OnPlayerSetup(path));
      }
    });

    on<OnPlayerSetup>((event, emit) async {
      await state.playerController.preparePlayer(event.path);

      String fileNameWithFormat = event.path.split("/").last;

      String fileNameOnly = fileNameWithFormat.split(".").first;

      String newFilePath =
          "/data/user/0/io.flutterly.kaamasaan/cache/" + fileNameOnly + ".wav";
      FFmpegSession session =
          await FFmpegKit.execute("-i ${event.path} $newFilePath");
      final returnCode = await session.getReturnCode();

      if (returnCode != null) {
        if (ReturnCode.isSuccess(returnCode)) {
          AudioTranslationModel translation =
              await apiService.sendAudioFile(newFilePath);
          emit(state.copyWith(translation: translation, isTranslated: true));
        }
        if (returnCode.isValueError()) {
          emit(state.copyWith(isFailedToConvert: true));
        }
      }
      emit(state.copyWith(
        lastRecordingPath: event.path,
        isLoading: false,
      ));
    });

    on<OnPlayerStarted>((event, emit) async {
      await state.playerController.startPlayer(true);
      emit(state.copyWith(isPlaying: true));
    });
    on<OnPlayerStopped>((event, emit) async {
      await state.playerController.pausePlayer();
      emit(state.copyWith(isPlaying: false));
    });
  }
}
