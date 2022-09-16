import 'dart:convert';
import 'dart:io';

import 'package:dra_project/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../common/app_constants.dart';
import '../db_helper/assesmentService.dart';
import '../models/AssesmentDataBaseModel.dart';

class AddPhotoDBScreen extends StatefulWidget {
  const AddPhotoDBScreen(
      {Key? key,
      required this.tabController,
      required this.strIds,
      this.tabonTab})
      : super(key: key);

  final TabController tabController;
  final String strIds;
  final Function? tabonTab;

  @override
  State<AddPhotoDBScreen> createState() {
    // TODO: implement createState
    return _AddPhotoDBScreenState();
  }
}

class _AddPhotoDBScreenState extends State<AddPhotoDBScreen> {
  XFile? imageFile = null;
  List<XFile> imageFilelist = [];

  bool isLoading = false;
  List<String> imagesize = [];

  List<String> imageStrList = [];
  List<AssesmentDataBaseModel> testList = <AssesmentDataBaseModel>[];
  var _userService = AssesmentService();
  bool _updateDB = false;

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      imageSelector(context, "gallery");
                      Navigator.pop(context);
                      // _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      //   _openCamera(context);
                      imageSelector(context, "camera");
                      Navigator.pop(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
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

  void _query(name) async {
    // String en = jsonEncode(items);
    // print("Encodeeeeeeeeee ${en}");
    //
    // List<dynamic> de = jsonDecode(en);
    //
    // print("Encodeeeeeeeeee ${de}");

    setState(() {
      isLoading = true;
    });

    final allRows = await _userService.findUser("$name");

    //  print("zxczxczxcxzczxcxzc $allRows");

    // carsByName.clear();
    allRows.forEach((row) {
      testList.add(AssesmentDataBaseModel.fromMap(row));

      print("asdasdsadsad ${row}");
    });

    if (allRows.toString() == "[]") {
      print("zxczxczxcxzczxcxzc $allRows");
    } else {
      print("fffffffffffffffff $allRows");
      print("1111111111111111111 ${testList[0].damageSnaps}");

      setState(() {
        _updateDB = true;
        isLoading = false;
      });

      if (testList[0].damageSnaps != "") {
        List<dynamic> deTypeList = jsonDecode(testList[0].damageSnaps!);

        print("Encodeeeeeeeeee ${deTypeList}");

        for (int ii = 0; ii < deTypeList.length; ii++) {
          setState(() {
            imageStrList.add(deTypeList[ii]);
          });
        }
      }

      print("Test        ${testList[0].type}");

      print("dfdafadfdaf ${testList[0].requestKey}");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    _query(widget.strIds);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? Center(
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
                      margin: EdgeInsets.only(top: 0),
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
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            Text(
                                                imagesize.length > index
                                                    ? imagesize[index]
                                                    : '',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 10))
                                          ],
                                        ));
                                  }),
                            )
                          : Lottie.asset('assets/images/noimage.json')),
                  imageStrList.isEmpty
                      ? Text(
                          "No Images",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        )
                      : Text(""),
                  SizedBox(
                    height: 5,
                  ),
                  imageStrList.isEmpty == null
                      ? Text(
                          "There are no images captured. \n Please take a photo to view",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xff808B9E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        )
                      : Text(""),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                      height: 45,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: RaisedButton(
                          color: Colors.white,
                          onPressed: () {
                            _showChoiceDialog(context);
                            // _settingModalBottomSheet(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                  color: Color(0xff16698C), width: 1)),
                          child: Text("+Add/Take Picture"))),
                ],
              ),
            )),
      //   body: Center(child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //         children: <Widget>[
      //           Container(
      //             width: MediaQuery.of(context).size.width * 0.35,
      //             height: MediaQuery.of(context).size.height * 0.2,
      //             margin: EdgeInsets.only(top: 20),
      //             child: imageFile != null
      //     ? Image.file((File(imageFile!.path)))
      //     :Lottie.asset('assets/images/noimage.json')
      // ),
      //
      //
      //           Text("No Images",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
      //           SizedBox(height: 10,),
      //           Text("There are no images captured. \nPlease take a photo to view",style: TextStyle(color: Color(0xff808B9E),fontSize: 12,fontWeight: FontWeight.w500),),
      //
      //           SizedBox(
      //             height: 10.0,
      //           ),
      //           RaisedButton(
      //               onPressed: () {
      //                 _showChoiceDialog(context);
      //                // _settingModalBottomSheet(context);
      //               },
      //               child: Text("+Add/Take Picture")),
      //           Spacer(),
      //           // Padding(
      //           //   padding: const EdgeInsets.all(16.0),
      //           //   child: Row(
      //           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           //     children: [
      //           //       Expanded(child: ElevatedButton(onPressed: (){}, child: Text('PREVIOUS',style: TextStyle(fontFamily: 'San Francisco',fontWeight: FontWeight.w600),),style: ElevatedButton.styleFrom(primary: Color(0xffD45128),fixedSize: Size(165, 46)),)),
      //           //       SizedBox(
      //           //         width: 14,
      //           //       ),
      //           //       Expanded(child: ElevatedButton(onPressed: (){}, child: Text('SUBMIT',style: TextStyle(fontFamily: 'San Francisco',fontWeight: FontWeight.w600)),style: ElevatedButton.styleFrom(primary: Color(0xff12AFC0),fixedSize: Size(165, 46)),))
      //           //     ],
      //           //   ),
      //           // ),
      //         ],
      //       )),

      bottomNavigationBar: Container(
        child: Row(
          children: [
            Expanded(
              child: FlatButton(
                height: 40,
                color: Color(0xffD45128),
                textColor: Colors.white,
                onPressed: () {
                  widget.tabonTab!(list: [true, false, true]);
                  widget.tabController.animateTo(1);
                },
                child: Text('PREVIOUS',
                    style: TextStyle(
                        fontFamily: 'San Francisco',
                        fontWeight: FontWeight.w600)),
                // style: ElevatedButton.styleFrom(
                //     primary: Color(0xff12AFC0), fixedSize: Size(100, 46)),
              ),
            ),
            Expanded(
              child: FlatButton(
                height: 40,
                color: Color(0xff12AFC0),
                textColor: Colors.white,
                onPressed: () {
                  // widget.tabController.animateTo(2);

                  //  File _file = new File(imageStrList[0]);
                  print("ABCD");

                  print("xxzczcxzcxzcxzcxzc $imageStrList");

                  valiationPage();

                  // if(imageStrList.isNotEmpty){
                  //   _upload();
                  // }else{
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     content: Text("Please add images"),
                  //     backgroundColor: Colors.red.shade300,
                  //   ));
                  //
                  // }
                },
                child: Text('SUBMIT',
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

  Future<void> valiationPage() async {
    // final isValid = _formKey.currentState!.validate();
    // if (!isValid) {
    //   //  Get.off(HomePage());
    //
    //   return;
    // }
    //
    // _formKey.currentState!.save();

    /* data={
      "step":"2",
      "eave-flashing-feet":"1",
      "eave-flashing-inches":"2",
      "fascia-board-feet":"4",
      "fascia-board-inches":"5",
      "soffit-height-feet":"2",
      "soffit-height-inches":"3",
      "soffit-width-feet":"3",
      "soffit-width-inches":"3",
      "soffit-type":"2",
    };*/

    String _enDamageList = jsonEncode(imageStrList);

    print("Encodeeeeeeeeee ${_enDamageList}");

    if (_updateDB == false) {
    } else {
      var user = AssesmentDataBaseModel();
      user.id = testList[0].id!;
      user.eaveFlashingFeet = testList[0].eaveFlashingFeet!;
      user.eaveFlashingInches = testList[0].eaveFlashingInches!;
      user.fasciaBoardFeet = testList[0].fasciaBoardFeet!;
      user.fasciaBoardInches = testList[0].fasciaBoardInches!;
      user.soffitHeightFeet = testList[0].soffitHeightFeet!;
      user.soffitHeightInches = testList[0].soffitHeightInches!;
      user.soffitWidthFeet = testList[0].soffitWidthFeet!;
      user.soffitWidthInches = testList[0].soffitWidthInches!;
      user.soffitType = testList[0].soffitType!;
      user.shinglesHeightFeet = testList[0].shinglesHeightFeet!;
      user.shinglesHeightInches = testList[0].shinglesHeightInches!;
      user.shinglesWidthFeet = testList[0].shinglesWidthFeet!;
      user.shinglesWidthInches = testList[0].shinglesWidthInches!;
      user.shingleStyle = testList[0].shingleStyle!;
      user.plywoodHeightFeet = testList[0].plywoodHeightFeet!;
      user.plywoodHeightInches = testList[0].plywoodHeightInches!;
      user.plywoodWidthFeet = testList[0].plywoodWidthFeet!;
      user.plywoodWidthInches = testList[0].plywoodWidthInches!;
      user.iceAndWaterShieldHeightFeet =
          testList[0].iceAndWaterShieldHeightFeet!;
      user.iceAndWaterShieldHeightInches =
          testList[0].iceAndWaterShieldHeightInches!;
      user.iceAndWaterShieldWidthFeet = testList[0].iceAndWaterShieldWidthFeet!;
      user.iceAndWaterShieldWidthInches =
          testList[0].iceAndWaterShieldWidthInches!;
      user.torchOnHeightFeet = testList[0].torchOnHeightFeet!;
      user.torchOnHeightInches = testList[0].torchOnHeightInches!;
      user.torchOnWidthFeet = testList[0].torchOnWidthFeet!;
      user.torchOnWidthInches = testList[0].torchOnWidthInches ?? "";
      user.toughGuardHeightFeet = testList[0].toughGuardHeightFeet!;
      user.toughGuardHeightInches = testList[0].toughGuardHeightInches!;
      user.toughGuardWidthFeet = testList[0].toughGuardWidthFeet!;
      user.toughGuardWidthInches = testList[0].toughGuardWidthInches!;

      user.quantity = testList[0].quantity!;
      user.sizeHeightFeet = testList[0].sizeHeightFeet!;
      user.sizeHeightInches = testList[0].sizeHeightInches!;
      user.sizeWidthFeet = testList[0].sizeWidthFeet!;
      user.sizeWidthInches = testList[0].sizeWidthInches!;
      user.type = testList[0].type!;

      user.quantityOne = testList[0].quantityOne!;
      user.sizeHeightFeetOne = testList[0].sizeHeightFeetOne!;
      user.sizeHeightInchesOne = testList[0].sizeHeightInchesOne!;
      user.sizeWidthFeetOne = testList[0].sizeWidthFeetOne!;
      user.sizeWidthInchesOne = testList[0].sizeWidthInchesOne!;
      user.typeOne = testList[0].typeOne!;
      user.windowStyleOne = testList[0].windowStyleOne!;

      user.quantityTwo = testList[0].quantityTwo!;
      user.windowStyleTwo = testList[0].windowStyleTwo!;
      user.sizeHeightFeetTwo = testList[0].sizeHeightFeetTwo!;
      user.sizeHeightInchesTwo = testList[0].sizeHeightInchesTwo!;
      user.sizeWidthFeetTwo = testList[0].sizeWidthFeetTwo!;
      user.sizeWidthInchesTwo = testList[0].sizeWidthInchesTwo!;
      user.typeTwo = testList[0].typeTwo!;

      // user.type = testList[0].type!;
      // user.windowStyle = testList[0].windowStyle!;
      // user.quantity = testList[0].quantity!;
      // user.sizeHeightFeet = testList[0].sizeHeightFeet!;
      // user.sizeHeightInches = testList[0].sizeHeightInches!;
      // user.sizeWidthFeet = testList[0].sizeWidthFeet!;
      // user.sizeWidthInches = testList[0].sizeWidthInches!;
      //
      // user.typeOne = testList[0].typeOne!;
      // user.windowStyleOne = testList[0].windowStyleOne!;
      // user.quantityOne = testList[0].quantityOne!;
      // user.sizeHeightFeetOne = testList[0].sizeHeightFeetOne!;
      // user.sizeHeightInchesOne = testList[0].sizeHeightInchesOne!;
      // user.sizeWidthFeetOne = testList[0].sizeWidthFeetOne!;
      // user.sizeWidthInchesOne = testList[0].sizeWidthInchesOne!;
      //
      // user.typeTwo = testList[0].typeTwo!;
      // user.windowStyleTwo = testList[0].windowStyleTwo!;
      // user.quantityTwo = testList[0].quantityTwo!;
      // user.sizeHeightFeetTwo = testList[0].sizeHeightFeetTwo!;
      // user.sizeHeightInchesTwo = testList[0].sizeHeightInchesTwo!;
      // user.sizeWidthFeetTwo = testList[0].sizeWidthFeetTwo!;
      // user.sizeWidthInchesTwo = testList[0].sizeWidthInchesTwo!;

      user.location = testList[0].location!;
      user.doorType = testList[0].doorType!;
      user.material = testList[0].material!;
      user.orientation = testList[0].orientation!;
      user.doorQuantity = testList[0].doorQuantity!;
      user.doorSizeHeightFeet = testList[0].doorSizeHeightFeet!;
      user.doorSizeHeightInches = testList[0].doorSizeHeightInches!;
      user.doorSizeWidthFeet = testList[0].doorSizeWidthFeet!;
      user.doorSizeWidthInches = testList[0].doorSizeWidthInches!;

      user.locationOne = testList[0].locationOne!;
      user.doorTypeOne = testList[0].doorTypeOne!;
      user.materialOne = testList[0].materialOne!;
      user.orientationOne = testList[0].orientationOne!;
      user.doorQuantityOne = testList[0].doorQuantityOne!;
      user.doorSizeHeightFeetOne = testList[0].doorSizeHeightFeetOne!;
      user.doorSizeHeightInchesOne = testList[0].doorSizeHeightInchesOne!;
      user.doorSizeWidthFeetOne = testList[0].doorSizeWidthFeetOne!;
      user.doorSizeWidthInchesOne = testList[0].doorSizeWidthInchesOne!;

      user.locationTwo = testList[0].locationTwo!;
      user.doorTypeTwo = testList[0].doorTypeTwo!;
      user.materialTwo = testList[0].materialTwo!;
      user.orientationTwo = testList[0].orientationTwo!;
      user.doorQuantityTwo = testList[0].doorQuantityTwo!;
      user.doorSizeHeightFeetTwo = testList[0].doorSizeHeightFeetTwo!;
      user.doorSizeHeightInchesTwo = testList[0].doorSizeHeightInchesTwo!;
      user.doorSizeWidthFeetTwo = testList[0].doorSizeWidthFeetTwo!;
      user.doorSizeWidthInchesTwo = testList[0].doorSizeWidthInchesTwo!;

      user.serviceEntrance = testList[0].serviceEntrance!;
      user.servicePole = testList[0].servicePole!;
      user.meterCanSize = testList[0].meterCanSize!;
      user.meterSwitchSize = testList[0].meterSwitchSize!;
      user.interiorFlooding = testList[0].interiorFlooding!;
      user.floodingHeightFeet = testList[0].floodingHeightFeet!;
      user.floodingHeightInches = testList[0].floodingHeightInches!;
      user.groundRod = testList[0].groundRod!;
      user.groundClamp = testList[0].groundClamp!;
      user.groundWire = testList[0].groundWire!;
      user.waterSupply = testList[0].waterSupply!;
      user.waterCloset = testList[0].waterCloset!;
      user.s12ServicePipe = testList[0].s12ServicePipe!;
      user.lengthOfDamageFeet = testList[0].lengthOfDamageFeet!;
      user.lengthOfDamageInches = testList[0].lengthOfDamageInches!;
      user.s34ServicePipe = testList[0].s34ServicePipe!;
      user.lengthOfDamageFeetOne = testList[0].lengthOfDamageFeetOne!;
      user.lengthOfDamageInchesOne = testList[0].lengthOfDamageInchesOne!;
      user.s1ServicePipe = testList[0].s1ServicePipe!;
      user.lengthOfDamageFeetTwo = testList[0].lengthOfDamageFeetTwo!;
      user.lengthOfDamageInchesTwo = testList[0].lengthOfDamageInchesTwo!;
      user.additionalComment = testList[0].additionalComment;
      user.damageSnaps = "$_enDamageList";
      user.name = testList[0].name;
      user.emailAddress = testList[0].emailAddress;

      user.eaveFlashingSize = testList[0].eaveFlashingSize;
      user.fasciaBoardSizeInchesOne = testList[0].fasciaBoardSizeInchesOne;
      user.colonialStyle = testList[0].colonialStyle;
      user.fasciaBoardSizeInchesTwo = testList[0].fasciaBoardSizeInchesTwo;
      user.colonialStyleOne = testList[0].colonialStyleOne;
      user.colonialStyleTwo = testList[0].colonialStyleTwo;

      user.requestKey = widget.strIds;

      var result = await _userService.UpdateUser(user);
      print('Updateeeeeeeeeee 1111 ${result}');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Assessment form Saved in Offline"),
        backgroundColor: Colors.green,
      ));

      /* widget.tabonTab!(list: [false, true, true]);

      widget.tabController.animateTo(0);*/
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    accesstoken: '',
                  )));
    }

    ///  print('CHEKKKKKKKKKK VALUESSSSSSS 1111 ${data}');
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

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Assessment Form Stored Successfully"),
          backgroundColor: Colors.red.shade300,
        ));

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      accesstoken: '',
                    )));

        print("asadasdsadasdadsasdasd");
      }
    });
  }

  // String fileName = file.path.split('/').last;
  //
  // FormData data = FormData.fromMap({
  //   'step': '4',
  //   'form_type': "create",
  //   'request_id': "${widget.strIds}",
  //   "damage-snaps[0]'": await MultipartFile.fromFile(
  //     file.path,
  //     filename: fileName,
  //   ),
  // });
  //
  // Dio dio = new Dio();
  //
  // dio.post("http://3.223.85.137/disaster_reconstruction/api/assessments/store/1", data: data)
  //     .then((response) => print(response))
  //     .catchError(( error) => print("fgfsgfdgfgfggf$error"));

  // void _upload() async {
  //   print('EEEEEEEEEEEEEEEEEEEEEEEEEEE');
  //
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   Map<String, dynamic> map = {
  //     'step': '4',
  //     'form_type': "create",
  //     'request_id': "${widget.strIds}",
  //   };
  //   var i = 0;
  //   imageStrList.forEach((element) async {
  //     File file = File(element);
  //     String fileName = file.path.split('/').last;
  //     map['damage-snaps[$i]'] = await MultipartFile.fromFile(
  //       file.path,
  //       filename: fileName,
  //       contentType: new MediaType("image", "jpeg"), //add this
  //     );
  //     i++;
  //   });
  //   FormData data = FormData.fromMap(map);
  //
  //   print("dsdfsdfsfs ${data}");
  //
  //   Dio dio = new Dio();
  //
  //   await dio.post(
  //           "http://3.223.85.137/disaster_reconstruction/api/assessments/store/1",
  //           data: data,onSendProgress: (int send,int total){
  //    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$send---$total'),duration: Duration(milliseconds: 500),));
  //   })
  //
  //       .then((response) {
  //         print(response.statusCode);
  //
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text(response.data['message']),
  //           backgroundColor: Colors.red.shade300,
  //         ));
  // //    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$data')));
  //     setState(() {
  //       isLoading = false;
  //     });
  //
  //     print("KKKKKKKKKKKKK $data");
  //   }).catchError((error) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Eroooooooor')));
  //     print("FFFFFFFFFFFFFFF $error");
  //     print(error);
  //   });
  // }

  //********************** IMAGE PICKER
  Future imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":

        /// GALLERY IMAGE PICKER
        imageFilelist =
            await ImagePicker().pickMultiImage(imageQuality: 90) ?? [];
        break;

      case "camera": // CAMERA CAPTURE CODE
        imageFile = await ImagePicker()
            .pickImage(source: ImageSource.camera, imageQuality: 90);
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
    }
    setState(() {});
    if (imageFile != null) {
      print("You selected  image : " + imageFile!.path);
      final sizeOfImage = File(imageFile!.path).lengthSync();

      final kb = sizeOfImage / 1024;
      final mb = kb / 1024;
      final size = (mb >= 1)
          ? '${mb.toStringAsFixed(2)} MB'
          : '${kb.toStringAsFixed(2)} KB';
      imagesize.add(size);

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
