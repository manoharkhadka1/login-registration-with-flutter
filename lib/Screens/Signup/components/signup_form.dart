import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_registration/Screens/dashboard/home.dart';
import 'package:login_registration/api/api.dart';
import 'package:login_registration/components/rounded_button.dart';
import 'package:login_registration/components/rounded_input_field.dart';
import 'package:login_registration/components/rounded_password_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpForm extends StatefulWidget {
  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool _autovaliodate = false;
  bool _isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            hintText: "Your Name",
            onChanged: (value) {

            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            controller: nameController,
          ),
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
            text: "SIGNUP",
            press: () {
              // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  submitRegistration();
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

  void submitRegistration() async {
    setState((){
      _isLoading = true;
    });

    var data = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    };

    var res = await CallApi().postDataWithoutToken(data, 'register');
    var body = json.decode(res.body);
    
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