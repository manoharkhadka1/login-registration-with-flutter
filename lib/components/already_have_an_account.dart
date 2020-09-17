import 'package:flutter/material.dart';
import 'package:login_registration/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;

  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login? "Dont't have an Account ? " : "Already have an Account ? ",
          style: TextStyle(
            color: primaryColor, 
          )
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login? "Sign Up" : "Sign In",
            style: TextStyle(
              color: secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}