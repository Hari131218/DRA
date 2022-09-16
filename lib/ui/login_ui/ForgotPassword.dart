import 'package:dio/dio.dart';
import 'package:dra_project/ui/login_ui/verification_code.dart';
import 'package:flutter/material.dart';

import '../../models/login_page_api/api_login.dart';
import 'login_page.dart';

class SecondRoute extends StatefulWidget {
  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  bool isLoading = false;
  final TextEditingController userEmail = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  ForgotPassword(
    String email,
  ) async {
    isLoading = true;
    if (_formKey.currentState!.validate()) {
      Response res = await _apiClient.ForgotPassword(
        email,
      );
      print(res.statusCode);
      setState(() {
        isLoading = false;
      });
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(accesstoken: '')));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('OTP Sent Successfully'),
          backgroundColor: Colors.green.shade300,
        ));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PinCodeVerificationScreen(
                      email: userEmail.text,
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res.data['error']),
            backgroundColor: Colors.red.shade300,
          ),
        );
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => login_page(
                            access_token: '',
                          )),
                );
              },
              color: Color(0xff12AFC0),
            ),
            Text(
              'Back',
              style: TextStyle(
                  color: Color(0xff12AFC0),
                  fontFamily: 'San Francisco',
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 180, left: 34),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      fontSize: 35,
                      color: Color(0xff000000),
                      fontFamily: 'San Francisco',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 34, right: 40),
                child: Text(
                  "Please enter registered email address\nand we`ll send you instruction",
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff000000),
                    fontFamily: 'San Francisco',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, right: 34, left: 34),
                child: TextFormField(
                  controller: userEmail,
                  autocorrect: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Email Address',
                    prefixIcon: Image.asset(
                      'assets/images/mail.png',
                      color: Color(0xff808B9E),
                    ),
                    hintStyle: TextStyle(
                        color: Color(0xff808B9E),
                        fontSize: 12,
                        fontFamily: 'San Francisco',
                        fontWeight: FontWeight.w500),
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Color(0xff808B9E))),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Color(0xff808B9E)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter email ';
                    }
                    if (RegExp(r"\s+\b|\b\s").hasMatch(value)) {
                      return 'Blank Space';
                    }
                    // Check if the entered email has the right format
                    if (!RegExp(r'^.+@[^]+\.[^]+$').hasMatch(value)) {
                      return 'Please enter valid email';
                    }
                  },
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 34, right: 34),
                    child: Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff12AFC0),
                          ),
                          onPressed: () async {
                            {
                              ForgotPassword(
                                userEmail.text,
                              );
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
                              : Text('CONFIRM',
                                  style: TextStyle(
                                      fontFamily: 'San Francisco',
                                      fontWeight: FontWeight.w600)),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
