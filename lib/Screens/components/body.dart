import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_registration/Screens/Login/login.dart';
import 'package:login_registration/Screens/Signup/signup.dart';
import 'package:login_registration/components/rounded_button.dart';
import 'package:login_registration/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: size.width * .1),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("WELCOME TO MySite",
        style: TextStyle(
          // fontWeight: FontWeight.bold,
          fontSize: 18,
          color: primaryColor,
        ),
      ),
      SizedBox(
        height: size.height * 0.05,
      ),
      SvgPicture.asset(
        'assets/icons/instagram-circle.svg',
        height: size.height * 0.15,
      ),
      SizedBox(
        height: size.height * 0.05,
      ),
      RoundedButton(
        text: "Login",
        press: () {
          Navigator.push(
            context, MaterialPageRoute(
              builder: (context) {
                return LoginScreen();
              },
            ),
          );
        },
      ),
      RoundedButton(
        text: "Sign Up",
        color: primaryColor,
        textColor: Colors.black,
        press: () {
          Navigator.push(
            context, MaterialPageRoute(
              builder: (context) {
                return SignUpScreen();
              }
            )
          );
        },
      )
      ]
    ),);
  }
}