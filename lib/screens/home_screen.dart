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
              if (state.isTranslated)
                Positioned(
                  top: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    margin: EdgeInsets.all(24),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 1,
                    color: Colors.blue.shade300,
                    child: Container(
                      padding: EdgeInsets.only(top: 8),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Translation",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 135,
                width: MediaQuery.of(context).size.width,
                child: TranslatedTextView(),
              ),
              Positioned(
                bottom: 70,
                width: MediaQuery.of(context).size.width,
                child: WaveForm(),
              ),
              if (state.isFailedToConvert)
                Positioned(
                  top: 230,
                  width: MediaQuery.of(context).size.width,
                  child: ErrorBar(),
                ),
            ],
          );
        },
      ),
    );
  }
}

class TranslatedTextView extends StatelessWidget {
  const TranslatedTextView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Card(
          margin: EdgeInsets.all(24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 1,
          child: !state.isTranslated
              ? Container()
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: state.translation!.data.fold((l) {
                    return Row(
                      children: [],
                    );
                  }, (r) {
                    return Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  r.urdu,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ]),
                        Divider(),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  r.english,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ]),
                      ],
                    );
                  }),
                ),
        );
      },
    );
  }
}

class WaveForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Card(
          margin: EdgeInsets.all(24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 1,
          child: getWaveFormWidget(state),
        );
      },
    );
  }

  Widget getWaveFormWidget(HomeState state) {
    if (state.isRecording) {
      return WaveFormRecordingView();
    } else if (state.isLoading) {
      return Container(
        height: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (!state.isRecording && state.lastRecordingPath.isNotEmpty) {
      return WaveFormOutputView();
    } else {
      return Container(
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
      );
    }
  }
}

class WaveFormRecordingView extends StatelessWidget {
  const WaveFormRecordingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AudioWaveforms(
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
        );
      },
    );
  }
}

class WaveFormOutputView extends StatelessWidget {
  const WaveFormOutputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Row(
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
        );
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

class ErrorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: EdgeInsets.all(20),
      child: Card(
        color: Colors.red.shade300,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Row(
          children: [
            SizedBox(width: 20),
            Text(
              "Failed To Convert Audio",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.refresh),
              color: Colors.white,
              padding: EdgeInsets.zero,
              splashRadius: 20,
              splashColor: Colors.redAccent.shade700,
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
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
            height: 50,
            width: 150,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 1,
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: state.isLoading
                          ? null
                          : () async {
                              if (state.isRecording) {
                                context
                                    .read<HomeBloc>()
                                    .add(OnRecordingStopped());
                              } else {
                                context
                                    .read<HomeBloc>()
                                    .add(OnRecordingStarted());
                              }
                            },
                      icon: state.isRecording
                          ? Icon(Icons.stop)
                          : Icon(Icons.mic),
                      splashRadius: 16,
                      iconSize: 20,
                      color: state.isRecording ? Colors.red : Colors.green,
                      padding: EdgeInsets.zero,
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      onPressed: () {},
                      child: Text(
                        "History",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey.shade400,
                        ),
                      ),
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
