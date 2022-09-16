import 'dart:convert';

import 'package:dra_project/screens/request_info.dart';
import 'package:dra_project/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../common/app_constants.dart';
import '../models/homeowner_api.dart';
import '../models/login_page_api/api_login.dart';
import 'assesment_page.dart';

class Basic extends StatefulWidget {
  const Basic({Key? key, required this.ids}) : super(key: key);

  final String ids;

  @override
  State<Basic> createState() => _BasicState();
}

class _BasicState extends State<Basic> {
  //late SharedPreferences localStorage;
  //**start**
  late ScrollController controller;
  late Future<homeownerlist> futureData;
  late SharedPreferences localStorage;
  bool isLoading = false;
  List<AssessorNameList> dataList = [];
  List<String> items = List.generate(10, (index) => 'Hello $index');
  //DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool defaultdate = true;
  fetchData(accessToken) async {
    setState(() {
      this.isLoading = true;
    });

    final response = await get(
        Uri.parse('${BASE_URL}assessments/show?id=${widget.ids}'),
        headers: {'Authorization': 'Bearer ${accessToken}'});
    print(response.body);
    if (response.statusCode == 200) {
      dataList = (json.decode(response.body)['assessorNameList'] as List)
          .map((e) => AssessorNameList.fromJson(e))
          .toList();

      setState(() {
        if (dataList[0].scheduledAt != null && dataList[0].scheduledAt != '') {
          String date = '${dataList[0].scheduledAt}';
          DateTime parseDate = new DateFormat("MM/dd/yyyy").parse(date);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('yyyy-MM-dd');
          var outputDate = outputFormat.format(inputDate);
          _selectedDay = DateTime.parse(outputDate);

          DateTime valEnd = _selectedDay!;
          DateTime currentdate = DateTime.now();
          bool valDate = currentdate.isBefore(valEnd);

          if (valDate == false) {
            _selectedDay = currentdate;
          }

          print("current dateeeeeeee $valDate");

          print(outputDate);
        }
        this.isLoading = false;
      });
    } else {
      setState(() {
        this.isLoading = false;
      });
      throw Exception('Unexpected error occured!');
    }
  }

  rescheduleAPICall(_dat) async {
    setState(() {
      isLoading = true;
    });

    var accessToken = "";
    await SharedPreferences.getInstance()
        .then((value) => accessToken = value.getString("accessToken") ?? "");

    final response = await post(
        Uri.parse('${BASE_URL}assessment_requests/reschedule_assessment'),
        body: {
          'assign_request_id': dataList[0].id.toString(),
          'assign_date': _dat.toString(),
        },
        headers: {
          'Authorization': 'Bearer ${accessToken}'
        });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      var message = json.decode(response.body)['message'];
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    accesstoken: '',
                  )));
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Unexpected error occured!');
    }
  }

  final ApiClient _apiClient = ApiClient();
  @override
  void initState() {
    super.initState();
    var accessToken = "";
    SharedPreferences.getInstance().then((token) {
      accessToken = token.getString("accessToken")!;
      // fetchData(accessToken);
      fetchData(accessToken);
    });
  }
  //**end

  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  //
  // @override
  // void initState() {
  //   assessmentlist.
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //**start

    // SharedPreferences.getInstance().then((value){
    //   setState(() {
    //     localStorage = value;
    //   });
    // });
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xff16698c),
      //   centerTitle: true,
      //   title: Column(
      //     children: [
      //       Text(
      //         'Assesment ID',
      //         style: TextStyle(fontSize: 10, fontFamily: 'San Francisco'),
      //       ),
      //       Text('#12AAG3GDG4DFS643',
      //           style: TextStyle(fontSize: 14, fontFamily: 'San Francisco'))
      //     ],
      //   ),
      // ),
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index) {
                final assimentList = dataList[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 80,
                      color: Color(0xff16698c),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyHomePage(
                                                accesstoken: '',
                                              )));
                                },
                                child: dataList[0].scheduledAt != null &&
                                        dataList[0].scheduledAt != ''
                                    ? Icon(
                                        Icons.chevron_left,
                                        color: Colors.white,
                                        size: 30,
                                      )
                                    : Container(),
                              ),
                              // ElevatedButton(
                              //   onPressed: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => MyHomePage(
                              //               accesstoken: '',
                              //             )));
                              //   }, child: Icon(Icons.chevron_left),style: ElevatedButton.styleFrom(
                              //     primary: Color(0xff16698c),
                              //     elevation: 0,
                              //     shape: RoundedRectangleBorder()
                              // ),
                              // ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.only(right: 18),
                                child: Column(
                                  children: [
                                    Text(
                                      'Web ID',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'San Francisco',
                                          color: Colors.white),
                                    ),
                                    Text('#${assimentList.webId}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'San Francisco',
                                            color: Colors.white))
                                  ],
                                ),
                              )),
                            ],
                          ),

                          // Text('#${assimentList.webId}',
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //         fontSize: 10,
                          //         fontFamily: 'San Francisco',
                          //         color: Colors.white))
                        ],
                      ),
                    ),
                    dataList[0].scheduledAt != null &&
                            dataList[0].scheduledAt != ''
                        ? Container(
                            height: 45.06,
                            decoration: BoxDecoration(color: Color(0xff12AFC0)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 23, top: 9, bottom: 8.06),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Homeowner Information',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'San Francisco',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => requestinfo(
                                                    ids: '${assimentList.id}',
                                                  )));
                                    },
                                    child: Text(
                                      'Request info Change',
                                      style: TextStyle(
                                        color: Color(0xffEBEBEB),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'San Francisco',
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      side: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 2, top: 10),
                      child: Text(
                        'Homeowner Name',
                        style: TextStyle(
                            color: Color(0xff808B9E),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            fontFamily: 'San Francisco'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 16, bottom: 10),
                        child: Text(
                          '${assimentList.firstName} ${assimentList.lastName}',
                          style: TextStyle(
                              color: Color(0xff131313),
                              fontSize: 12,
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w500),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 2, top: 10),
                      child: Text(
                        'Mobile Number',
                        style: TextStyle(
                            color: Color(0xff808B9E),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            fontFamily: 'San Francisco'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 16, bottom: 10),
                        child: Text(
                          '${assimentList.phoneNumber}',
                          style: TextStyle(
                              color: Color(0xff131313),
                              fontSize: 12,
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w500),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 2, top: 10),
                      child: Text(
                        'Email Address',
                        style: TextStyle(
                            color: Color(0xff808B9E),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            fontFamily: 'San Francisco'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 16, bottom: 10),
                        child: Text(
                          '${assimentList.email}',
                          style: TextStyle(
                              color: Color(0xff131313),
                              fontSize: 12,
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w500),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 2, top: 10),
                      child: Text(
                        'Street Address',
                        style: TextStyle(
                            color: Color(0xff808B9E),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            fontFamily: 'San Francisco'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 16,
                          bottom: 10,
                        ),
                        child: Text(
                          '${assimentList.address}',
                          style: TextStyle(
                              color: Color(0xff131313),
                              fontSize: 12,
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w500),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 2, top: 10),
                      child: Text(
                        'Island',
                        style: TextStyle(
                            color: Color(0xff808B9E),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            fontFamily: 'San Francisco'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 16, bottom: 10),
                        child: Text(
                          '${assimentList.island}',
                          style: TextStyle(
                              color: Color(0xff131313),
                              fontSize: 12,
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w500),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 2, top: 10),
                      child: Text(
                        'Home Number',
                        style: TextStyle(
                            color: Color(0xff808B9E),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            fontFamily: 'San Francisco'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 16, bottom: 10),
                        child: Text(
                          '${assimentList.homeNumber}',
                          style: TextStyle(
                              color: Color(0xff131313),
                              fontSize: 12,
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w500),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 2, top: 10),
                      child: Text(
                        'Settlement',
                        style: TextStyle(
                            color: Color(0xff808B9E),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            fontFamily: 'San Francisco'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 16, bottom: 10),
                        child: Text(
                          '${assimentList.settlement}',
                          style: TextStyle(
                              color: Color(0xff131313),
                              fontSize: 12,
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w500),
                        )),
                    dataList[0].scheduledAt != null &&
                            dataList[0].scheduledAt != ''
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 30, bottom: 2),
                                    child: Text(
                                      'Scheduled Date',
                                      style: TextStyle(
                                          color: Color(0xff808B9E),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          fontFamily: 'San Francisco'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 9, right: 16, bottom: 5),
                                    child: Text(
                                      assimentList.scheduledAt.toString(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, setstate) {
                                        return SingleChildScrollView(
                                          reverse: true,
                                          child: Container(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10.0,
                                                    bottom: 2,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 10,
                                                                left: 15),
                                                        child: Text(
                                                          'Select Date',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  'San Francisco,',
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                TableCalendar(
                                                  firstDay: DateTime.now(),
                                                  selectedDayPredicate: (day) {
                                                    return isSameDay(
                                                        _selectedDay, day);
                                                  },
                                                  onDaySelected: (selectedDay,
                                                      focusedDay) {
                                                    if (!isSameDay(_selectedDay,
                                                        selectedDay)) {
                                                      _selectedDay =
                                                          selectedDay;
                                                      _focusedDay = focusedDay;
                                                      setstate(() {});
                                                    }
                                                  },
                                                  onFormatChanged: (format) {
                                                    if (_calendarFormat !=
                                                        format) {
                                                      // Call `setState()` when updating calendar format
                                                      setState(() {
                                                        _calendarFormat =
                                                            format;
                                                      });
                                                    }
                                                  },
                                                  onPageChanged: (focusedDay) {
                                                    // No need to call `setState()` here
                                                    _focusedDay = focusedDay;
                                                  },
                                                  calendarStyle: CalendarStyle(
                                                      todayTextStyle:
                                                          TextStyle(),
                                                      todayDecoration:
                                                          BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      outsideDaysVisible: false,
                                                      selectedDecoration:
                                                          BoxDecoration(
                                                        color:
                                                            Color(0xff16698C),
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: Color(
                                                                0xffD8F3FF)),
                                                      )),
                                                  lastDay:
                                                      DateTime.utc(2030, 3, 14),
                                                  focusedDay: _selectedDay!,
                                                  rangeSelectionMode:
                                                      RangeSelectionMode
                                                          .toggledOff,
                                                  headerStyle: HeaderStyle(
                                                    rightChevronIcon: Icon(
                                                      Icons.chevron_right,
                                                      color: Color(0xff16698C),
                                                    ),
                                                    leftChevronIcon: Icon(
                                                      Icons.chevron_left,
                                                      color: Color(0xff16698C),
                                                    ),
                                                    formatButtonVisible: false,
                                                    titleCentered: true,
                                                    titleTextStyle: TextStyle(
                                                        color:
                                                            Color(0xff16698C)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            String date =
                                                                '${dataList[0].scheduledAt}';
                                                            print(date +
                                                                ' jjmkjkkkmkk');
                                                            DateTime parseDate =
                                                                new DateFormat(
                                                                        "MM/dd/yyyy")
                                                                    .parse(
                                                                        date);

                                                            var inputDate =
                                                                DateTime.parse(
                                                                    parseDate
                                                                        .toString());
                                                            var outputFormat =
                                                                DateFormat(
                                                                    'yyyy-MM-dd');
                                                            var outputDate =
                                                                outputFormat
                                                                    .format(
                                                                        inputDate);
                                                            _selectedDay =
                                                                DateTime.parse(
                                                                    outputDate);
                                                            print(outputDate);
                                                          });

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'CANCEL',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'San Francisco',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Color(
                                                                    0xffD45128),
                                                                fixedSize: Size(
                                                                    165, 46)),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          var date =
                                                              "${_focusedDay.year}-${_focusedDay.month}-${_focusedDay.day}";
                                                          // Provider.of<AssessorProvider>(context,listen: false).getAssessmentBasedOnDate(date: date);
                                                          // defaultdate = false;

                                                          print(
                                                              "fdfgdfgfdg $date");

                                                          rescheduleAPICall(
                                                              date);
                                                        },
                                                        child: Text(
                                                          'SUBMIT',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  'San Francisco',
                                                              fontSize: 12),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Color(
                                                                    0xff12AFC0),
                                                                fixedSize: Size(
                                                                    165, 46)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  );
                                  // _selectDate(context);
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>Datepick()));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          ('Reschedule'),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff16698C)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                style: TextButton.styleFrom(
                                  side: BorderSide(color: Color(0xffEBEBEB)),
                                  textStyle: TextStyle(),
                                  backgroundColor: Colors.white,
                                  fixedSize: Size(86, 30),
                                ),
                              )
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 170,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                dataList[0].scheduledAt != null &&
                                        dataList[0].scheduledAt != ''
                                    ? Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                MyHomePage()),
                                        ModalRoute.withName('/'))
                                    : Navigator.pop(context);
                              },
                              child: Text(
                                'CANCEL',
                                style: TextStyle(
                                    fontFamily: 'San Francisco',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xffD45128),
                                  fixedSize: Size(double.infinity, 46)),
                            ),
                          ),
                          dataList[0].scheduledAt != null &&
                                  dataList[0].scheduledAt != ''
                              ? Expanded(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 14,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AssesmentPage(
                                                          str_id:
                                                              '${widget.ids}',
                                                          str_webId:
                                                              '${assimentList.webId}',
                                                        )));
                                          },
                                          child: Center(
                                            child: Text(
                                              !defaultdate
                                                  ? "SUBMIT"
                                                  : 'START ASSESSMENT',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'San Francisco',
                                                  fontSize: 12),
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xff12AFC0),
                                              fixedSize: Size(165, 46)),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                );

                //  NewWidget(assimentList: assimentList);
              }),
    );
  }
}
