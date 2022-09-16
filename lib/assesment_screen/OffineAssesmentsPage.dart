import 'dart:convert';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:dra_project/models/AssesmentDataBaseModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:location/location.dart';

import '../common/app_constants.dart';
import '../common/no_result.dart';
import '../db_helper/assesmentService.dart';
import '../models/login_page_api/api_login.dart';
import '../screens/screens.dart';

class OffineAssesmentsPage extends StatefulWidget {
  const OffineAssesmentsPage({Key? key}) : super(key: key);
  @override
  State<OffineAssesmentsPage> createState() => _OffineAssesmentsPagenState();
}

class _OffineAssesmentsPagenState extends State<OffineAssesmentsPage> {
  // List<AssessmentList> dataList = [];
  Map<String, dynamic>? data = Map();

  bool isLoading = false;
  List<AssesmentDataBaseModel> dataList = <AssesmentDataBaseModel>[];
  final _userService = AssesmentService();
  final ApiClient _apiClient = ApiClient();
  late geo.Position position;
  late Location location;
  late bool _serviceEnabled;
  dynamic _lat;
  dynamic _lon;

  late PermissionStatus _permissionGranted;

  @override
  void initState() {
    getAllUserDetails();
    _locateMe();
    location.getLocation().then((value) =>
        {print("Latitude - ${value.latitude} Longitude - ${value.longitude}")});
    super.initState();
  }

  void _updateDamage(int pos) async {
    setState(() {
      isLoading = true;
    });

    /*  List<dynamic> _enTypeList = jsonDecode(dataList[pos].type!);
    List<dynamic> _enType1List = jsonDecode(dataList[pos].typeOne!);
    List<dynamic> _enType2List = jsonDecode(dataList[pos].typeTwo!);

    List<dynamic> _enWindowList = jsonDecode(dataList[pos].windowStyle!);
    List<dynamic> _enWindow1List = jsonDecode(dataList[pos].windowStyleOne!);
    List<dynamic> _enWindow2List = jsonDecode(dataList[pos].windowStyleTwo!);


    List<dynamic> _enLocationList = jsonDecode(dataList[pos].location!);
    List<dynamic> _enLocation1List = jsonDecode(dataList[pos].locationOne!);
    List<dynamic> _enLocation2List = jsonDecode(dataList[pos].locationTwo!);

    List<dynamic> _enDoorTypeList = jsonDecode(dataList[pos].doorType!);
    List<dynamic> _enDoorType1List = jsonDecode(dataList[pos].doorTypeOne!);
    List<dynamic> _enDoorType2List = jsonDecode(dataList[pos].doorTypeTwo!);

    List<dynamic> _enOrientationList = jsonDecode(dataList[pos].orientation!);
    List<dynamic> _enOrientation1List = jsonDecode(dataList[pos].orientationOne!);
    List<dynamic> _enOrientation2List = jsonDecode(dataList[pos].orientationTwo!);

    List<dynamic> _enServiceEntList = jsonDecode(dataList[pos].serviceEntrance!);
    List<dynamic> _enServicePoleList = jsonDecode(dataList[pos].servicePole!);
    List<dynamic> _enYerornoList = jsonDecode(dataList[pos].interiorFlooding!);*/
    List<dynamic> _enGroundRodList = jsonDecode(dataList[pos].groundRod!);
    List<dynamic> _enGroundClampList = jsonDecode(dataList[pos].groundClamp!);
    List<dynamic> _enGroundWireList = jsonDecode(dataList[pos].groundWire!);
    List<dynamic> _enGroundWatersupplyList =
        jsonDecode(dataList[pos].waterSupply!);
    //   List<dynamic> _enGroundWaterClosestList = jsonDecode(dataList[pos].waterCloset!);
    List<dynamic> _enServicePipeList =
        jsonDecode(dataList[pos].s12ServicePipe!);
    List<dynamic> _enServicePipe1List =
        jsonDecode(dataList[pos].s34ServicePipe!);
    List<dynamic> _enServicePipe2List =
        jsonDecode(dataList[pos].s1ServicePipe!);

    data = {
      'step': '2',
      'eave-flashing-inches': dataList[pos].eaveFlashingInches,
      'eave-flashing-feet': dataList[pos].eaveFlashingFeet,
      'eave-flashing-size': dataList[pos].eaveFlashingSize,
      'fascia-board-feet': dataList[pos].fasciaBoardFeet,
      'fascia-board-inches': dataList[pos].floodingHeightInches,
      'fascia-board-size-inches-one': dataList[pos].fasciaBoardSizeInchesOne,
      'fascia-board-size-inches-two': dataList[pos].fasciaBoardSizeInchesTwo,
      'soffit-height-feet': dataList[pos].soffitHeightFeet,
      'soffit-height-inches': dataList[pos].soffitHeightInches,
      'soffit-width-feet': dataList[pos].soffitWidthFeet,
      'soffit-width-inches': dataList[pos].soffitWidthInches,
      'soffit-type': dataList[pos].soffitType,
      'shingles-height-feet': dataList[pos].shinglesHeightFeet,
      'shingles-height-inches': dataList[pos].shinglesHeightInches,
      'shingles-width-feet': dataList[pos].shinglesWidthFeet,
      'shingles-width-inches': dataList[pos].shinglesWidthInches,
      'shingle-style': dataList[pos].shingleStyle,
      'plywood-height-feet': dataList[pos].plywoodHeightFeet,
      'plywood-height-inches': dataList[pos].plywoodHeightInches,
      'plywood-width-feet': dataList[pos].plywoodWidthFeet,
      'plywood-width-inches': dataList[pos].plywoodWidthInches,
      'ice-and-water-shield-height-feet':
          dataList[pos].iceAndWaterShieldHeightFeet,
      'ice-and-water-shield-width-feet':
          dataList[pos].iceAndWaterShieldHeightInches,
      'ice-and-water-shield-width-inches':
          dataList[pos].iceAndWaterShieldWidthFeet,
      'ice-and-water-shield-height-inches':
          dataList[pos].iceAndWaterShieldWidthInches,
      'torch-on-height-feet': dataList[pos].torchOnHeightFeet,
      'torch-on-height-inches': dataList[pos].torchOnHeightInches,
      'torch-on-width-feet': dataList[pos].torchOnWidthFeet,
      'torch-on-width-inches': dataList[pos].torchOnWidthInches,
      'tough-guard-height-feet': dataList[pos].toughGuardHeightFeet,
      'tough-guard-height-inches': dataList[pos].toughGuardHeightInches,
      'tough-guard-width-feet': dataList[pos].toughGuardWidthFeet,
      'tough-guard-width-inches': dataList[pos].toughGuardWidthInches,
      'type': dataList[pos].type!,
      'colonial-style': dataList[pos].colonialStyle ?? '',
      'window-style': dataList[pos].windowStyle ?? '',
      'quantity': dataList[pos].quantity,
      'size-height-feet': dataList[pos].sizeHeightFeet,
      'size-height-inches': dataList[pos].sizeHeightInches,
      'size-width-feet': dataList[pos].sizeWidthFeet,
      'size-width-inches': dataList[pos].sizeWidthInches,
      'type-one': dataList[pos].typeOne!,
      'colonial-style-one': dataList[pos].colonialStyleOne ?? '',
      'window-style-one': dataList[pos].windowStyleOne ?? '',
      'quantity-one': dataList[pos].quantityOne,
      'size-height-feet-one': dataList[pos].sizeHeightFeetOne,
      'size-height-inches-one': dataList[pos].sizeHeightInchesOne,
      'size-width-feet-one': dataList[pos].sizeWidthFeetOne,
      'size-width-inches-one': dataList[pos].sizeWidthInchesOne,
      'type-two': dataList[pos].typeTwo!,
      'colonial-style-two': dataList[pos].colonialStyleTwo ?? '',
      'window-style-two': dataList[pos].windowStyleTwo ?? '',
      'quantity-two': dataList[pos].quantityTwo,
      'size-height-feet-two': dataList[pos].sizeHeightFeetTwo,
      'size-height-inches-two': dataList[pos].sizeHeightInchesTwo,
      'size-width-feet-two': dataList[pos].sizeWidthFeetTwo,
      'size-width-inches-two': dataList[pos].sizeWidthInchesTwo,
      'location': dataList[pos].location!,
      'door-type': dataList[pos].doorType!,
      'meterial': dataList[pos].material,
      'orientation': dataList[pos].orientation!,
      'door-quantity': dataList[pos].doorQuantity,
      'door-size-height-feet': dataList[pos].doorSizeHeightFeet,
      'door-size-height-inches': dataList[pos].doorSizeHeightInches,
      'door-size-width-feet': dataList[pos].doorSizeWidthFeet,
      'door-size-width-inches': dataList[pos].doorSizeWidthInches,
      'location-one': dataList[pos].locationOne!,
      'door-type-one': dataList[pos].doorTypeOne,
      'meterial-one': dataList[pos].materialOne,
      'orientation-one': dataList[pos].orientationOne!,
      'door-quantity-one': dataList[pos].doorQuantityOne,
      'door-size-height-feet-one': dataList[pos].doorSizeHeightFeetOne,
      'door-size-height-inches-one': dataList[pos].doorSizeHeightInchesOne,
      'door-size-width-feet-one': dataList[pos].doorSizeWidthFeetOne,
      'door-size-width-inches-one': dataList[pos].doorSizeWidthInchesOne,
      'location-two': dataList[pos].locationTwo!,
      'door-type-two': dataList[pos].doorTypeTwo!,
      'meterial-two': dataList[pos].materialTwo,
      'orientation-two': dataList[pos].orientationTwo!,
      'door-quantity-two': dataList[pos].doorQuantityTwo,
      'door-size-height-feet-two': dataList[pos].doorSizeHeightFeetTwo,
      'door-size-height-inches-two': dataList[pos].doorSizeHeightInchesTwo,
      'door-size-width-feet-two': dataList[pos].doorSizeWidthFeetTwo,
      'door-size-width-inches-two': dataList[pos].doorSizeWidthInchesTwo,
      'service-entrance': dataList[pos].serviceEntrance!,
      'service-pole': dataList[pos].servicePole!,
      'meter-can-size': dataList[pos].meterCanSize,
      'meter-switch-size': dataList[pos].meterSwitchSize,
      'interior-flooding': dataList[pos].interiorFlooding!,
      'flooding-height-feet': dataList[pos].floodingHeightFeet,
      'flooding-height-inches': dataList[pos].floodingHeightInches,
      'ground-rod': _enGroundRodList,
      'ground-clamp': _enGroundClampList,
      'ground-wire': _enGroundWireList,
      'water-supply': _enGroundWatersupplyList,
      'water-closet': dataList[pos].waterCloset!,
      '1/2-service-pipe': _enServicePipeList,
      'length-of-damage-feet': dataList[pos].lengthOfDamageFeet,
      'length-of-damage-inches': dataList[pos].lengthOfDamageInches,
      '3/4-service-pipe': _enServicePipe1List,
      'length-of-damage-feet-one': dataList[pos].lengthOfDamageFeetOne,
      'length-of-damage-inches-one': dataList[pos].lengthOfDamageInchesOne,
      '1-service-pipe': _enServicePipe2List,
      'length-of-damage-feet-two': dataList[pos].lengthOfDamageFeetTwo,
      'length-of-damage-inches-two': dataList[pos].lengthOfDamageInchesTwo,
      'form_type': 'create',
      'request_id': '${dataList[pos].requestKey}'
    };

    // setState(() {
    //   isLoading = true;
    // });

    dynamic res = await _apiClient.damagesApi(data, "1");

    if (res?.statusCode == 200) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: const Text('Assessment Form Store Successfully'),
      //   backgroundColor: Colors.green.shade300,
      // ));
      setState(() {
        isLoading = false;
      });

      _updateComment(
          id: dataList[pos].requestKey!,
          comment: dataList[pos].additionalComment!,
          accessToken: "",
          pos: pos);

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Basic(ids: '',)));
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.data['error']),
          backgroundColor: Colors.red.shade300,
        ),
      );
    }
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

  void _updateComment({
    required String id,
    required String comment,
    required String accessToken,
    required int pos,
  }) async {
    setState(() {
      isLoading = true;
    });
    dynamic res = await _apiClient.Comment_screen(comment, "", id);

    if (res?.statusCode == 200) {
      _upload(pos);

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: const Text('Assessment Form Store Successfully'),
      //   backgroundColor: Colors.green.shade300,
      // ));

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.data['error']),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }

  void _upload(int pos) async {
    setState(() {
      isLoading = true;
    });

    List<http.MultipartFile> newList = [];
    List<String> imageStrList = [];

    if (dataList[pos].damageSnaps != "") {
      List<dynamic> deTypeList = jsonDecode(dataList[pos].damageSnaps!);

      print("Encodeeeeeeeeee ${deTypeList}");

      for (int ii = 0; ii < deTypeList.length; ii++) {
        setState(() {
          imageStrList.add(deTypeList[ii]);
        });
      }
    }

    var kyc = Uri.parse("${BASE_URL}assessments/store/1");
    var request = new http.MultipartRequest("POST", kyc);
    // request.headers.addAll(headers);

    request.fields['step'] = "4";
    request.fields['form_type'] = "create";
    request.fields['latitude'] = "$_lat";
    request.fields['longitude'] = "$_lon";
    request.fields['request_id'] = "${dataList[pos].requestKey}";

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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Assessment Form Stored Successfully"),
      backgroundColor: Colors.green,
    ));
    await request.send().then((value) {
      if (value.statusCode == 200) {
        deleteDb(dataList[pos].id!, pos);

        /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                  accesstoken: '',
                )));*/

        print("asadasdsadasdadsasdasd");
      }
    });
  }

  deleteDb(dynamic _userId, int _pos) async {
    var users = await _userService.deleteUser(_userId);

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text("Assessment Form Deleted Successfully"),
    //   backgroundColor: Colors.redAccent,
    // ));
    setState(() {
      dataList.removeAt(_pos);
      isLoading = false;
    });
    print("xcSXcSXcXZC $users ");
  }

  getAllUserDetails() async {
    var users = await _userService.readAllUsers();
    dataList = <AssesmentDataBaseModel>[];
    users.forEach((row) {
      setState(() {
        dataList.add(AssesmentDataBaseModel.fromMap(row));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xffff16698C),
          centerTitle: true,
          title: Text(
            "Offline",
            style: TextStyle(fontSize: 18),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
        ),
        body: isLoading == true
            ? const SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                padding: EdgeInsets.only(top: 10),
                child: dataList.isNotEmpty
                    ? ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final assimentList = dataList[index];
                          Text('${assimentList.requestKey}');
                          return InkWell(
                            child: Padding(
                                padding:
                                    EdgeInsets.only(left: 5, right: 5, top: 5),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  color: Colors.white,
                                  elevation: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${assimentList.name}'
                                                      .capitalize(),
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'San Francisco',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Color(0xff000000)),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '${assimentList.emailAddress}',
                                                  style: TextStyle(
                                                      color: Color(0xffA5A5A5),
                                                      fontSize: 10,
                                                      fontFamily:
                                                          'San Francisco'),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () async {
                                                      bool result =
                                                          await InternetConnectionChecker()
                                                              .hasConnection;
                                                      if (result == true) {
                                                        print(
                                                            'YAY! Free cute dog pics!');

                                                        _updateDamage(index);
                                                        print("cscdscdscdscds");
                                                      } else {
                                                        print(
                                                            'No internet :( Reason:');
                                                      }
                                                    },
                                                    icon: Icon(Icons
                                                        .cloud_upload_sharp)),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        deleteDb(
                                                            dataList[index].id,
                                                            index);
                                                        dataList
                                                            .removeAt(index);
                                                      });
                                                    },
                                                    icon: Icon(Icons.delete))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      /*Padding(
                padding: EdgeInsets.only(left: 10.0, top: 5),
                child: Text(
                  '${assimentList[pos].emailAddress}',
                  style: TextStyle(
                      color: Color(0xffA5A5A5),
                      fontSize: 10,
                      fontFamily: 'San Francisco'),
                ),
              ),*/

                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       left: 18.0, right: 8),
                                      //   child: Divider(),
                                      // ),
                                      // Padding(
                                      //   padding:
                                      //       const EdgeInsets.only(left: 18.0),
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.start,
                                      //     children: [
                                      //       Padding(
                                      //           padding: const EdgeInsets.only(
                                      //               bottom: 6.0, right: 2),
                                      //           child: Text(
                                      //             'Assigned Id :',
                                      //             style: TextStyle(
                                      //                 fontFamily:
                                      //                     'San Francisco',
                                      //                 color: Color(0xff16698C),
                                      //                 fontSize: 10,
                                      //                 fontWeight:
                                      //                     FontWeight.w700),
                                      //           )),
                                      //       Padding(
                                      //         padding: const EdgeInsets.only(
                                      //             bottom: 6.0, right: 10),
                                      //         child: Row(
                                      //           children: [
                                      //             // Icon(
                                      //             //   Icons.calendar_month_outlined,
                                      //             //   color: Colors.black,
                                      //             //   size: 11,
                                      //             // ),
                                      //             Text(
                                      //               '${assimentList.requestKey}',
                                      //               style: TextStyle(
                                      //                   color: Colors.black,
                                      //                   fontSize: 10),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       )
                                      //     ],
                                      //   ),
                                      // )
                                    ],
                                  ),
                                )),
                            onTap: () async {
                              print("========================");
                              print(assimentList.id);

                              bool result = await InternetConnectionChecker()
                                  .hasConnection;
                              if (result == true) {
                                print('YAY! Free cute dog pics!');

                                _updateDamage(index);
                                print("cscdscdscdscds");
                                /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Basic(
                                ids:
                                '${assimentList.requestKey}',
                              )));*/
                              } else {
                                print('No internet :( Reason:');

                                // _query(assimentList.assessmentRequestId);

                                /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AssesmentDBTab(
                                              str_id:
                                                  '${assimentList.requestKey}',
                                              str_email:
                                                  '${assimentList.emailAddress}',
                                              str_name: '${assimentList.name}',
                                            )));*/
                                // print(InternetConnectionChecker().lastTryResults);
                              }
                            },
                          );
                          //  NewWidget(assimentList: assimentList);
                        })
                    : Center(child: EmptyData()),
              ));
  }
}

/*
class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
    required this.assimentList,
    required this.pos,
  }) : super(key: key);

  final List<AssesmentDataBaseModel> assimentList;
  final int pos;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 5, right: 5, top: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: Colors.white,
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${assimentList[pos].name}',

                          style: const TextStyle(
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xff000000)),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          '${assimentList[pos].emailAddress}',
                          style: TextStyle(
                              color: Color(0xffA5A5A5),
                              fontSize: 10,
                              fontFamily: 'San Francisco'),
                        ),
                      ],
                    ),


                    Row(children: [

                      IconButton(onPressed: (){}, icon: Icon(Icons.cloud_upload_sharp)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.delete))

                    ],)

                  ],
                ),
              ),
              */
/*Padding(
                padding: EdgeInsets.only(left: 10.0, top: 5),
                child: Text(
                  '${assimentList[pos].emailAddress}',
                  style: TextStyle(
                      color: Color(0xffA5A5A5),
                      fontSize: 10,
                      fontFamily: 'San Francisco'),
                ),
              ),*/ /*


              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 8),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 6.0, right: 2),
                        child: Text(
                          'Assigned Id :',
                          style: TextStyle(
                              fontFamily: 'San Francisco',
                              color: Color(0xff16698C),
                              fontSize: 10,
                              fontWeight: FontWeight.w700),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0, right: 10),
                      child: Row(
                        children: [
                          // Icon(
                          //   Icons.calendar_month_outlined,
                          //   color: Colors.black,
                          //   size: 11,
                          // ),
                          Text(
                            '${assimentList[pos].requestKey}',
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
*/
//}
