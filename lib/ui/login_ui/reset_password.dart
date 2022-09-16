import 'package:dra_project/ui/login_ui/verification_code.dart';
import 'package:flutter/material.dart';

import '../../models/login_page_api/api_login.dart';
import 'login_page.dart';

class reset_password extends StatefulWidget {
  final String email;
  const reset_password({
    Key? key,
    required this.email,
  }) : super(key: key);
  @override
  _reset_password createState() => _reset_password();
}

class _reset_password extends State<reset_password> {
  bool hidePassword = true;
  bool hidePassword1 = false;
  bool isLoading = false;
  // final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  var confirmPass;
  ResetPassword(String email, String password) async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      dynamic res = await _apiClient.ResetPassword(
        email,
        password,
      );
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (res?.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Password Successfully Reseted'),
          backgroundColor: Colors.green.shade300,
        ));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => login_page(access_token: '')));
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
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Color(0xff12AFC0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PinCodeVerificationScreen(
                            email: '',
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 150,
                    bottom: 15,
                    right: 35,
                    left: 20,
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reset Password",
                          style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 34, left: 34, bottom: 30),
                  child: Text(
                    "Enter your new password",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 34, right: 34, bottom: 10),
                  child: TextFormField(
                    obscureText: hidePassword, //show/hide password
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      prefixIcon: Image.asset('assets/images/icon1.png'),
                      suffixIcon: IconButton(
                        icon: hidePassword
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            10), //circular border for TextField.
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please Re-Enter New Password";
                      } else if (!RegExp(
                              r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)")
                          .hasMatch(value)) {
                        return "Password should contain a minimum of 1 character,\n1 special character,1 upper case and numeric";
                      }
                      return null;
                    },
                    onChanged: (value) => _userName = value,
                  ),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 34, right: 34),
                    child: TextFormField(
                        controller: passwordController,
                        onChanged: (value) {
                          print(value);
                        },
                        obscureText: hidePassword1, //show/hide password
                        decoration: InputDecoration(
                          hintText: 'Confirm  Password',
                          prefixIcon: Image.asset('assets/images/icon1.png'),
                          suffixIcon: IconButton(
                            icon: hidePassword1
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                hidePassword1 = !hidePassword1;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10), //circular border for TextField.
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Re-Enter New Password";
                          } else if (value != _userName) {
                            return "Password must be same as above";
                            return null;
                          }
                          ;
                        }),
                  ),
                ]),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(33, 0, 33, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff12AFC0),
                      ),
                      onPressed: () {
                        ResetPassword(widget.email, passwordController.text);
                      },
                      child: Text(
                        'CONFIRM',
                        style: TextStyle(
                            fontFamily: 'San Francisco',
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
