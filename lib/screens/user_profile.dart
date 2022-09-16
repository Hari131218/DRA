import 'dart:convert';

import 'package:dra_project/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/app_constants.dart';
import '../models/profilescreen_api.dart';
import 'change_password.dart';
import 'edit_profile.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);
  @override
  State<profile> createState() => _profileHomeState();
}

class _profileHomeState extends State<profile> {
  late Future<List<ProfilescreenApi>> futureData;
  late SharedPreferences localStorage;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UserProfile? userObjcet;

  bool netCheck = false;

  List<String> items = List.generate(10, (index) => 'Hello $index');
  fetchData() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences.getInstance().then((token) async {
      var accessToken = token.getString("accessToken")!;
      final response = await post(Uri.parse('${BASE_URL}user'),
          headers: {'Authorization': 'Bearer ${accessToken}'});
      if (response.statusCode == 200) {
        userObjcet =
            UserProfile.fromJson((json.decode(response.body)['userProfile']));
        print(userObjcet!.toJson());
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Unexpected error occured!');
      }
    });
  }

  getStringValuesSF() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('YAY! Free cute dog pics!');
      //  Provider.of<AssessorProvider>(context, listen: false).getAssessment();

      setState(() {
        netCheck = true;
      });
      fetchData();
    } else {
      setState(() {
        netCheck = false;
      });

      print('No internet :( Reason:');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please check your internet connection and try again"),
        backgroundColor: Colors.red.shade300,
      ));

      // print(InternetConnectionChecker().lastTryResults);
    }

    // print("SHAREDDDDDDDDDD $stringValue");
  }

  @override
  void initState() {
    super.initState();

    getStringValuesSF();
    // SharedPreferences.getInstance().then((token) {
    //   accessToken = token.getString("accessToken")!;
    //  // fetchData(accessToken);
    //    futureData = fetchData(accessToken);
    // });
    // Provider.of<AssessorProvider>(context, listen: false).getAssessment();
  }

  // @override
  // Widget build(BuildContext context) {
  //   SharedPreferences.getInstance().then((value) {
  //     setState(() {
  //       localStorage = value;
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    var assessmentList = UserProfile();
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
          actions: [
            netCheck == false
                ? Container(
                    height: 5,
                  )
                : IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => profscreen()));
                    },
                    icon: Icon(Icons.edit))
          ],
          backgroundColor: Color(0xff16698C),
        ),
        body: netCheck == false
            ? Container(
                height: 5,
              )
            : !isLoading
                ? SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: userObjcet!.userPhoto!.isNotEmpty
                                  ? CircleAvatar(
                                      radius: 48, // Image radius
                                      backgroundImage:
                                          NetworkImage(userObjcet!.userPhoto!),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 48,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: Icon(
                                          Icons.person,
                                          size: 48,
                                        ),
                                        color: Colors.white,
                                        onPressed: () {},
                                      ),
                                    ),
                            ),

                            InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Change_Password(
                                              email: '',
                                            )),
                                  );
                                },
                                child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Change Password",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600),
                                    ))),

                            // Container(
                            //   child: Column(
                            //     children: [
                            //
                            //       Padding(
                            //         padding: const EdgeInsets.all(25),
                            //         child: Image.asset('assets/images/img_2.png'),
                            //       ),
                            //       Text(
                            //         'James Martin',
                            //         style: TextStyle(
                            //           color: Color(0xffFFFFFF),
                            //         ),
                            //       ),
                            //       Column(
                            //         children: [
                            //           Padding(
                            //             padding: const EdgeInsets.only(top: 8.0),
                            //             child: ElevatedButton(
                            //               style: ElevatedButton.styleFrom(),
                            //               onPressed: () {
                            //                 Navigator.push(
                            //                   context,
                            //                   MaterialPageRoute(
                            //                       builder: (context) => Change_Password(
                            //                             email: '',
                            //                           )),
                            //                 );
                            //               },
                            //               child: Text(
                            //                 'CHANGE PASSWORD',
                            //                 style: TextStyle(
                            //                     fontFamily: 'San Francisco',
                            //                     fontSize: 12,
                            //                     fontWeight: FontWeight.w600),
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            //   height: 290.0,
                            //   width: 400.0,
                            //   decoration: BoxDecoration(
                            //     image: DecorationImage(
                            //       image: AssetImage(
                            //         'assets/images/img_1.png',
                            //       ),
                            //       fit: BoxFit.fill,
                            //     ),
                            //     shape: BoxShape.rectangle,
                            //   ),
                            // ),

                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "First Name",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      // margin: const EdgeInsets.all(15.0),
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.black38, width: 2)),
                                      child: Text(
                                          userObjcet!.firstName.toString()),
                                    )
                                  ],
                                )),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Last Name",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      // margin: const EdgeInsets.all(15.0),
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.black38, width: 2)),
                                      child:
                                          Text(userObjcet!.lastName.toString()),
                                    )
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Email Address",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              // margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.black38, width: 2)),
                              child: Text(userObjcet!.email.toString()),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Mobile Number",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              // margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.black38, width: 2)),
                              child: Text(userObjcet!.mobileNo.toString()),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Address",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              // margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.black38, width: 2)),
                              child: Text(userObjcet!.address.toString()),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "State",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              // margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.black38, width: 2)),
                              child: Text(userObjcet!.state.toString()),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "City",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              // margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.black38, width: 2)),
                              child: Text(userObjcet!.city.toString()),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Zip code",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              // margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.black38, width: 2)),
                              child: Text(userObjcet!.pincode.toString()),
                            ),
                          ],
                        )))
                : Center(child: CircularProgressIndicator()));
  }
}
