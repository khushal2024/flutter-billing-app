import 'dart:async';
import 'dart:ui';

import 'package:customer/register.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'gridView.dart';

void main() {
  runApp(LoginScreen());
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    setState(() {
      isLoading = true;
    });

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();

    if (snapshot.size == 1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login successfully')));
      Navigator.push(context, MaterialPageRoute(builder: (context) => Grid()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid credentials')));
    }

    setState(() {
      isLoading = false;
    });
  }

  void navigate() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SignUp(),
        transitionDuration:
            Duration(seconds: 2), // Change the duration as needed
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.bounceInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 122, 152, 133),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/bg6.jpg"), fit: BoxFit.cover)),
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: Container(),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
                  child: SingleChildScrollView(
                    child: AnimatedContainer(
                      width: 350,
                      height: 500,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.bounceInOut,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 87, 201, 77),
                          Color.fromARGB(255, 87, 201, 77)
                        ]),
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Login",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 50,
                              color: Color(0xff00c853),
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 16),
                              child: TextField(
                                controller: emailController,
                                obscureText: false,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                        color: Color(0x00ffffff), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                        color: Color(0x00ffffff), width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                        color: Color(0x00ffffff), width: 1),
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    color: Color(0xff9f9d9d),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 236, 232, 195),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  prefixIcon: Icon(Icons.mail,
                                      color: Color(0xff00c853), size: 18),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                        color: Color(0x00ffffff), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                        color: Color(0x00ffffff), width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                        color: Color(0x00ffffff), width: 1),
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    color: Color(0xff9f9d9d),
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 236, 232, 195),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  prefixIcon: Icon(Icons.lock,
                                      color: Color(0xff00c853), size: 18),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 16),
                              child: MaterialButton(
                                onPressed: () => loginUser(context),
                                color: Color(0xff00c853),
                                elevation: 19,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                textColor: Color(0xffffffff),
                                height: 40,
                                minWidth: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Don't Have an account?",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextButton(
                                    child: Text(
                                      'SignUp',
                                      style: TextStyle(
                                          color: Color(0xff00c853),
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14),
                                    ),
                                    onPressed: () {
                                      navigate();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Lottie.network(
                            "https://lottie.host/a649a149-9f18-44b8-897a-c4b1f27435c1/ARUiJCkmyr.json",
                            height: 120,
                            fit: BoxFit.fill,
                            repeat: true,
                            animate: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  child: Center(
                    child: Lottie.network(
                      'https://lottie.host/6b0657a1-1b92-4ae2-881c-25e779137738/zoOszmZXUY.json',
                      height: 200,
                      repeat: true,
                      animate: true,
                      width: 200,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
