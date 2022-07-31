import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamasaan/applications/home_bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PlayerController playerController = PlayerController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Stack(
            children: [
              Positioned(
                top: 20,
                width: MediaQuery.of(context).size.width,
                child: LanguageIndicator(),
              ),
              Positioned(
                bottom: 25,
                width: MediaQuery.of(context).size.width,
                child: ButtonPanel(),
              ),
              Positioned(
                top: 100,
                width: MediaQuery.of(context).size.width,
                child: WaveForm(),
              ),
              if (state.failure.message.isNotEmpty)
                Positioned(
                  top: 230,
                  width: MediaQuery.of(context).size.width,
                  child: ErrorBar(),
                ),
              if (state.failure.message.isEmpty && state.audio != null)
                Positioned(
                  top: 230,
                  width: MediaQuery.of(context).size.width,
                  child: TranslationWidget(),
                ),
            ],
          );
        },
      ),
    );
  }
}

class WaveForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.isRecording) {
          return Card(
            margin: EdgeInsets.all(24),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 1,
            child: AudioWaveforms(
              size: Size(MediaQuery.of(context).size.width, 100.0),
              recorderController: state.recorderController,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.zero,
              margin: EdgeInsets.symmetric(horizontal: 16),
              enableGesture: true,
              waveStyle: WaveStyle(
                showMiddleLine: false,
                extendWaveform: true,
              ),
            ),
          );
        } else if (!state.isRecording && state.lastRecordingPath.isNotEmpty) {
          return Card(
            margin: EdgeInsets.all(24),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 1,
            child: Row(
              children: [
                SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    splashRadius: 24,
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      if (state.isPlaying) {
                        context.read<HomeBloc>().add(OnPlayerStopped());
                      } else {
                        context.read<HomeBloc>().add(OnPlayerStarted());
                      }
                    },
                    icon: state.isPlaying
                        ? Icon(Icons.pause)
                        : Icon(Icons.play_arrow),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: AudioFileWaveforms(
                    size: Size(MediaQuery.of(context).size.width * 0.65, 100.0),
                    playerController: state.playerController,
                    // enableSeekGesture: true,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    playerWaveStyle: PlayerWaveStyle(
                      fixedWaveColor: Colors.blueGrey,
                      liveWaveColor: Colors.blue,
                      scaleFactor: 0.65,
                    ),
                  ),
                ),
                SizedBox(width: 8),
              ],
            ),
          );
        } else {
          return Card(
            margin: EdgeInsets.all(24),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 1,
            child: Container(
              height: 100,
              child: Center(
                child: Text(
                  "Press MIC Button To Start Recording",
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class LanguageIndicator extends StatelessWidget {
  const LanguageIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Row(
          children: [
            SizedBox(width: 20),
            CircleAvatar(
                backgroundImage: AssetImage("assets/images/us_flag.webp"),
                radius: 12),
            SizedBox(width: 10),
            Text("English"),
            Spacer(),
            Icon(Icons.arrow_back_outlined, color: Colors.green, size: 18),
            Spacer(),
            Text("اردو"),
            SizedBox(width: 10),
            CircleAvatar(
                backgroundImage: AssetImage("assets/images/pakistan_flag.webp"),
                radius: 12),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

class TranslationWidget extends StatelessWidget {
  const TranslationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.all(20),
          child: Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      "Translation",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    state.audio!.data.urdu,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Divider(
                  thickness: 0,
                  height: 0,
                  endIndent: 16,
                  indent: 16,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    state.audio!.data.english,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ErrorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          height: 56,
          margin: EdgeInsets.all(20),
          child: Card(
            color: Colors.red.shade300,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 1,
            child: Row(
              children: [
                SizedBox(width: 20),
                Text(
                  state.failure.message,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ButtonPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Center(
          child: Container(
            height: 60,
            width: 60,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        if (state.isRecording) {
                          context.read<HomeBloc>().add(OnRecordingStopped());
                        } else {
                          context.read<HomeBloc>().add(OnRecordingStarted());
                        }
                      },
                      icon: state.isRecording
                          ? Icon(Icons.stop)
                          : Icon(Icons.mic),
                      splashRadius: 16,
                      iconSize: 24,
                      color: state.isRecording ? Colors.red : Colors.green,
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
