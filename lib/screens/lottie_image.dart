import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class lottie extends StatefulWidget {
  const lottie({Key? key}) : super(key: key);

  @override
  State<lottie> createState() => _lottieState();
}

class _lottieState extends State<lottie> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/images/lottiimage.json'),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            'No Contacts Found ',
            style: TextStyle(fontSize: 25),
          ),
        ),
        Text('There is no result that matches for this search')
      ],
    );
  }
}
