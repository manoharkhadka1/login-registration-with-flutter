import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_registration/Screens/Login/components/login_form.dart';
import 'package:login_registration/Screens/Signup/signup.dart';
import 'package:login_registration/components/already_have_an_account.dart';


class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.width * .2),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'LOGIN',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: size.height * .03),
            SvgPicture.asset(
              "assets/icons/instagram-circle.svg",
              height: size.height * 0.15,
            ),
            SizedBox(height: size.height * .03),
            LoginForm(),
            SizedBox(height: size.height * .03),
            AlreadyHaveAnAccountCheck(
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
          ],
        ),
      ),
    );
  }
}