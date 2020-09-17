import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_registration/Screens/Login/login.dart';
import 'package:login_registration/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userData;
  var userId;
  int pageIndex = 0;
  bool isAuthenticated = false;

  PageController pageController; 
  @override
  void initState() {
    getUserInfo();
    super.initState();
    pageController = PageController();
  }

  void getUserInfo() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userJson = localStorage.getString('user'); 
      var user = json.decode(userJson);
      setState(() {
        userData = user;

        if(user != null) {
          userId = user['id'];
          isAuthenticated = true;
        } else {
          isAuthenticated = false;
        }
      });
  }

  Scaffold authScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: 
      Container(
        padding: EdgeInsets.all(20),
        child: Container(
          child: Center(
            child: Text('You are Logged In.', 
            style: TextStyle(color: primaryColor, fontSize: 24
          ), 
          textAlign: TextAlign.center,)),
        ), 
      ),
    );
  }

  Widget build(BuildContext context) {
    return isAuthenticated ? authScreen() : LoginScreen();
  }
}