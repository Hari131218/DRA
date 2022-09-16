// import 'dart:convert';
// import 'package:dra_project/screens/screens.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../common/app_constants.dart';
// import '../models/submittedlistform.dart';
// import 'assessor_provider.dart';
//
// class SubmitDetailsPage extends StatefulWidget {
//   const SubmitDetailsPage({Key? key, required this.ids}) : super(key: key);
//
//   final String ids;
//
//   @override
//   State<SubmitDetailsPage> createState() => _SubmitDetailsPageState();
// }
//
// class _SubmitDetailsPageState extends State<SubmitDetailsPage> {
//   late Future<List<submittedlistform>> futureData;
//   late SharedPreferences localStorage;
//   bool isLoading = false;
//   late AssessmentDetailsList dataList;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   fetchData() async {
//     setState(() {
//       isLoading = true;
//     });
//     var accessToken = '';
//     await SharedPreferences.getInstance().then((token) {
//       accessToken = token.getString("accessToken")!;
//     });
//     print('tok${widget.ids}');
//
//     final response = await get(
//         Uri.parse(
//             '${BASE_URL}assessments/assessment_detail/${widget.ids}'),
//         headers: {'Authorization': 'Bearer ${accessToken}'});
//     if (response.statusCode == 200) {
//       setState(() {
//         isLoading = false;
//       });
//       print(response.body);
//       dataList = AssessmentDetailsList.fromJson(
//           json.decode(response.body)['assessmentDetailsList']);
//
//       print("IMAGESSSSSSSSSSS${dataList.damageSnaps}");
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//
//       throw Exception('Unexpected error occured!');
//     }
//   }
//
//   // fetchData() async {
//   //   setState(() {
//   //     isLoading = true;
//   //   });
//   //   SharedPreferences.getInstance().then((token) async {
//   //      var accessToken = token.getString("accessToken")!;
//   //
//   //     final response = await get(
//   //         Uri.parse('http://3.223.85.137/disaster_reconstruction/api/assessments/assessment_detail/${widget.ids}'),
//   //      headers: {'Authorization': 'Bearer ${accessToken}'});
//   //     if (response.statusCode == 200) {
//   //           AssessmentDetailsList.fromJson((json.decode(response.body)['AssessmentDetailsList']));
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //     } else {
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //       throw Exception('Unexpected error occured!');
//   //     }
//   //   });
//   // }
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _formKey,
//         appBar: AppBar(
//           backgroundColor: Color(0xff16698C),
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(Icons.arrow_back_ios)),
//           title: Text(
//             "Submitted Information",
//             style: TextStyle(fontSize: 18),
//           ),
//           centerTitle: true,
//         ),
//         body: isLoading
//             ? Center(child: CircularProgressIndicator())
//             : SingleChildScrollView(
//                 child: Container(
//                   child: NewWidget(
//                     assimentList: dataList,
//                   ),
//                 ),
//               ));
//   }
// }
//
// class NewWidget extends StatelessWidget {
//   const NewWidget({
//     required this.assimentList,
//     Key? key,
//   }) : super(key: key);
//   final AssessmentDetailsList assimentList;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
//             child: Card(
//               elevation: 5,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 15, bottom: 10, left: 15),
//                     child: Text(
//                       'Homeowner Information',
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff16698C)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 10, left: 15),
//                     child: Text(
//                       'Homeowner Name',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(
//                       assimentList.name == null
//                           ? "N/A"
//                           : '${assimentList.name}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10, left: 15),
//                     child: Text(
//                       'Mobile Number',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 15, top: 10, bottom: 10),
//                     child: Text(
//                       assimentList.callNumber == null
//                           ? "N/A"
//                           : '${assimentList.callNumber}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 10, left: 15),
//                     child: Text(
//                       'E-mail Address',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15, bottom: 10),
//                     child: Text(
//                       assimentList.emailAddress == null
//                           ? "N/A"
//                           : '${assimentList.emailAddress}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 10, left: 15),
//                     child: Text(
//                       'Street Address',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(
//                       assimentList.streetAddress == null
//                           ? "N/A"
//                           : '${assimentList.streetAddress}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 10, left: 15, bottom: 10),
//                     child: Text(
//                       'Island',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(
//                       assimentList.island == null
//                           ? "N/A"
//                           : '${assimentList.island}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 10, left: 15, bottom: 10),
//                     child: Text(
//                       'Home Number',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(
//                       assimentList.homeNumber == null
//                           ? "N/A"
//                           : '${assimentList.homeNumber}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 10, left: 15, bottom: 10),
//                     child: Text(
//                       'Settlement',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15,bottom: 10),
//                     child: Text(
//                       assimentList.settlement == null
//                           ? "N/A"
//                           : '${assimentList.settlement}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
//             child: Card(
//               elevation: 5,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 15, bottom: 10, left: 15),
//                     child: Text(
//                       'Roof Damage',
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff16698C)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 10, left: 15),
//                     child: Text(
//                       'Eave Flashing length of damage',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(
//                       assimentList.eaveFlashingFeet == null
//                           ? "N/A"
//                           : '${assimentList.eaveFlashingFeet}, ${assimentList.eaveFlashingInches}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 10, left: 15),
//                     child: Text(
//                       'Eave Flashing Size',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(
//                       assimentList.eaveFlashingSize == null
//                           ? "N/A"
//                           : '${assimentList.eaveFlashingSize},',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10, left: 15),
//                     child: Text(
//                       'Fascia Board',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 15, top: 10, bottom: 10),
//                     child: Text(
//                       assimentList.fasciaBoardFeet == null
//                           ? "N/A"
//                           : '${assimentList.fasciaBoardFeet},${assimentList.fasciaBoardInches} ',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10, left: 15),
//                     child: Text(
//                       'Fascia Board Size',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                     const EdgeInsets.only(left: 15, top: 10, bottom: 10),
//                     child: Text(
//                       assimentList.fasciaBoardSizeInchesOne == null
//                           ? "N/A"
//                           : '${assimentList.fasciaBoardSizeInchesOne},${assimentList.fasciaBoardSizeInchesTwo} ',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 10, left: 15),
//                     child: Text(
//                       'Soffit & Type ',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15, bottom: 10),
//                     child: Text(
//                       'Ft ${assimentList.soffitHeightFeet}, In ${assimentList.soffitHeightInches}, Ft ${assimentList.soffitWidthFeet}, In ${assimentList.soffitWidthInches}, & ${assimentList.soffitType}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 10, left: 15),
//                     child: Text(
//                       'Shingles & Type',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(
//                       'Ft ${assimentList.shinglesHeightFeet}, In ${assimentList.shinglesHeightInches}, Ft ${assimentList.shinglesWidthFeet}, In ${assimentList.soffitWidthInches}, & ${assimentList.shingleStyle}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 10, left: 15, bottom: 10),
//                     child: Text(
//                       'Plywood',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(
//                       'Ft ${assimentList.plywoodHeightFeet}, In ${assimentList.plywoodHeightInches}, Ft ${assimentList.plywoodWidthFeet}, In ${assimentList.plywoodWidthInches},',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 10, left: 15, bottom: 10),
//                     child: Text(
//                       'Ice & Water Shield',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15, bottom: 10),
//                     child: Text(
//                       'Ft ${assimentList.iceAndWaterShieldHeightFeet}, In ${assimentList.iceAndWaterShieldHeightInches}, Ft ${assimentList.iceAndWaterShieldWidthFeet}, In ${assimentList.iceAndWaterShieldWidthInches},',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
//             child: Card(
//               elevation: 5,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 15, bottom: 10, left: 15),
//                     child: Text(
//                       'Windows',
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff16698C)),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 5, left: 15, right: 15),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: Wrap(
//                         spacing: 15,
//                         alignment: WrapAlignment.spaceAround,
//                         runSpacing: 15.0,
//                         children: [
//                           Column(
//                             children: [
//                               Text(
//                                 'Window Style',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.windowStyle}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 'Colonial Style',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.colonialStyle}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 'Quantity',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.quantity}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 'Size',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 'Ft ${assimentList.sizeHeightFeet}, In ${assimentList.sizeHeightInches}, Ft ${assimentList.sizeWidthFeet}, In ${assimentList.sizeWidthInches}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 'Type',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.type}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 10, left: 15, right: 30),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                       ],
//                     ),
//                   ),
//                   Divider(
//                     height: 5,
//                     color: Color(0xffF2F2F2),
//                     thickness: 2,
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 10, left: 15, right: 15),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: Wrap(
//                         spacing: 15,
//                         alignment: WrapAlignment.spaceAround,
//                         runSpacing: 15.0,
//                         children: [
//                           Column(
//                             children: [
//                               Text(
//                                 'Window Style One',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.windowStyleOne}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 'Colonial Style One',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.colonialStyleOne}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 8.0),
//                                 child: Text(
//                                   'Quantity One',
//                                   style: TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w500,
//                                       fontFamily: 'San Francisco',
//                                       color: Color(0xff808B9E)),
//                                 ),
//                               ),
//                               Text(
//                                 '${assimentList.quantityOne}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 'Size One',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 'Ft ${assimentList.sizeHeightFeetOne}, In ${assimentList.sizeHeightInchesOne}, Ft ${assimentList.sizeWidthFeetOne}, In ${assimentList.sizeWidthInchesOne}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 'Type one',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.typeOne}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Divider(
//                     height: 5,
//                     color: Color(0xffF2F2F2),
//                     thickness: 2,
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 10, left: 15, right: 15),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: Wrap(
//                         spacing: 15,
//                         alignment: WrapAlignment.spaceAround,
//                         runSpacing: 15.0,
//                         children: [
//                           Column(
//                             children: [
//                               Text(
//                                 'Window Style Two',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.windowStyleTwo}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 'Colonial Style Two',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.colonialStyleTwo}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 8.0),
//                                 child: Text(
//                                   'Quantity Two',
//                                   style: TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w500,
//                                       fontFamily: 'San Francisco',
//                                       color: Color(0xff808B9E)),
//                                 ),
//                               ),
//                               Text(
//                                 '${assimentList.quantityTwo}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 25.0),
//                                 child: Text(
//                                   'Size Two',
//                                   style: TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w500,
//                                       fontFamily: 'San Francisco',
//                                       color: Color(0xff808B9E)),
//                                 ),
//                               ),
//                               Text(
//                                 'Ft ${assimentList.sizeHeightFeetTwo}, In ${assimentList.sizeHeightInchesTwo}, Ft ${assimentList.sizeWidthFeetTwo}, In ${assimentList.sizeWidthInchesTwo}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 'Type two',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.typeTwo}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
//             child: Card(
//               elevation: 5,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 15, bottom: 10, left: 15),
//                     child: Text(
//                       'Doors',
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff16698C)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0,right: 10),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: Wrap(
//                         alignment: WrapAlignment.spaceBetween,
//                         spacing: 20,
//                         runSpacing: 20,
//                         children: [
//                           Column(crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Door Type',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.doorType}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//
//                           Column(
//                             children: [
//                               Text(
//                                 'Quantity',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.doorQuantity}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           SizedBox(width: 20,),
//
//                           Column(
//                             children: [
//                               Text(
//                                 'Size',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 'Ft ${assimentList.doorSizeHeightFeet}, In ${assimentList.doorSizeHeightInches}, Ft ${assimentList.doorSizeWidthFeet}, In ${assimentList.doorSizeWidthInches}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Location',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//
//                               Text(
//                                 '${assimentList.location}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Orientation',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.orientation}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 'Meterial',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.meterial}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Divider(
//                     height: 5,
//                     color: Color(0xffF2F2F2),
//                     thickness: 2,
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 10, left: 10),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: Wrap(
//                         alignment: WrapAlignment.spaceAround,
//                         runSpacing: 5.0,
//                         spacing: 15,
//                         children: [
//                           Column(crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Door Type One',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.doorTypeOne}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           SizedBox(width: 18,),
//                           Column(crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Quantity One',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.doorQuantityOne}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           SizedBox(width: 20,),
//                           Column(crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Size One',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 'Ft ${assimentList.doorSizeHeightFeetOne}, In ${assimentList.doorSizeHeightInchesOne}, Ft ${assimentList.doorSizeWidthFeetOne}, In ${assimentList.doorSizeWidthInchesOne}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'LocationOne',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.locationOne}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'OrientationOne',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.orientationOne}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'MeterialOne',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.meterialOne}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Divider(
//                     height: 5,
//                     color: Color(0xffF2F2F2),
//                     thickness: 2,
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 10, left: 10),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: Wrap(
//                         alignment: WrapAlignment.spaceAround,
//                         spacing: 15,
//                         runSpacing: 5.0,
//                         children: [
//                           Column(crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Door type Two',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.doorTypeTwo}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           SizedBox(width: 20,),
//                           Column(crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Quantity Two',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.doorQuantityTwo}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           SizedBox(width: 20,),
//                           Column(crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Size Two',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 'Ft ${assimentList.doorSizeHeightFeetTwo}, In ${assimentList.doorSizeHeightInchesTwo}, Ft ${assimentList.doorSizeWidthFeetTwo}, In ${assimentList.doorSizeWidthInchesTwo}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Locationtwo',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.locationTwo}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Orientationtwo',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.orientationTwo}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                           Column(crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Meterialtwo',
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff808B9E)),
//                               ),
//                               Text(
//                                 '${assimentList.meterialTwo}',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: 'San Francisco',
//                                     color: Color(0xff000000)),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
//             child: Card(
//               elevation: 5,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 15, bottom: 10, left: 15),
//                     child: Text(
//                       'Electrical',
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff16698C)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 10, left: 15),
//                     child: Text(
//                       'Service Entrance',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(
//                       '${assimentList.serviceEntrance}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10, left: 15),
//                     child: Text(
//                       'Service Pole',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 15, top: 10, bottom: 10),
//                     child: Text(
//                       '${assimentList.servicePole}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 10, left: 15, right: 30),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Meter Can Size',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff808B9E)),
//                         ),
//                         Text(
//                           'Meter Switch Size',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff808B9E)),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 10, left: 15, right: 70),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '${assimentList.meterCanSize}',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff131313)),
//                         ),
//                         Text(
//                           '${assimentList.meterSwitchSize}',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff131313)),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 10, left: 15, right: 30),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Interior Flooding',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff808B9E)),
//                         ),
//                         Text(
//                           'Flooding Height',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff808B9E)),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 10, left: 15, right: 50),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '${assimentList.interiorFlooding}',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff131313)),
//                         ),
//                         Text(
//                           'Ft ${assimentList.floodingHeightFeet} In ${assimentList.floodingHeightInches}',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff131313)),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
//             child: Card(
//               elevation: 5,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 15, bottom: 10, left: 15),
//                     child: Text(
//                       'Grounding System',
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff16698C)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 10, left: 15),
//                     child: Text(
//                       'Ground Rod',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(
//                       '${assimentList.groundRod}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10, left: 15),
//                     child: Text(
//                       'Ground Clamp',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 15, top: 10, bottom: 10),
//                     child: Text(
//                       '${assimentList.groundClamp}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(
//                       'Ground Wire',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 15, top: 10, bottom: 10),
//                     child: Text(
//                       '${assimentList.groundWire}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
//             child: Card(
//               elevation: 5,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 15, bottom: 10, left: 15),
//                     child: Text(
//                       'Plumbing',
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff16698C)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 10, left: 15),
//                     child: Text(
//                       'Water Supply',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(
//                       '${assimentList.waterSupply}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 10, left: 15, bottom: 10),
//                     child: Text(
//                       'Water Closet and (Toilet only)',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff808B9E)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: Text(
//                       '${assimentList.waterCloset}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'San Francisco',
//                           color: Color(0xff131313)),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         bottom: 10, left: 15, right: 30, top: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '1/2" Service Pipe',
//                           style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff808B9E)),
//                         ),
//                         Text(
//                           'Length of damage',
//                           style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff808B9E)),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 10, left: 15, right: 50),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '${assimentList.s12ServicePipe}',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff000000)),
//                         ),
//                         Text(
//                           'Ft ${assimentList.lengthOfDamageFeet}, In ${assimentList.lengthOfDamageInches}',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff000000)),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       bottom: 10,
//                       left: 15,
//                       right: 30,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '3/4" Service Pipe',
//                           style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff808B9E)),
//                         ),
//                         Text(
//                           'Length of damage',
//                           style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff808B9E)),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 10, right: 50, left: 15),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '${assimentList.s34ServicePipe}',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff000000)),
//                         ),
//                         Text(
//                           'Ft ${assimentList.lengthOfDamageFeetOne}, In ${assimentList.lengthOfDamageInchesOne}',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff000000)),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       bottom: 10,
//                       left: 15,
//                       right: 30,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '1" Service Pipe',
//                           style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff808B9E)),
//                         ),
//                         Text(
//                           'Length of damage',
//                           style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff808B9E)),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 10, left: 15, right: 50),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '${assimentList.s1ServicePipe}',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff000000)),
//                         ),
//                         Text(
//                           'Ft ${assimentList.lengthOfDamageFeetTwo}, In ${assimentList.lengthOfDamageInchesTwo}',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'San Francisco',
//                               color: Color(0xff000000)),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
//             child: Card(
//                 elevation: 5,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(top: 15, bottom: 10, left: 15),
//                       child: Text(
//                         'Comments',
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             fontFamily: 'San Francisco',
//                             color: Color(0xff16698C)),
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(top: 10, bottom: 10, left: 15),
//                       child: Text(
//                         '${assimentList.additionalComment}',
//                         style: TextStyle(
//                             fontSize: 10,
//                             //fontWeight: FontWeight.w500,
//                             fontFamily: 'San Francisco',
//                             color: Color(0xff16698C)),
//                       ),
//                     ),
//                   ],
//                 )),
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
//             child: Card(
//                 elevation: 5,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(top: 15, bottom: 10, left: 15),
//                       child: Text(
//                         'Images',
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             fontFamily: 'San Francisco',
//                             color: Color(0xff16698C)),
//                       ),
//                     ),
//
//                     Column(crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         ...assimentList.damageSnaps!.map((item) {
//                           return   Padding(
//                             padding:
//                                 const EdgeInsets.only(top: 10, bottom: 10, left: 15),
//                             child: Container(
//                               child: Image.network(
//                                 "${item}",
//                                 fit: BoxFit.fill,
//                                 height: 150,
//                                 width: 150,
//                                 loadingBuilder: (BuildContext context, Widget child,
//                                     ImageChunkEvent? loadingProgress) {
//                                   if (loadingProgress == null) return child;
//                                   return Center(
//                                     child: CircularProgressIndicator(
//                                       value: loadingProgress.expectedTotalBytes != null
//                                           ? loadingProgress.cumulativeBytesLoaded /
//                                               loadingProgress.expectedTotalBytes!
//                                           : null,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ],
//                     )
//                   ],
//                 )),
//           ),
//         ),
//       ],
//     );
//   }
// }
