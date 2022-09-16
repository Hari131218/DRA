// import 'dart:io';
//
// import 'package:app_settings/app_settings.dart';
// import 'package:dra_project/screens/screens.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:geolocator/geolocator.dart' as geo;
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:location/location.dart';
// import 'package:lottie/lottie.dart';
//
// import '../common/app_constants.dart';
//
// class AddPhoto extends StatefulWidget {
//   const AddPhoto(
//       {Key? key,
//       required this.tabController,
//       required this.strIds,
//       this.tabonTab})
//       : super(key: key);
//
//   final TabController tabController;
//   final String strIds;
//   final Function? tabonTab;
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _AddPhoto();
//   }
// }
//
// class _AddPhoto extends State<AddPhoto> {
//   XFile? imageFile = null;
//   List<XFile> imageFilelist = [];
//
//   bool isLoading = false;
//
//   List<String> imageStrList = [];
//
//   List<String> imagesize = [];
//
//   late geo.Position position;
//   late Location location;
//   late bool _serviceEnabled;
//   dynamic _lat;
//   dynamic _lon;
//
//   late PermissionStatus _permissionGranted;
//
//   Future<void> _showChoiceDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text(
//               "Choose option",
//               style: const TextStyle(color: Colors.blue),
//             ),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: [
//                   const Divider(
//                     height: 1,
//                     color: Colors.blue,
//                   ),
//                   ListTile(
//                     onTap: () {
//                       imageSelector(context, "gallery");
//                       Navigator.pop(context);
//                       // _openGallery(context);
//                     },
//                     title: const Text("Gallery"),
//                     leading: const Icon(
//                       Icons.account_box,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   const Divider(
//                     height: 1,
//                     color: Colors.blue,
//                   ),
//                   ListTile(
//                     onTap: () {
//                       //   _openCamera(context);
//                       imageSelector(context, "camera");
//                       Navigator.pop(context);
//                     },
//                     title: const Text("Camera"),
//                     leading: const Icon(
//                       Icons.camera,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _locateMe();
//     location.getLocation().then((value) =>
//         {print("Latitude - ${value.latitude} Longitude - ${value.longitude}")});
//   }
//
//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isLoading == true
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : Center(
//               child: Container(
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                       //  width: MediaQuery.of(context).size.width * 0.35,
//                       //   height: MediaQuery.of(context).size.height * 0.2,
//                       margin: const EdgeInsets.only(top: 10),
//                       child: imageStrList.isNotEmpty
//                           ? Container(
//                               height: MediaQuery.of(context).size.height * 0.5,
//                               child: ListView.builder(
//                                   itemCount: imageStrList.length,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return ListTile(
//                                         leading: Container(
//                                             width: 50,
//                                             height: 50,
//                                             child: Image.file(
//                                               File(imageStrList[index]),
//                                               height: 100,
//                                               width: 100,
//                                               fit: BoxFit.fill,
//                                             )),
//                                         trailing: IconButton(
//                                           icon: Image.asset(
//                                               'assets/images/imageclose.png'),
//                                           onPressed: () {
//                                             setState(() {
//                                               imageStrList.removeAt(index);
//                                             });
//                                           },
//                                         ),
//                                         title: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               File(imageStrList[index])
//                                                   .path
//                                                   .split('/')
//                                                   .last,
//                                               style:
//                                                   const TextStyle(fontSize: 15),
//                                             ),
//                                             Text(imagesize[index],
//                                                 style: const TextStyle(
//                                                     color: Colors.blue,
//                                                     fontSize: 10))
//                                           ],
//                                         )
//                                         // RichText(
//                                         //   text: TextSpan(
//                                         //     style: TextStyle(color: Colors.black, fontSize: 14),
//                                         //     children: <TextSpan>[
//                                         //       TextSpan(text: File(imageStrList[index])
//                                         //                   .path
//                                         //                   .split('/')
//                                         //                   .last, ),
//                                         //       TextSpan(text:  imagesize[index], style: TextStyle(color: Colors.blue))
//                                         //     ],
//                                         //   ),
//                                         // )
//                                         // Text(File(imageStrList[index])
//                                         //         .path
//                                         //         .split('/')
//                                         //         .last +
//                                         //     ' ' +
//                                         //     imagesize[index]),
//                                         );
//                                   }),
//                             )
//                           : Lottie.asset('assets/images/noimage.json')),
//                   imageStrList.isEmpty
//                       ? const Text(
//                           "No Images",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w600),
//                         )
//                       : const Text(""),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   imageStrList.isEmpty == null
//                       ? const Text(
//                           "There are no images captured. \n Please take a photo to view",
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                               color: Color(0xff808B9E),
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500),
//                         )
//                       : const Text(""),
//                   const SizedBox(
//                     height: 10.0,
//                   ),
//                   Container(
//                       height: 45,
//                       padding: const EdgeInsets.only(left: 10, right: 10),
//                       child: RaisedButton(
//                           color: Colors.white,
//                           onPressed: () {
//                             _showChoiceDialog(context);
//                             // _settingModalBottomSheet(context);
//                           },
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               side: const BorderSide(
//                                   color: Color(0xff16698C), width: 1)),
//                           child: const Text("+Add/Take Picture"))),
//                 ],
//               ),
//             )),
//       bottomNavigationBar: Container(
//         child: Row(
//           children: [
//             Expanded(
//               child: FlatButton(
//                 height: 40,
//                 color: const Color(0xffD45128),
//                 textColor: Colors.white,
//                 onPressed: () {
//                   widget.tabonTab!(list: [true, false, true]);
//                   widget.tabController.animateTo(1);
//                 },
//                 child: const Text('PREVIOUS',
//                     style: const TextStyle(
//                         fontFamily: 'San Francisco',
//                         fontWeight: FontWeight.w600)),
//                 // style: ElevatedButton.styleFrom(
//                 //     primary: Color(0xff12AFC0), fixedSize: Size(100, 46)),
//               ),
//             ),
//             Expanded(
//               child: FlatButton(
//                 height: 40,
//                 color: const Color(0xff12AFC0),
//                 textColor: Colors.white,
//                 onPressed: () {
//                   // widget.tabController.animateTo(2);
//
//                   //  File _file = new File(imageStrList[0]);
//                   print("ABCD");
//
//                   if (imageStrList.isNotEmpty) {
//                     _upload();
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: const Text("Please add images"),
//                       backgroundColor: Colors.red.shade300,
//                     ));
//                   }
//                 },
//                 child: const Text('SUBMIT',
//                     style: TextStyle(
//                         fontFamily: 'San Francisco',
//                         fontWeight: FontWeight.w600)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   _locateMe() async {
//     location = Location();
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               // return object of type Dialog
//               return AlertDialog(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(22)),
//                 title: new Text("Access Location"),
//                 content: new Text("Please make sure you enable GPS"),
//                 actions: <Widget>[
//                   new FlatButton(
//                     child: new Text("Ok"),
//                     onPressed: () {
//                       print('hello');
//                       // final AndroidIntent intent = AndroidIntent(
//                       //     action: 'android.settings.LOCATION_SOURCE_SETTINGS');
//                       // intent.launch();
//                       Navigator.of(context, rootNavigator: true).pop();
//                       AppSettings.openLocationSettings();
//                       //AppSettings.openLocationSettings();
//                       _locateMe();
//                     },
//                   ),
//                 ],
//               );
//             });
//         // AppSettings.openLocationSettings();
//
//         return;
//       }
//     } else {
//       print("------------------------here"); //Output: 80.24599079
//
//       _permissionGranted = await location.hasPermission();
//       if (_permissionGranted == PermissionStatus.denied) {
//         print("------------------------denied");
//         _permissionGranted = await location.requestPermission();
//         if (_permissionGranted != PermissionStatus.granted) {
//           print("------------------------granded");
//           position = await geo.Geolocator.getCurrentPosition(
//               desiredAccuracy: geo.LocationAccuracy.high);
//           setState(() {
//             _lat = position.latitude;
//             _lon = position.longitude;
//           });
//           /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text("${position.longitude}  ${position.latitude}")));*/
//           print(position.longitude); //Output: 80.24599079
//           print(position.latitude); //Output: 29.6593457
//
//           return;
//         }
//       } else {
//         print("------------------------granded");
//         position = await geo.Geolocator.getCurrentPosition(
//             desiredAccuracy: geo.LocationAccuracy.high);
//         setState(() {
//           _lat = position.latitude;
//           _lon = position.longitude;
//         });
//         /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text("${position.longitude}  ${position.latitude}")));*/
//         print(position.longitude); //Output: 80.24599079
//         print(position.latitude); //Output: 29.6593457
//       }
//     }
//   }
//
//   void _upload() async {
//     List<http.MultipartFile> newList = [];
//
//     setState(() {
//       isLoading = true;
//     });
//
//     var kyc = Uri.parse("${BASE_URL}assessments/store/1");
//     var request = new http.MultipartRequest("POST", kyc);
//     // request.headers.addAll(headers);
//
//     request.fields['step'] = "4";
//     request.fields['form_type'] = "create";
//     request.fields['request_id'] = "${widget.strIds}";
//     request.fields['latitude'] = "${_lat}";
//     request.fields['longitude'] = "${_lon}";
//
//     for (int i = 0; i < imageStrList.length; i++) {
//       // if (img != "") {
//       var multipartFile = await http.MultipartFile.fromPath(
//         'damage-snaps[$i]',
//         File(imageStrList[i]).path,
//         filename: imageStrList[i].split('/').last,
//       );
//       newList.add(multipartFile);
//       // }
//     }
//     request.files.addAll(newList);
//     await request.send().then((value) {
//       if (value.statusCode == 200) {
//         setState(() {
//           isLoading = false;
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text("Assessment Form stored Successfully"),
//           backgroundColor: Colors.green,
//         ));
//
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const MyHomePage(
//                       accesstoken: '',
//                     )));
//
//         print("asadasdsadasdadsasdasd");
//       }
//     });
//   }
//
//   //********************** IMAGE PICKER
//   Future imageSelector(BuildContext context, String pickerType) async {
//     switch (pickerType) {
//       case "gallery":
//
//         /// GALLERY IMAGE PICKER
//         imageFilelist =
//             await ImagePicker().pickMultiImage(imageQuality: 60) ?? [];
//         break;
//
//       case "camera": // CAMERA CAPTURE CODE
//         imageFile = await ImagePicker()
//             .pickImage(source: ImageSource.camera, imageQuality: 60);
//         break;
//     }
//     if (imageFilelist.isNotEmpty && imageFile == null) {
//       for (var item in imageFilelist) {
//         imageStrList.add(item.path);
//         final sizeOfImage = File(item.path).lengthSync();
//         final kb = sizeOfImage / 1024;
//         final mb = kb / 1024;
//         print(sizeOfImage.toString() +
//             'kljdslfsf' +
//             kb.toString() +
//             'uijijij' +
//             mb.toString());
//         final size = (mb >= 1)
//             ? '${mb.toStringAsFixed(2)} MB'
//             : '${kb.toStringAsFixed(2)} KB';
//         imagesize.add((size));
//       }
//     }
//     setState(() {});
//     if (imageFile != null) {
//       print("You selected  image : " + imageFile!.path);
//       final sizeOfImage = File(imageFile!.path).lengthSync();
//
//       final kb = sizeOfImage / 1024;
//       final mb = kb / 1024;
//       final size = (mb >= 1)
//           ? '${mb.toStringAsFixed(2)} MB'
//           : '${kb.toStringAsFixed(2)} KB';
//       imagesize.add((size));
//
//       imageStrList.add(imageFile!.path);
//
//       print("LLLLLLLLLLLLLL $imageStrList");
//
//       setState(() {
//         debugPrint("SELECTED IMAGE PICK   $imageFile");
//         imageFile = null;
//       });
//     } else {
//       print("You have not taken image");
//     }
//   }
// }
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:dra_project/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';

import '../common/app_constants.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto(
      {Key? key,
      required this.tabController,
      required this.strIds,
      this.tabonTab})
      : super(key: key);

  final TabController tabController;
  final String strIds;
  final Function? tabonTab;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddPhoto();
  }
}

class _AddPhoto extends State<AddPhoto> {
  XFile? imageFile = null;
  List<XFile> imageFilelist = [];

  bool isLoading = false;

  List<String> imageStrList = [];

  List<String> imagesize = [];

  late geo.Position position;
  late Location location;
  late bool _serviceEnabled;
  dynamic _lat;
  dynamic _lon;

  late PermissionStatus _permissionGranted;

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: const TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      imageSelector(context, "gallery");
                      Navigator.pop(context);
                      // _openGallery(context);
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      //   _openCamera(context);
                      imageSelector(context, "camera");
                      Navigator.pop(context);
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _locateMe();
    location.getLocation().then((value) =>
        {print("Latitude - ${value.latitude} Longitude - ${value.longitude}")});
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Container(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      //  width: MediaQuery.of(context).size.width * 0.35,
                      //   height: MediaQuery.of(context).size.height * 0.2,
                      margin: const EdgeInsets.only(top: 10),
                      child: imageStrList.isNotEmpty
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: ListView.builder(
                                  itemCount: imageStrList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                        leading: Container(
                                            width: 50,
                                            height: 50,
                                            child: Image.file(
                                              File(imageStrList[index]),
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.fill,
                                            )),
                                        trailing: IconButton(
                                          icon: Image.asset(
                                              'assets/images/imageclose.png'),
                                          onPressed: () {
                                            setState(() {
                                              imageStrList.removeAt(index);
                                            });
                                          },
                                        ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              File(imageStrList[index])
                                                  .path
                                                  .split('/')
                                                  .last,
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                            Text(imagesize[index],
                                                style: const TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 10))
                                          ],
                                        )
                                        // RichText(
                                        //   text: TextSpan(
                                        //     style: TextStyle(color: Colors.black, fontSize: 14),
                                        //     children: <TextSpan>[
                                        //       TextSpan(text: File(imageStrList[index])
                                        //                   .path
                                        //                   .split('/')
                                        //                   .last, ),
                                        //       TextSpan(text:  imagesize[index], style: TextStyle(color: Colors.blue))
                                        //     ],
                                        //   ),
                                        // )
                                        // Text(File(imageStrList[index])
                                        //         .path
                                        //         .split('/')
                                        //         .last +
                                        //     ' ' +
                                        //     imagesize[index]),
                                        );
                                  }),
                            )
                          : Lottie.asset('assets/images/noimage.json')),
                  imageStrList.isEmpty
                      ? const Text(
                          "No Images",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        )
                      : const Text(""),
                  const SizedBox(
                    height: 10,
                  ),
                  imageStrList.isEmpty == null
                      ? const Text(
                          "There are no images captured. \n Please take a photo to view",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color(0xff808B9E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        )
                      : const Text(""),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      height: 45,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: RaisedButton(
                          color: Colors.white,
                          onPressed: () {
                            _showChoiceDialog(context);
                            // _settingModalBottomSheet(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(
                                  color: Color(0xff16698C), width: 1)),
                          child: const Text("+Add/Take Picture"))),
                ],
              ),
            )),
      bottomNavigationBar: Container(
        child: Row(
          children: [
            Expanded(
              child: FlatButton(
                height: 40,
                color: const Color(0xffD45128),
                textColor: Colors.white,
                onPressed: () {
                  widget.tabonTab!(list: [true, false, true]);
                  widget.tabController.animateTo(1);
                },
                child: const Text('PREVIOUS',
                    style: const TextStyle(
                        fontFamily: 'San Francisco',
                        fontWeight: FontWeight.w600)),
                // style: ElevatedButton.styleFrom(
                //     primary: Color(0xff12AFC0), fixedSize: Size(100, 46)),
              ),
            ),
            Expanded(
              child: FlatButton(
                height: 40,
                color: const Color(0xff12AFC0),
                textColor: Colors.white,
                onPressed: () {
                  // widget.tabController.animateTo(2);

                  //  File _file = new File(imageStrList[0]);
                  print("ABCD");

                  if (imageStrList.isNotEmpty) {
                    _upload();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text("Please add images"),
                      backgroundColor: Colors.red.shade300,
                    ));
                  }
                },
                child: const Text('SUBMIT',
                    style: TextStyle(
                        fontFamily: 'San Francisco',
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _locateMe() async {
    location = Location();

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                title: new Text("Access Location"),
                content: new Text("Please make sure you enable GPS"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Ok"),
                    onPressed: () {
                      print('hello');
                      // final AndroidIntent intent = AndroidIntent(
                      //     action: 'android.settings.LOCATION_SOURCE_SETTINGS');
                      // intent.launch();
                      Navigator.of(context, rootNavigator: true).pop();
                      AppSettings.openLocationSettings();
                      //AppSettings.openLocationSettings();
                      _locateMe();
                    },
                  ),
                ],
              );
            });
        // AppSettings.openLocationSettings();

        return;
      }
    } else {
      print("------------------------here"); //Output: 80.24599079

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        print("------------------------denied");
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print("------------------------granded");
          position = await geo.Geolocator.getCurrentPosition(
              desiredAccuracy: geo.LocationAccuracy.high);
          setState(() {
            _lat = position.latitude;
            _lon = position.longitude;
          });
          /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("${position.longitude}  ${position.latitude}")));*/
          print(position.longitude); //Output: 80.24599079
          print(position.latitude); //Output: 29.6593457

          return;
        }
      } else {
        print("------------------------granded");
        position = await geo.Geolocator.getCurrentPosition(
            desiredAccuracy: geo.LocationAccuracy.high);
        setState(() {
          _lat = position.latitude;
          _lon = position.longitude;
        });
        /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${position.longitude}  ${position.latitude}")));*/
        print(position.longitude); //Output: 80.24599079
        print(position.latitude); //Output: 29.6593457
      }
    }
  }

  void _upload() async {
    List<http.MultipartFile> newList = [];

    setState(() {
      isLoading = true;
    });

    var kyc = Uri.parse("${BASE_URL}assessments/store/1");
    var request = new http.MultipartRequest("POST", kyc);
    // request.headers.addAll(headers);

    request.fields['step'] = "4";
    request.fields['form_type'] = "create";
    request.fields['request_id'] = "${widget.strIds}";
    request.fields['latitude'] = "${_lat}";
    request.fields['longitude'] = "${_lon}";

    for (int i = 0; i < imageStrList.length; i++) {
      // if (img != "") {
      var multipartFile = await http.MultipartFile.fromPath(
        'damage-snaps[$i]',
        File(imageStrList[i]).path,
        filename: imageStrList[i].split('/').last,
      );
      newList.add(multipartFile);
      // }
    }
    request.files.addAll(newList);
    await request.send().then((value) {
      if (value.statusCode == 200) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Assessment Form Store Successfully"),
          backgroundColor: Colors.green,
        ));

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(
                      accesstoken: '',
                    )));

        print("asadasdsadasdadsasdasd");
      }
    });
  }

  //********************** IMAGE PICKER
  Future imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":

        /// GALLERY IMAGE PICKER
        imageFilelist =
            await ImagePicker().pickMultiImage(imageQuality: 60) ?? [];
        break;

      case "camera": // CAMERA CAPTURE CODE
        imageFile = await ImagePicker()
            .pickImage(source: ImageSource.camera, imageQuality: 60);
        break;
    }
    if (imageFilelist.isNotEmpty && imageFile == null) {
      for (var item in imageFilelist) {
        imageStrList.add(item.path);
        final sizeOfImage = File(item.path).lengthSync();
        final kb = sizeOfImage / 1024;
        final mb = kb / 1024;
        print(sizeOfImage.toString() +
            'kljdslfsf' +
            kb.toString() +
            'uijijij' +
            mb.toString());
        final size = (mb >= 1)
            ? '${mb.toStringAsFixed(2)} MB'
            : '${kb.toStringAsFixed(2)} KB';
        imagesize.add((size));
      }
      setState(() {});
    }

    if (imageFile != null) {
      print("You selected  image : " + imageFile!.path);
      final sizeOfImage = File(imageFile!.path).lengthSync();

      final kb = sizeOfImage / 1024;
      final mb = kb / 1024;
      final size = (mb >= 1)
          ? '${mb.toStringAsFixed(2)} MB'
          : '${kb.toStringAsFixed(2)} KB';
      imagesize.add((size));

      imageStrList.add(imageFile!.path);

      print("LLLLLLLLLLLLLL $imageStrList");

      setState(() {
        debugPrint("SELECTED IMAGE PICK   $imageFile");
        imageFile = null;
      });
    } else {
      print("You have not taken image");
    }
  }
}
