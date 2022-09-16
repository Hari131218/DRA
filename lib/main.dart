import 'dart:async';

import 'package:dra_project/screens/screens.dart';
import 'package:dra_project/ui/login_ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/assessor_provider.dart';

//
void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AssessorProvider(),
    )
  ], child: const Myapp()));
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 0), () async {
      String token = '';
      await SharedPreferences.getInstance()
          .then((value) => token = value.getString("accessToken") ?? '');
      Navigator.of(this.context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => token.isNotEmpty
              ? MyHomePage(
                  accesstoken: token,
                )
              : login_page(
                  access_token: '',
                )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Image.asset('assets/images/Logo.png'),
              // Image.asset('assets/images/logo1.png'),
            ],
          ),
        ),
      ),
    );
  }
}
