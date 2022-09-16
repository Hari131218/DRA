// import 'dart:async';
//
// import 'package:dra_project/screens/screens.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class assessmentCompletedflash extends StatefulWidget {
//   @override
//   _assessmentCompletedflashState createState() => _assessmentCompletedflashState();
// }
//
// class _assessmentCompletedflashState extends State<assessmentCompletedflash> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 2), () async {
//       String token = '';
//       await SharedPreferences.getInstance()
//           .then((value) => token = value.getString("accessToken") ?? '');
//       Navigator.of(this.context).pushReplacement(MaterialPageRoute(
//           builder: (BuildContext context) =>MyHomePage(accesstoken: '',)));});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 40.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Image.asset('assets/images/Logo.png'),
//               Image.asset('assets/images/logo1.png'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
