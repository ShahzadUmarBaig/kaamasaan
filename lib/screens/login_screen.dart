import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Container(
              height: 100,
              width: 100,
              color: Colors.grey,
              child: Text("Logo Space"),
            ),
            SizedBox(height: 24),
            Flexible(
              child: Text(
                "Edit Username",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 4),
            Flexible(
              child: Text(
                "What would you like us to call you?",
                style: TextStyle(
                  fontSize: 18.5,
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  fillColor: Colors.grey.shade200,
                  hintText: "Type here..",
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade300,
                padding: EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 14,
                ),
              ),
              onPressed: () {},
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 8),
            CupertinoButton(
              onPressed: () {},
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
