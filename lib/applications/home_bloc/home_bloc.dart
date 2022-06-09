import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:kaamasaan/services/api_service.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ApiService apiService = ApiService();
  HomeBloc() : super(HomeState.initial()) {
    on<OnRecordingStarted>((event, emit) async {
      DateTime dateTime = DateTime.now();
      DateFormat format = DateFormat("d-m-y-h-M-s");
      String initialPath = "/data/user/0/io.flutterly.kaamasaan/cache/";
      String endPath = format.format(dateTime) + ".wav";

      state.recorderController.refresh();
      await state.recorderController.record(initialPath + endPath);

      if (state.recorderController.isRecording) {
        state.playerController.stopPlayer();
        emit(state.copyWith(isRecording: true));
      }
    });
    on<OnRecordingStopped>((event, emit) async {
      final path = await state.recorderController.stop();
      if (path != null) {
        await apiService.sendAudioFile(path);
        add(OnPlayerSetup(path));
      }
    });

    on<OnPlayerSetup>((event, emit) async {
      await state.playerController.preparePlayer(event.path);
      emit(state.copyWith(
        lastRecordingPath: event.path,
        isRecording: false,
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
