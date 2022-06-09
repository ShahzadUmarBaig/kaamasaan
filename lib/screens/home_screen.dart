import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final RecorderController recorderController;

  @override
  void initState() {
    super.initState();
    recorderController = RecorderController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          ListView(
            children: [],
          ),
          Positioned(
            top: 20,
            width: MediaQuery.of(context).size.width,
            child: LanguageIndicator(),
          ),
          Positioned(
            bottom: 25,
            width: MediaQuery.of(context).size.width,
            child: ButtonPanel(controller: recorderController),
          ),
          Positioned(
            top: 200,
            width: MediaQuery.of(context).size.width,
            child: AudioWaveforms(
              size: Size(MediaQuery.of(context).size.width, 100.0),
              recorderController: recorderController,
            ),
          ),
        ],
      ),
    );
  }
}

class LanguageIndicator extends StatelessWidget {
  const LanguageIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
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

class ButtonPanel extends StatelessWidget {
  final RecorderController controller;
  const ButtonPanel({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 160,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.history_edu_outlined),
                  splashRadius: 16,
                  iconSize: 20,
                  color: Colors.black54,
                  padding: EdgeInsets.zero,
                ),
                IconButton(
                  onPressed: () async {
                    DateTime dateTime = DateTime.now();
                    String initialPath =
                        "/data/user/0/io.flutterly.kaamasaan/cache/";
                    String path = dateTime.day.toString() +
                        "-" +
                        dateTime.month.toString() +
                        "-" +
                        dateTime.year.toString() +
                        "-" +
                        dateTime.hour.toString() +
                        "-" +
                        dateTime.minute.toString() +
                        "-" +
                        dateTime.second.toString() + ".wav";
                    await controller.record(initialPath + path);
                  },
                  icon: Icon(Icons.mic),
                  splashRadius: 16,
                  iconSize: 20,
                  color: Colors.green,
                  padding: EdgeInsets.zero,
                ),
                IconButton(
                  onPressed: () async {
                    final path = await controller.stop();
                    print(path);
                  },
                  icon: Icon(Icons.settings),
                  splashRadius: 16,
                  iconSize: 20,
                  color: Colors.black54,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
