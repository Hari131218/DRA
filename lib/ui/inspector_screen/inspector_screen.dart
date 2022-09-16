// import 'dart:typed_data';
//
// import 'package:circle_button/circle_button.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// HandSignatureControl control = new HandSignatureControl(
//   threshold: 0.01,
//   smoothRatio: 0.65,
//   velocityRange: 2.0,
// );
//
// ValueNotifier<String?> svg = ValueNotifier<String?>(null);
//
// ValueNotifier<ByteData?> rawImage = ValueNotifier<ByteData?>(null);
//
// ValueNotifier<ByteData?> rawImageFit = ValueNotifier<ByteData?>(null);
//
// class Inspector extends StatelessWidget {
//   bool get scrollTest => false;
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         body: scrollTest
//             ? ScrollTest()
//             : SafeArea(
//                 child: Stack(
//                   children: <Widget>[
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Text(
//                             'Add Signature',
//                             style: TextStyle(color: Color(0xff16698C),fontWeight: FontWeight.w600,fontSize: 14,fontFamily: 'San Francisco'),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             CircleButton(
//                               onTap: () => {},
//                               width: 25.0,
//                               height: 25.0,
//                               borderColor: Colors.white,
//                               borderWidth: 1.0,
//                               borderStyle: BorderStyle.solid,
//                               backgroundColor: Color(0xffF2F2F2),
//                               child: IconButton(
//                                   onPressed: () {
//                                     control.clear();
//                                     svg.value = null;
//                                     rawImage.value = null;
//                                     rawImageFit.value = null;
//                                   },
//                                   icon: Icon(
//                                     Icons.delete_outline,
//                                     color: Color(0xff808B9E),
//                                     size: 8,
//
//                                   )),
//                             ),
//                             Text(
//                               'Please Sign Here',
//                               style:
//                               TextStyle(fontSize: 12, color: Color(0xff808B9E),fontFamily: 'San Francisco'),
//                             ),
//                             CircleButton(
//                               onTap: () => {},
//                               width: 25.0,
//                               height: 25.0,
//                               borderColor: Color(0xff12AFC0),
//                               borderWidth: 1.0,
//                               borderStyle: BorderStyle.solid,
//                               backgroundColor: Colors.black,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: <Widget>[
//                         Expanded(
//                           child: Center(
//                             child: AspectRatio(
//                               aspectRatio: 1.5,
//                               child: Stack(
//                                 children: <Widget>[
//                                   Container(
//                                     constraints: BoxConstraints.expand(),
//                                     color: Colors.white54,
//                                     child: HandSignature(
//                                       control: control,
//                                       type: SignatureDrawType.shape,
//                                     ),
//                                   ),
//                                   CustomPaint(
//                                     painter: DebugSignaturePainterCP(
//                                       control: control,
//                                       cp: false,
//                                       cpStart: false,
//                                       cpEnd: false,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               ElevatedButton(
//                                 onPressed: () {
//                                   control.clear();
//                                   svg.value = null;
//                                   rawImage.value = null;
//                                   rawImageFit.value = null;
//                                 },
//                                 child: Text('CANCEL',style: TextStyle(fontFamily: 'San Francisco',fontWeight: FontWeight.w600),),
//                                 style: ElevatedButton.styleFrom(
//                                     primary: Color(0xffD45128),
//                                     fixedSize: Size(165, 46)),
//                               ),
//                               ElevatedButton(
//                                 onPressed: () async {
//                                   svg.value = control.toSvg(
//                                     color: Colors.blueGrey,
//                                     size: Size(512, 256),
//                                     strokeWidth: 2.0,
//                                     maxStrokeWidth: 15.0,
//                                     type: SignatureDrawType.shape,
//                                   );
//
//                                   rawImage.value = await control.toImage(
//                                     color: Colors.blueAccent,
//                                     background: Colors.greenAccent,
//                                     fit: false,
//                                   );
//
//                                   rawImageFit.value = await control.toImage(
//                                     color: Colors.blueAccent,
//                                     background: Colors.greenAccent,
//                                   );
//                                 },
//                                 child: Text('SUBMIT',style: TextStyle(fontFamily: 'San Francisco',fontWeight: FontWeight.w600),),
//                                 style: ElevatedButton.styleFrom(
//                                     primary: Color(0xff12AFC0),
//                                     fixedSize: Size(165, 46)),
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 16.0,
//                         ),
//                       ],
//                     ),
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                         //  _buildImageView(),
//                          // _buildScaledImageView(),
//                           _buildSvgView(),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
//
//   //
//   // Widget _buildImageView() => Container(
//   //       width: 192.0,
//   //       height: 96.0,
//   //       decoration: BoxDecoration(
//   //         border: Border.all(),
//   //         color: Colors.white30,
//   //       ),
//   //       child: ValueListenableBuilder<ByteData?>(
//   //         valueListenable: rawImage,
//   //         builder: (context, data, child) {
//   //           if (data == null) {
//   //             return Container(
//   //               color: Colors.red,
//   //               child: Center(
//   //                 child: Text('not signed yet (png)\nscaleToFill: false'),
//   //               ),
//   //             );
//   //           } else {
//   //             return Padding(
//   //               padding: EdgeInsets.all(8.0),
//   //               child: Image.memory(data.buffer.asUint8List()),
//   //             );
//   //           }
//   //         },
//   //       ),
//   //     );
//   //
//   // Widget _buildScaledImageView() => Container(
//   //       width: 192.0,
//   //       height: 96.0,
//   //       decoration: BoxDecoration(
//   //         border: Border.all(),
//   //         color: Colors.white30,
//   //       ),
//   //       child: ValueListenableBuilder<ByteData?>(
//   //         valueListenable: rawImageFit,
//   //         builder: (context, data, child) {
//   //           if (data == null) {
//   //             return Container(
//   //               color: Colors.red,
//   //               child: Center(
//   //                 child: Text('not signed yet (png)\nscaleToFill: true'),
//   //               ),
//   //             );
//   //           } else {
//   //             return Padding(
//   //               padding: EdgeInsets.all(8.0),
//   //               child: Image.memory(data.buffer.asUint8List()),
//   //             );
//   //           }
//   //         },
//   //       ),
//   //     );
//
//   Widget _buildSvgView() => Container(
//         width: 192.0,
//         height: 96.0,
//         decoration: BoxDecoration(
//           border: Border.all(),
//           color: Colors.white30,
//         ),
//         child: ValueListenableBuilder<String?>(
//           valueListenable: svg,
//           builder: (context, data, child) {
//             return HandSignatureView.svg(
//               data: data,
//               padding: EdgeInsets.all(8.0),
//               placeholder: Container(
//                 color: Colors.red,
//                 child: Center(
//                   child: Text('not signed yet (svg)'),
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//
//   ScrollTest() {}
// }

