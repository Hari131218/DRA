import 'dart:async';
import 'dart:convert';
import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dra_project/assesment_screen/assesment_db_tab.dart';
import 'package:dra_project/models/AssesmentDataBaseModel.dart';
import 'package:dra_project/screens/assessor_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'basic_screen.dart';
import '../common/ConnectionStatusSingleton.dart';
import '../common/GetStorageUtility.dart';
import '../common/app_constants.dart';
import '../common/no_result.dart';
import '../db_helper/assesmentService.dart';
import '../models/assessment_list_model.dart';
import '../models/login_page_api/api_login.dart';
import 'package:geolocator/geolocator.dart' as geo;



class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late ScrollController controller;
  late Future<List<AssessmentListModel>> futureData;
  late SharedPreferences localStorage;
  bool isLoading = false;
  bool isOffline = false;
  late geo.Position position;
  String? stringValue;
  List<AssessmentList> dataList = [];

  final ConnectionStatusSingleton _connectivity =
      ConnectionStatusSingleton.instance;
  Map _source = {ConnectivityResult.none: false};

  List<String> items = List.generate(10, (index) => 'Hello $index');
  fetchData(accessToken) async {
    final response = await get(
        Uri.parse('${BASE_URL}assessment_requests/index'),
        headers: {'Authorization': 'Bearer ${accessToken}'});
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    if (response.statusCode == 200) {
      dataList = (json.decode(response.body)['assessorNameList'] as List)
          .map((e) => new AssessmentList.fromJson(e))
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
  var _userService= AssesmentService();
  late Location location;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  @override
  void initState() {
    super.initState();

    print("cdsdsdsvdsvdsvdsvsdv");

    // _connectivity.initialise();
    // _connectivity.myStream.listen((source) {
    //   setState(() => _source = source);
    //   switch (_source.keys.toList()[0]) {
    //     case ConnectivityResult.mobile:
    //       setState(() {
    //         isOffline = true;
    //       });
    //       //  _fetchData('');
    //       //   stationsModel = APIService().fetchNewData('');
    //       // this.country();
    //       break;
    //     case ConnectivityResult.wifi:
    //       setState(() {
    //         isOffline = true;
    //       });
    //       // _fetchData('');
    //       //  stationsModel = APIService().fetchNewData('');
    //       // this.country();
    //       break;
    //     case ConnectivityResult.none:
    //     default:
    //       setState(() {
    //         isOffline = false;
    //       });
    //   }
    //
    //   //  setState(() => isOffline = source);
    //   print('MMMMMMMMMMMMMMMMMMMMMMM${isOffline}');
    //
    //   if(isOffline == true){
    //    // Provider.of<AssessorProvider>(context, listen: false).getAssessment();
    //   }else{
    //   //  getStringValuesSF();
    //   }
    //
    // });
    _locateMe();
    // location.getLocation().then((value) => {
    //   print("Latitude - ${value.latitude} Longitude - ${value.longitude}")
    // });
    getStringValuesSF();

    // SharedPreferences.getInstance().then((token) {
    //   accessToken = token.getString("accessToken")!;
    //  // fetchData(accessToken);
    //    futureData = fetchData(accessToken);
    // });

    controller = ScrollController()..addListener(_scrollListener);
  }

  getStringValuesSF() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('');
      Provider.of<AssessorProvider>(context, listen: false).getAssessment();
    } else {
      print('No internet :( Reason:');
      Provider.of<AssessorProvider>(context, listen: false)
          .getAssessmentLocal();



      // print(InternetConnectionChecker().lastTryResults);
    }

    // print("SHAREDDDDDDDDDD $stringValue");
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  _locateMe() async {
    location =  Location();

    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {

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
       /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${position.longitude}  ${position.latitude}")));*/
        print(position.longitude); //Output: 80.24599079
        print(position.latitude); //Output: 29.6593457
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AssessorProvider _provider = Provider.of<AssessorProvider>(context);
    // SharedPreferences.getInstance().then((value) {
    //   setState(() {
    //     localStorage = value;
    //   });
    // });
    //  return Text('data');
    return Scaffold(
        body: _provider.isLoading
            ? const SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                padding: EdgeInsets.only(top: 10),
                child: _provider.assessmentList.isNotEmpty
                    ? RefreshIndicator(
                      onRefresh: () =>  getStringValuesSF(),
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                          itemCount: _provider.assessmentList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final assimentList = _provider.assessmentList[index];
                            Text('${assimentList.assignedDate}');
                            return InkWell(
                              child: NewWidget(assimentList: assimentList),
                              onTap: () async {
                                print("========================");
                                print(assimentList.id);

                                bool result = await InternetConnectionChecker()
                                    .hasConnection;
                                if (result == true) {
                                  print('');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Basic(
                                                ids:
                                                    '${assimentList.assessmentRequestId}',
                                              )));
                                } else {
                                  print('No internet :( Reason:');

                                 // _query(assimentList.assessmentRequestId);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AssesmentDBTab(
                                                str_id:
                                                    '${assimentList.assessmentRequestId}', str_name: '${assimentList.firstName}', str_email: '${assimentList.email}', str_webId: '${assimentList.webId}',
                                              )));
                                  // print(InternetConnectionChecker().lastTryResults);
                                }
                              },
                            );
                            //  NewWidget(assimentList: assimentList);
                          }),
                    )
                    : Center(child: EmptyData()),
              ));
  }



  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 5) {
      setState(() {
        items.addAll(List.generate(10, (index) => 'Inserted $index'));
      });
    }
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
    required this.assimentList,
  }) : super(key: key);

  final AssessmentList assimentList;

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
                padding: EdgeInsets.only(left: 18.0, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${assimentList.firstName}'.toCapitalized(),
                      style: const TextStyle(
                          fontFamily: 'San Francisco',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xff000000)),
                    ),

                    // TextButton(
                    //   style: TextButton.styleFrom(
                    //     primary: Color(0xffA5A5A5),
                    //     minimumSize: Size(10, 0)
                    //   ),
                    //   onPressed: () { },
                    //   child: Icon(Icons.more_vert,size: 10,),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0, top: 5),
                child: Text(
                  '${assimentList.address}',
                  style: TextStyle(
                      color: Color(0xffA5A5A5),
                      fontSize: 10,
                      fontFamily: 'San Francisco'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                          ),
                          child: CircleAvatar(
                            radius: 10,
                            child: Icon(
                              Icons.mail,
                              color: Colors.white,
                              size: 8,
                            ),
                            backgroundColor: Color(0xff00b3bf),
                          ),
                        ),
                        Text(
                          '${assimentList.email}',
                          style: TextStyle(
                              fontFamily: 'San Francisco',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff000000)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 20),
                          child: CircleAvatar(
                            radius: 10,
                            child: Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 8,
                            ),
                            backgroundColor: Color(0xff00b3bf),
                          ),
                        ),
                        Text(
                          '${assimentList.phoneNumber}',
                          style: TextStyle(
                              fontFamily: 'San Francisco',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff000000)),
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0, right: 8),
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
                          'Assigned Date :',
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
                            '${assimentList.assignedDate}',
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
}
