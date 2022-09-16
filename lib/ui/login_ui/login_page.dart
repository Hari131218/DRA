import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/login_page_api/api_login.dart';
import '../../screens/screens.dart';
import 'ForgotPassword.dart';

class login_page extends StatefulWidget {
  login_page({Key? key, required String access_token}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  late SharedPreferences localStorage;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiClient _apiClient = ApiClient();

  login(String email, String password) async {
    setState(() {
      isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      dynamic res = await _apiClient.login(
        email,
        password,
      );
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (res?.statusCode == 200) {
        //   print((res as Response).data["access_token"]);
        save((res as Response).data["access_token"]);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('successfully login'),
          backgroundColor: Colors.green.shade300,
        ));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(accesstoken: '')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Enter valid user name or password"),
          backgroundColor: Colors.red.shade300,
        ));
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  String _userName = '';
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // emailController.text = "manivel@zaigoinfotech.com"; //Remove this before delivery
    //  emailController.text = "madhialagan@zaigoinfotech.com"; //Remove this before delivery
    // passwordController.text = "Madhi@20"; //Remove this before delivery
    // passwordController.text = "password"; //Remove this before delivery
    SharedPreferences.getInstance().then((value) {
      setState(() {
        localStorage = value;
      });
    });
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 102.37, left: 84, right: 83.2),
                    child: Image.asset("assets/images/Logo.png"),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 33.5, top: 25, bottom: 20),
                      child: Text(
                        'Login',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'San Francisco',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 34, right: 34, bottom: 15),
                      child: TextFormField(
                        controller: emailController,
                        autocorrect: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter user name',
                          prefixIcon: Image.asset('assets/images/icon.png'),
                          hintStyle: TextStyle(
                              color: Color(0xff808B9E),
                              fontSize: 12,
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w500),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Color(0xff808B9E))),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Color(0xff808B9E)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                          if (value.trim().length < 4) {
                            return 'Username must be at least 4 characters in length';
                          }
                          if (value.trim().length > 256) {
                            return 'Username must be at not more than 256 characters in length';
                          }
                          return null;
                        },
                        onChanged: (value) => _userName = value,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 34, right: 34, bottom: 11.56),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        autocorrect: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Password',
                          prefixIcon: Image.asset('assets/images/icon1.png'),
                          hintStyle: TextStyle(
                              color: Color(0xff808B9E),
                              fontSize: 12,
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w500),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Color(0xff808B9E))),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Color(0xff808B9E)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 35),
                          child: TextButton(
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'San Francisco',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff12AFC0)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondRoute()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 33.5, right: 34),
                          child: Container(
                              height: 45,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff12AFC0),
                                ),
                                onPressed: () async {
                                  {
                                    login(emailController.text,
                                        passwordController.text);
                                  }
                                },
                                child: (isLoading)
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 1.5,
                                        ))
                                    : Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'San Francisco'),
                                      ),
                              )),
                        ),
                        // if (localStorage!= null)
                        //
                        //   Padding(
                        //     padding: const EdgeInsets.all(15.0),
                        //     child: Text(
                        //       "User Logged in!!! ->  Email Id: ${localStorage.get('email')} ",
                        //           //" Password: ${localStorage.get('password')}",
                        //       style: TextStyle(fontSize: 20),),
                        //   ),
                      ],
                    )
                  ],
                )
              ]),
            ),
          ),
        ));
  }

  save(accessToken) async {
    localStorage.setString("accessToken", accessToken);
    localStorage.setString(
        'email',
        emailController.text
            .toString()); //  localStorage.setString('password', passwordController.text.toString());
    print("Access Token${localStorage.getString("accessToken")}");
  }
}
