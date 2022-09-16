import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dra_project/ui/login_ui/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_button/timer_button.dart';

import '../../../models/login_page_api/api_login.dart';
import 'ForgotPassword.dart';

// void main() => runApp(MyApp());
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home:  PinCodeVerificationScreen(email: '',),
//     );bbb
//   }
// }

class PinCodeVerificationScreen extends StatefulWidget {
  final String email;
  const PinCodeVerificationScreen({
    Key? key,
    required this.email,
  }) : super(key: key);
  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  final ApiClient _apiClient = ApiClient();

  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
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
                  MaterialPageRoute(builder: (context) => SecondRoute()),
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 125, bottom: 10.92, right: 41, left: 34),
              child: Text(
                "Verification Code",
                style: TextStyle(
                    fontSize: 35,
                    color: Color(0xff000000),
                    fontFamily: 'San Francisco',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 34, right: 57, bottom: 18.7),
              child: Text(
                "Please enter your OTP sent to your\nregistered email id",
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xff000000),
                  fontFamily: 'San Francisco',
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
                  child: Container(
                    child: PinCodeTextField(
                      controller: otpController,
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      validator: (v) {
                        if (v!.length < 3) {
                          return "Enter OTP";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        selectedColor: Color(0xff808B9E),
                        inactiveColor: Color(0xff808B9E),
                        activeColor: Color(0xff808B9E),
                        errorBorderColor: Color(0xff808B9E),
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 54,
                        fieldWidth: 63,
                        //activeColor: Colors.black
                      ),
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset.zero,
                          color: Color(0xffFFFFFF),
                          blurRadius: 0,
                        ),
                      ],
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                    ),
                  )),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
              child: ButtonTheme(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 400,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff12AFC0),
                        ),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await Future.delayed(const Duration(seconds: 2));
                          setState(() {
                            isLoading = false;
                          });
                          {
                            validateOTP(widget.email, otpController.text);
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
                                'VERIFY',
                                style: TextStyle(
                                    fontFamily: 'San Francisco',
                                    fontWeight: FontWeight.w600),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Row(
                    children: [
                      Text(
                        'If you don`t receive any code?',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff808B9E),
                            fontFamily: 'San Francisco'),
                      ),
                      TimerButton(
                        label: "Resend",
                        timeOutInSeconds: 30,
                        onPressed: () async {
                          await _apiClient.ForgotPassword(
                            widget.email,
                          );
                        },
                        disabledTextStyle: new TextStyle(fontSize: 10.0),
                        activeTextStyle: new TextStyle(
                            fontSize: 10.0, color: Color(0xff16698C)),
                        buttonType: ButtonType.OutlineButton,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  validateOTP(String email, String otp) async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      Response res = await _apiClient.ValidateOTP(
        email,
        otp,
      );
      setState(() {
        isLoading = false;
      });
      print(res);
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeState(accesstoken: '',)));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('OTP Valid'),
          backgroundColor: Colors.green.shade300,
        ));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => reset_password(email: widget.email)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res.data['error']),
            backgroundColor: Colors.red.shade300,
          ),
        );
        print(res.statusCode);
      }
      ;
    }
  }
}
