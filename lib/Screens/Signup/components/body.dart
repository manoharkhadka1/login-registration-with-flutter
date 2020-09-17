import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_registration/Screens/Login/login.dart';
import 'package:login_registration/Screens/Signup/components/signup_form.dart';
import 'package:login_registration/components/already_have_an_account.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.width * .2),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN UP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              height: size.height * 0.035,
            ),
            SvgPicture.asset(
              "assets/icons/instagram-circle.svg",
              height: size.height * 0.15,
            ),
            SizedBox(
              height: size.height * 0.035,
            ),
            SignUpForm(),
            SizedBox(
              height: size.height * 0.035,
            ),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    }
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}