import 'package:flutter/material.dart';
import 'package:login_registration/Screens/dashboard/home.dart';
import 'package:login_registration/api/api.dart';
import 'package:login_registration/components/rounded_button.dart';
import 'package:login_registration/components/rounded_input_field.dart';
import 'package:login_registration/components/rounded_password_field.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  bool _autovaliodate = false;
  bool _isLoading = false;

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      autovalidate: _autovaliodate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RoundedInputField(
            hintText: "Your Email",
            icon: Icons.email,
            onChanged: (value) {

            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your email';
              } else  {
                bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);

                if (!emailValid) {
                  return 'Please enter a valid email address';
                }
              }
              return null;
            },
            controller: emailController,
          ),
          RoundedPasswordField(
            
            onChanged: (value) {

            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your account password';
              }
            },
            controller: passwordController,
          ),
          RoundedButton(
            text: "LOGIN",
            press: () {
              // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  loginForm();
                } else {
                  setState(() {
                    _autovaliodate = true;
                  });
                }
            },
          ),
        ],
      ),
    );
  }

  void loginForm() async {
    setState((){
      _isLoading = true;
    });

    var data = {
      'password': passwordController.text,
      'email': emailController.text,
    };

    var res = await CallApi().postDataWithoutToken(data, 'login');
    var body = json.decode(res.body);
    print(body);
    if(body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));

      Navigator.push(
        context, 
        new MaterialPageRoute(
          builder: (context) => HomeScreen()
        ),
      );
    } else {
      Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Something went wrong. Please try again.')));
    }

    setState(() {
       _isLoading = false; 
    });

  }
  
}