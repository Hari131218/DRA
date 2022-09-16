// import 'dart:convert';
//
// import 'package:dra_project/common/no_result.dart';
// import 'package:dra_project/screens/SubmitDetailsPage.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../common/app_constants.dart';
// import '../models/assessment_list_model.dart';
// import 'assessor_provider.dart';
//
// class SecondScreen extends StatefulWidget {
//   const SecondScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SecondScreen> createState() => _SecondScreenState();
// }
//
// class _SecondScreenState extends State<SecondScreen> {
//   late ScrollController controller;
//   late Future<List<AssessmentListModel>> futureData;
//   late SharedPreferences localStorage;
//   bool isLoading = false;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   //final ApiClient _apiClient = ApiClient();
//
//   List<AssessmentList> dataList = [];
//   // assessmentlist() async {
//   //   if (_formKey.currentState!.validate()) {
//   //     Response res = await _apiClient.assessmentlist();
//   //     print(res);
//   //     //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeState(accesstoken: '',)));
//   //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//   //     if (res.statusCode == 200) {
//   //       print((res as Response).data["access_token"]);
//   //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //         content: const Text('Successfully login'),
//   //         backgroundColor: Colors.green.shade300,
//   //       )
//   //       );
//   //       Navigator.push(
//   //           context,
//   //           MaterialPageRoute(
//   //               builder: (context) => Basic()));
//   //     } else {
//   //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //         content: Text(res.data['error']),
//   //         backgroundColor: Colors.red.shade300,
//   //       ),
//   //       );
//   //       print(res.statusCode);
//   //     };
//   //   }
//   // }
//
//   List<String> items = List.generate(10, (index) => 'Hello $index');
//   fetchData(accessToken) async {
//     print('tok${accessToken}');
//
//     final response = await get(
//         Uri.parse(
//             '${BASE_URL}assessment_requests/submited_form'),
//         headers: {'Authorization': 'Bearer ${accessToken}'});
//     if (response.statusCode == 200) {
//       print('hi${response.body}');
//
//       dataList = (json.decode(response.body)['assessorNameList'] as List)
//           .map((e) => new AssessmentList.fromJson(e))
//           .toList();
//       return dataList;
//     } else {
//       throw Exception('Unexpected error occured!');
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     var accessToken = "";
//
//     // SharedPreferences.getInstance().then((token) {
//     //   accessToken = token.getString("accessToken")!;
//     //   // fetchData(accessToken);
//     //   futureData = fetchData(accessToken);
//     // });
//     getStringValuesSF();
//     controller = ScrollController()..addListener(_scrollListener);
//   }
//
//
//   getStringValuesSF() async {
//     bool result = await InternetConnectionChecker().hasConnection;
//     if (result == true) {
//       print('YAY! Free cute dog pics!');
//       Provider.of<AssessorProvider>(context, listen: false)
//           .getSubmittedAssessment();
//     } else {
//       print('No internet :( Reason:');
//
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Please check your internet connection and try again"),
//         backgroundColor: Colors.red.shade300,
//       ));
//
//
//       // print(InternetConnectionChecker().lastTryResults);
//     }
//
//     // print("SHAREDDDDDDDDDD $stringValue");
//   }
//
//
//
//   @override
//   void dispose() {
//     controller.removeListener(_scrollListener);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     AssessorProvider _provider = Provider.of<AssessorProvider>(context);
//     //  return Text('data');
//     return _provider.isLoading
//         ? const SizedBox(
//             height: 200,
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           )
//         : Container( child: _provider.assessmentSubmittedList.isNotEmpty ? ListView.builder(
//             itemCount: _provider.assessmentSubmittedList.length,
//             itemBuilder: (BuildContext context, int index) {
//               final assimentList = _provider.assessmentSubmittedList[index];
//               Text('${assimentList.assignedDate}');
//               return InkWell(
//                 child: NewWidget(assimentList: assimentList),
//                 // onTap: () {
//                 //
//                 //   Navigator.push(context,
//                 //       MaterialPageRoute(builder: (context) => SubmitDetailsPage(ids: '${assimentList.assessmentRequestId}',)));
//                 //
//                 // },
//               );
//               //  NewWidget(assimentList: assimentList);
//             }):Center(child: EmptyData(),));
//
// //       Form(jjajka
// //       child: ListView.builder(
// //           controller: controller,
// //           itemCount: items.length,
// //         itemBuilder: (BuildContext context, int index) {
// //           return Column(
// // crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //       Padding(
// //         padding: EdgeInsets.only(left: 15.0, top: 15, bottom: 15),
// //         child: Text(
// //           'Today',
// //           style: TextStyle(fontWeight: FontWeight.bold),
// //         ),
// //       ),
// //       Padding(
// //         padding: const EdgeInsets.only(left: 10.0, right: 10),
// //         child: Container(
// //           child: InkWell(child: buildCard(), onTap: ()
// //
// //
// //             async {
// //               await _apiClient.assessmentlist(localStorage.getString("accessToken")??'');
// //               Navigator.pushReplacement(
// //                   context,
// //                   MaterialPageRoute(
// //                       builder: (context) =>
// //                           Basic(access_token: 'access_token',)));
// //             },
// //
// //
// //           // {
// //           //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Basic(),));
// //           //
// //           // },
// //           ),
// //         ),
// //       ),
// //         ],
// //       );
// //   }
// //       ),
// //     );
//   }
//
//   void _scrollListener() {
//     print(controller.position.extentAfter);
//     if (controller.position.extentAfter < 5) {
//       setState(() {
//         items.addAll(List.generate(10, (index) => 'Inserted $index'));
//       });
//     }
//   }
// }
//
// class NewWidget extends StatelessWidget {
//   const NewWidget({
//     Key? key,
//     required this.assimentList,
//   }) : super(key: key);
//
//   final AssessmentList assimentList;
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(5.0),
//       ),
//       color: Colors.white,
//       elevation: 3,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 18.0, top: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '${assimentList.firstName}',
//                   style: TextStyle(
//                       fontFamily: 'San Francisco',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                       color: Color(0xff000000)),
//                 ),
//
//                 // TextButton(
//                 //   style: TextButton.styleFrom(
//                 //     primary: Color(0xffA5A5A5),
//                 //     minimumSize: Size(10, 0)
//                 //   ),
//                 //   onPressed: () { },
//                 //   child: Icon(Icons.more_vert,size: 10,),
//                 // ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 18.0, top: 5),
//             child: Text(
//               '${assimentList.address}',
//               style: TextStyle(
//                   color: Color(0xffA5A5A5),
//                   fontSize: 10,
//                   fontFamily: 'San Francisco'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 18.0, top: 5),
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     right: 8.0,
//                   ),
//                   child: CircleAvatar(
//                     radius: 10,
//                     child: Icon(
//                       Icons.mail,
//                       color: Colors.white,
//                       size: 8,
//                     ),
//                     backgroundColor: Color(0xff00b3bf),
//                   ),
//                 ),
//                 Text(
//                   '${assimentList.email}',
//                   style: TextStyle(
//                       fontFamily: 'San Francisco',
//                       fontSize: 10,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xff000000)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0, left: 20),
//                   child: CircleAvatar(
//                     radius: 10,
//                     child: Icon(
//                       Icons.phone,
//                       color: Colors.white,
//                       size: 8,
//                     ),
//                     backgroundColor: Color(0xff00b3bf),
//                   ),
//                 ),
//                 Text(
//                   '${assimentList.phoneNumber}',
//                   style: TextStyle(
//                       fontFamily: 'San Francisco',
//                       fontSize: 10,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xff000000)),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 18.0, right: 8),
//             child: Divider(),
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.only(left: 18.0),
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //     children: [
//           //       Text(
//           //         '${assimentList.webId}',
//           //         style: TextStyle(
//           //             fontFamily: 'San Francisco',
//           //             color: Color(0xff16698C),
//           //             fontSize: 10,
//           //             fontWeight: FontWeight.w700),
//           //       ),
//           //       // Padding(
//           //       //   padding: const EdgeInsets.only(bottom: 8.0, right: 10),
//           //       //   child: Row(
//           //       //     children: [
//           //       //       Icon(
//           //       //         Icons.calendar_month_outlined,
//           //       //         color: Colors.black,
//           //       //         size: 12,
//           //       //       ),
//           //       //       Text(
//           //       //         '${assimentList.assignedDate}',
//           //       //         style: TextStyle(color: Colors.black, fontSize: 10),
//           //       //       ),
//           //       //     ],
//           //       //   ),
//           //       // )
//           //     ],
//           //   ),
//           // )
//         ],
//       ),
//     );
//   }
// }
