import 'package:dra_project/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/login_page_api/api_login.dart';

class Change_Password extends StatefulWidget {
  final String email;
  const Change_Password({
    Key? key,
    required this.email,
  }) : super(key: key);
  // const Change_Password({Key? key, required this.email}) : super(key: key);

  @override
  State<Change_Password> createState() => _Change_PasswordState();
}

class _Change_PasswordState extends State<Change_Password> {
  final TextEditingController passwordController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool hidePassword = true;
  bool hidePassword1 = true;
  String _userName = '';
  Change_Password(String password) async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      var email = '';
      var accessToken = '';
      await SharedPreferences.getInstance().then((token) {
        accessToken = token.getString("accessToken")!;
        email = token.getString("email")!;
        print("email${token.getString("email")}");
        // fetchData(accessToken);
      });
      dynamic res =
          await _apiClient.Change_Password(email, password, accessToken);
      setState(() {
        isLoading = false;
      });
      if (res?.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('successfully login'),
          backgroundColor: Colors.green.shade300,
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => profile()));
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'CHANGE PASSWORD',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontFamily: 'San Francisco',
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => profile()));
            },
            icon: Icon(Icons.arrow_back_rounded)),
        backgroundColor: Color(0xff16698C),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30, bottom: 40),
                  child: Center(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 20, bottom: 30),
                  child: Text(
                    "Enter your new password",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    obscureText: hidePassword, //show/hide password
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      prefixIcon: Icon(Icons.lock),
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
                        return "Password should contain a minimum of 8 character,\n 1 special character,1 upper case and numeric,";
                      }
                      return null;
                    },
                    onChanged: (value) => _userName = value,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                          controller: passwordController,
                          onChanged: (value) {
                            print(value);
                          },
                          obscureText: hidePassword1, //show/hide password
                          decoration: InputDecoration(
                            hintText: 'Confirm  Password',
                            prefixIcon: Icon(Icons.lock),
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
                    SizedBox(
                      height: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Container(
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          profile()));
                                            },
                                            child: Text(
                                              'CANCEL',
                                              style: TextStyle(
                                                  fontFamily: 'San Francisco',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xffD45128),
                                                fixedSize: Size(165, 46)),
                                          ))),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  Expanded(
                                      child: Container(
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              {
                                                Change_Password(
                                                    passwordController.text);
                                              }
                                            },
                                            child: Text('UPDATE',
                                                style: TextStyle(
                                                    fontFamily: 'San Francisco',
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xff12AFC0),
                                                fixedSize: Size(165, 46)),
                                          )))
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
