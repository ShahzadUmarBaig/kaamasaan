import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kaamasaan/screens/disclaimer_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                SvgPicture.asset("assets/images/logo.svg", height: 50),
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
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _usernameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z]'),
                      ),
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      fillColor: Colors.grey.shade200,
                      hintText: "Type here..",
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 0),
                SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade300,
                      fixedSize: Size(MediaQuery.of(context).size.width, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      if (_usernameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please enter a username"),
                          duration: Duration(seconds: 2),
                        ));
                        return;
                      }

                      Navigator.pushReplacementNamed(
                          context, DisclaimerScreen.id);
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
