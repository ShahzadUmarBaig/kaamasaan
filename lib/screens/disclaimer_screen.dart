import 'package:flutter/material.dart';
import 'package:kaamasaan/screens/home_screen.dart';

class DisclaimerScreen extends StatelessWidget {
  static const String id = "disclaimer_screen";
  const DisclaimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Text("Disclaimer", style: textStyle),
            SizedBox(height: 24),
            Text(
              "This application is solely for educational purposes."
              " It is not intended to be used for any other purpose. "
              "This application uses real voice recording to perform audio "
              "detection methods and present an optimum output.",
              textAlign: TextAlign.center,
              style:
                  textStyle.copyWith(fontWeight: FontWeight.w300, fontSize: 22),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade300,
                fixedSize: Size(MediaQuery.of(context).size.width, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, HomeScreen.id),
              child: Text(
                "Got It!",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get textStyle => TextStyle(
        fontFamily: "Poppins",
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );
}
