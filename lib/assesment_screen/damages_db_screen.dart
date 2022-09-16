import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dra_project/common/no_result.dart';
import 'package:dra_project/db_helper/assesmentService.dart';
import 'package:flutter/material.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/AssesmentDataBaseModel.dart';
import '../models/login_page_api/api_login.dart';
import '../models/submittedlistform.dart';
import '../screens/assesment_page.dart';

class DamagesDbScreen extends StatefulWidget {
  DamagesDbScreen({
    Key? key,
    required this.tabController,
    required this.ids,
    required this.tabonTab,
    required this.str_name,
    required this.str_email,
  }) : super(key: key);

  final TabController tabController;
  final String ids;
  final String str_name;
  final String str_email;
  final Function? tabonTab;

  @override
  State<DamagesDbScreen> createState() => _DamagesDbScreenState();
}

class _DamagesDbScreenState extends State<DamagesDbScreen>
    with SingleTickerProviderStateMixin {
  late SharedPreferences localStorage;
  bool isLoading = false;
  late AssessmentDetailsList dataList;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _controller = ScrollController();

  bool serviceRepair = false;
  bool serviceReplacement = false;
  bool servicePoleRepair = false;
  bool servicePoleReplacement = false;

// bool eleInteriorYes = false;
//  bool eleInteriorNo = false;
  bool _updateDB = false;
  bool eleGroundRod = false;
  bool eleGroundClamp = false;
  bool eleGroundwire = false;

  bool plumingwater = false;
  bool plumingwaterclosetRepair = false;
  bool plumingwaterclosetReplacment = false;

  bool plumingservicePipe1 = false;
  bool plumingservicePipe2 = false;
  bool plumingservicePipe3 = false;

  List<bool> plumingservicePipe3Extra = [];
  List<TextEditingController> plumingService1FeetControllerExtra = [];
  List<TextEditingController> plumingService1InchControllerExtra = [];
  List<TextEditingController> lableTextContorllerExtra = [];

  List<String> windowtype = [];

  List<int> windowtypeid = [];

  List<String> windowColonialStyle = [];

  List<int> windowtypeColonialStyleID = [];

  List<String> windowStyle = [];

  List<int> windowStyleID = [];

  String doorLocation = '';
  String doorLocation1 = '';
  String doorLocation2 = '';

  int doorLocationID = 0;
  int doorLocationID1 = 0;
  int doorLocationID2 = 0;

  String doorType = '';
  String doorType1 = '';
  String doorType2 = '';
  int doorTypeID = 0;
  int doorTypeID1 = 0;
  int doorTypeID2 = 0;

  String doorOrientation = '';
  String doorOrientation1 = '';
  String doorOrientation2 = '';
  int doorOrientationID = 0;
  int doorOrientationID1 = 0;
  int doorOrientationID2 = 0;

  String electricalEntrance = '';
  int electricalEntranceID = 0;

  String electricalPole = '';
  int electricalPoleID = 0;

  String electricalInterior = '';
  int electricalInteriorID = 0;

  String plumbingwater = '';
  int plumbingwaterID = 0;

  late TextEditingController evenFeetController;
  final TextEditingController evenInchController = TextEditingController();
  final TextEditingController evenSizeInchController = TextEditingController();
  final TextEditingController fasciaFeetController = TextEditingController();
  final TextEditingController fasciaInchController = TextEditingController();
  final TextEditingController fasciaSizeFeetController =
      TextEditingController();
  final TextEditingController fasciaSizeInchController =
      TextEditingController();

  final TextEditingController soffitBoardFeetController =
      TextEditingController();
  final TextEditingController soffitBoardInchController =
      TextEditingController();
  final TextEditingController soffitHeightFeetController =
      TextEditingController();
  final TextEditingController soffitHeightInchController =
      TextEditingController();

  final TextEditingController shinglesHeightFeetController =
      TextEditingController();
  final TextEditingController shinglesHeightInchController =
      TextEditingController();
  final TextEditingController shinglesWidthFeetController =
      TextEditingController();
  final TextEditingController shinglesWidthInchController =
      TextEditingController();

  final TextEditingController plywoodHeightFeetController =
      TextEditingController();
  final TextEditingController plywoodHeightInchController =
      TextEditingController();
  final TextEditingController plywoodWidthFeetController =
      TextEditingController();
  final TextEditingController plywoodWidthInchController =
      TextEditingController();

  final TextEditingController iceHeightFeetController = TextEditingController();
  final TextEditingController iceHeightInchController = TextEditingController();
  final TextEditingController iceWidthFeetController = TextEditingController();
  final TextEditingController iceWidthInchController = TextEditingController();

  final TextEditingController torchHeightFeetController =
      TextEditingController();
  final TextEditingController torchHeightInchController =
      TextEditingController();
  final TextEditingController torchWidthFeetController =
      TextEditingController();
  final TextEditingController torchWidthInchController =
      TextEditingController();

  final TextEditingController toughHeightFeetController =
      TextEditingController();
  final TextEditingController toughHeightInchController =
      TextEditingController();
  final TextEditingController toughWidthFeetController =
      TextEditingController();
  final TextEditingController toughWidthInchController =
      TextEditingController();

  List<TextEditingController> windowQuantityController = [];

  List<TextEditingController> windowSizeHeightFeetController = [];
  List<TextEditingController> windowSizeHeightInchController = [];
  List<TextEditingController> windowSizeWidthFeetController = [];
  List<TextEditingController> windowSizeWidthInchController = [];

  final TextEditingController doorMaterialController = TextEditingController();
  final TextEditingController doorMaterial1Controller = TextEditingController();
  final TextEditingController doorMaterial2Controller = TextEditingController();

  final TextEditingController doorQuantityController = TextEditingController();
  final TextEditingController doorQuantity1Controller = TextEditingController();
  final TextEditingController doorQuantity2Controller = TextEditingController();

  final TextEditingController doorSizeHeightFeetController =
      TextEditingController();
  final TextEditingController doorSizeHeightInchController =
      TextEditingController();
  final TextEditingController doorSizeWidthFeetController =
      TextEditingController();
  final TextEditingController doorSizeWidthInchController =
      TextEditingController();

  final TextEditingController doorSize1HeightFeetController =
      TextEditingController();
  final TextEditingController doorSize1HeightInchController =
      TextEditingController();
  final TextEditingController doorSize1WidthFeetController =
      TextEditingController();
  final TextEditingController doorSize1WidthInchController =
      TextEditingController();

  final TextEditingController doorSize2HeightFeetController =
      TextEditingController();
  final TextEditingController doorSize2HeightInchController =
      TextEditingController();
  final TextEditingController doorSize2WidthFeetController =
      TextEditingController();
  final TextEditingController doorSize2WidthInchController =
      TextEditingController();

  final TextEditingController eleMeterSizeController = TextEditingController();
  final TextEditingController elaMeterSwitchController =
      TextEditingController();
  final TextEditingController elaFloadingFeetController =
      TextEditingController();
  final TextEditingController elaFloadingInchController =
      TextEditingController();

  final TextEditingController plumingLengthFeetController =
      TextEditingController();
  final TextEditingController plumingLengthInchController =
      TextEditingController();

  final TextEditingController plumingServiceFeetController =
      TextEditingController();
  final TextEditingController plumingServiceInchController =
      TextEditingController();

  final TextEditingController plumingService1FeetController =
      TextEditingController();
  final TextEditingController plumingService1InchController =
      TextEditingController();

  Map<String, dynamic>? data = Map();
  var _userService = AssesmentService();

  List<String> typeList = [];
//List<String> type1List = [];
//List<String> type2List = [];
// List<String> windowList = [];
// List<String> window1List = [];
// List<String> window2List = [];
//List<String> locationList = [];
// List<String> location1List = [];
//List<String> location2List = [];
// List<String> doorTypeList = [];
// List<String> doorType1List = [];
// List<String> doorType2List = [];
//List<String> orientationList = [];
//  List<String> orientation1List = [];
// List<String> orientation2List = [];
// List<String> serviceEntList = [];
// List<String> servicePoleList = [];
//  List<String> yerornoList = [];
  List<String> groundRodList = [];
  List<String> groundClampList = [];
  List<String> groundWireList = [];
  List<String> groundWatersupplyList = [];
// List<String> groundWaterClosestList = [];
  List<String> servicePipeList = [];
  List<String> servicePipe1List = [];
  List<String> servicePipe2List = [];
  int noOfWindowForms = 1;
  int noOfPlumbingFields = 0;

  late AssesmentPage assesment;

  final ApiClient _apiClient = ApiClient();

  String? gender;

  List<DropListModel> firstDropDownList = [
    DropListModel("Plywood", "1"),
    DropListModel("Vinyl", "2"),
    DropListModel("Tounge & Groove T&G", "3"),
    //BankListDataModel("Canara","https://bankforms.org/wp-content/uploads/2019/10/Canara-Bank.png")
  ];

  List<DropListModel> secondDropDownList = [
    DropListModel("Architectural", "1"),
    DropListModel("Asphalt", "2"),
    DropListModel("Metal", "3"),
    DropListModel("Other", "4"),
  ];

  List<DropListModel> materialFirst = [
    DropListModel("Wood", "1"),
    DropListModel("Metal", "2"),
  ];

  List<DropListModel> materialSecond = [
    DropListModel("Wood", "1"),
    DropListModel("Metal", "2"),
  ];

  List<DropListModel> materialThird = [
    DropListModel("Wood", "1"),
    DropListModel("Metal", "2"),
  ];

  dynamic _currentSelectedValue;
  dynamic _currentSecondSelectedValue;
  dynamic _currentMeterial1SelectedValue;
  dynamic _currentMeterial2SelectedValue;
  dynamic _currentMeterial3SelectedValue;

  String _sofiTypeID = "";
  String _shinglesTypeID = "";
  String _materialId = "";
  String _materialId1 = "";
  String _materialId2 = "";

// final List<String> shinglesDropDown = [
//   "Architectural",
//   "Asphalt",
//   "Metal",
//   "Other",
// ];
  int _radioValue = 0;
  DropListModel? _bankChoose;

  String dropdownvalue = '';
  var items = [
    'Apple',
    'Banana',
    'Grapes',
    'Orange',
    'watermelon',
    'Pineapple'
  ];

  List<AssesmentDataBaseModel> testList = <AssesmentDataBaseModel>[];

  void _query(name) async {
    String en = jsonEncode(items);
    print("Encodeeeeeeeeee ${en}");

    List<dynamic> de = jsonDecode(en);

    print("Encodeeeeeeeeee ${de}");

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

      print("zczcxcxcxvcxcv ${testList[0].damageSnaps}");

      setState(() {
        evenFeetController.text = testList[0].eaveFlashingFeet!;
        evenInchController.text = testList[0].eaveFlashingInches!;
        evenSizeInchController.text = testList[0].eaveFlashingSize!;
        fasciaFeetController.text = testList[0].fasciaBoardFeet!;
        fasciaInchController.text = testList[0].fasciaBoardInches ?? "";
        fasciaSizeFeetController.text =
            testList[0].fasciaBoardSizeInchesOne ?? "";
        fasciaSizeInchController.text =
            testList[0].fasciaBoardSizeInchesTwo ?? "";
        soffitBoardFeetController.text = testList[0].soffitHeightFeet ?? "";
        soffitBoardInchController.text = testList[0].soffitHeightInches ?? "";
        soffitHeightFeetController.text = testList[0].soffitWidthFeet ?? "";
        soffitHeightInchController.text = testList[0].soffitWidthInches ?? "";
        _sofiTypeID = testList[0].soffitType ?? "";
        shinglesHeightFeetController.text =
            testList[0].shinglesHeightFeet ?? "";
        shinglesHeightInchController.text =
            testList[0].shinglesHeightInches ?? "";
        shinglesWidthFeetController.text = testList[0].shinglesWidthFeet ?? "";
        shinglesWidthInchController.text =
            testList[0].shinglesWidthInches ?? "";
        _shinglesTypeID = testList[0].shingleStyle ?? "";
        plywoodHeightFeetController.text = testList[0].plywoodHeightFeet ?? "";
        plywoodHeightInchController.text =
            testList[0].plywoodHeightInches ?? "";
        plywoodWidthFeetController.text = testList[0].plywoodWidthFeet ?? "";
        plywoodWidthInchController.text = testList[0].plywoodWidthInches ?? "";

        iceHeightFeetController.text = testList[0].iceAndWaterShieldHeightFeet!;
        iceHeightInchController.text =
            testList[0].iceAndWaterShieldHeightInches!;
        iceWidthFeetController.text = testList[0].iceAndWaterShieldWidthFeet!;
        iceWidthInchController.text = testList[0].iceAndWaterShieldWidthInches!;
        torchHeightFeetController.text = testList[0].torchOnHeightFeet!;
        torchHeightInchController.text = testList[0].torchOnHeightInches!;
        torchWidthFeetController.text = testList[0].torchOnWidthFeet!;
        torchWidthInchController.text = testList[0].torchOnWidthFeet!;
        toughHeightFeetController.text = testList[0].toughGuardHeightFeet!;
        toughHeightInchController.text = testList[0].toughGuardHeightInches!;
        toughWidthFeetController.text = testList[0].toughGuardWidthFeet!;
        toughWidthInchController.text = testList[0].toughGuardWidthInches!;

        windowSizeHeightFeetController[0].text =
            testList[0].sizeHeightFeet ?? '';
        windowQuantityController[0].text = testList[0].quantity ?? '';
        windowSizeHeightInchController[0].text =
            testList[0].sizeHeightInches ?? '';
        windowSizeWidthFeetController[0].text = testList[0].sizeWidthFeet ?? '';
        windowSizeWidthInchController[0].text =
            testList[0].sizeWidthInches ?? '';

        if (testList[0].sizeHeightFeetOne != null) {
          addTextController();
          setState(() {
            noOfWindowForms = 2;
          });
        }
        if (testList[0].sizeHeightFeetTwo != null) {
          addTextController();
          setState(() {
            noOfWindowForms = 3;
          });
        }
        windowSizeHeightFeetController.add(TextEditingController());
        windowQuantityController.add(TextEditingController());
        windowSizeHeightInchController.add(TextEditingController());
        windowSizeWidthFeetController.add(TextEditingController());
        windowSizeWidthInchController.add(TextEditingController());

        windowSizeHeightFeetController[1].text =
            testList[0].sizeHeightFeetOne ?? '';
        windowQuantityController[1].text = testList[0].quantityOne ?? '';
        windowSizeHeightInchController[1].text =
            testList[0].sizeHeightInchesOne ?? '';
        windowSizeWidthFeetController[1].text =
            testList[0].sizeWidthFeetOne ?? '';
        windowSizeWidthInchController[1].text =
            testList[0].sizeWidthInchesOne ?? '';

        windowSizeHeightFeetController.add(TextEditingController());
        windowQuantityController.add(TextEditingController());
        windowSizeHeightInchController.add(TextEditingController());
        windowSizeWidthFeetController.add(TextEditingController());
        windowSizeWidthInchController.add(TextEditingController());

        windowSizeHeightFeetController[2].text =
            testList[0].sizeHeightFeetTwo ?? '';
        windowQuantityController[2].text = testList[0].quantityTwo ?? '';
        windowSizeHeightInchController[2].text =
            testList[0].sizeHeightInchesTwo ?? '';
        windowSizeWidthFeetController[2].text =
            testList[0].sizeWidthFeetTwo ?? '';
        windowSizeWidthInchController[2].text =
            testList[0].sizeWidthInchesTwo ?? '';

        //  testList[0].type = typeList.toString();
        // testList[0].windowStyle = windowList.toString();

        //testList[0].location = locationList.toString();
        //testList[0].doorType = doorTypeList.toString();
        // testList[0].metirial = _materialId
        // testList[0].orientation = orientationList.toString();
        doorQuantityController.text = testList[0].doorQuantity!;
        doorSizeHeightFeetController.text = testList[0].doorSizeHeightFeet!;
        doorSizeHeightInchController.text = testList[0].doorSizeHeightInches!;
        doorSizeWidthFeetController.text = testList[0].doorSizeWidthFeet!;
        doorSizeWidthInchController.text = testList[0].doorSizeWidthInches!;

        //testList[0].locationOne = location1List.toString();
        // testList[0].doorTypeOne = doorType1List.toString();
        // testList[0].metirial = _materialId
        //testList[0].orientationOne = orientation1List.toString();
        doorQuantity1Controller.text = testList[0].doorQuantityOne!;
        doorSize1HeightFeetController.text = testList[0].doorSizeHeightFeetOne!;
        doorSize1HeightInchController.text =
            testList[0].doorSizeHeightInchesOne!;
        doorSize1WidthFeetController.text = testList[0].doorSizeWidthFeetOne!;
        doorSize1WidthInchController.text = testList[0].doorSizeWidthInchesOne!;

        //testList[0].locationTwo = location2List.toString();
        //testList[0].doorTypeTwo = doorType2List.toString();
        // testList[0].metirial = _materialId
        //testList[0].orientationTwo = orientation2List.toString();
        doorQuantity2Controller.text = testList[0].doorQuantityTwo!;
        doorSize2HeightFeetController.text = testList[0].doorSizeHeightFeetTwo!;
        doorSize2HeightInchController.text =
            testList[0].doorSizeHeightInchesTwo!;
        doorSize2WidthFeetController.text = testList[0].doorSizeWidthFeetTwo!;
        doorSize2WidthInchController.text = testList[0].doorSizeWidthInchesTwo!;

        //testList[0].serviceEntrance = serviceEntList.toString();
        //testList[0].servicePole = servicePoleList.toString();
        eleMeterSizeController.text = testList[0].meterCanSize!;
        elaMeterSwitchController.text = testList[0].meterSwitchSize!;
        // testList[0].interiorFlooding = yerornoList.toString();
        elaFloadingFeetController.text = testList[0].floodingHeightFeet!;
        elaFloadingInchController.text = testList[0].floodingHeightInches!;
        //testList[0].groundRod = groundRodList.toString();
        //testList[0].groundClamp = groundClampList.toString();
        //testList[0].groundWire = groundWireList.toString();
        // testList[0].waterSupply = groundWatersupplyList.toString();
        // testList[0].waterCloset = groundWaterClosestList.toString();
        // testList[0].s12ServicePipe = servicePipeList.toString();
        plumingLengthFeetController.text = testList[0].lengthOfDamageFeet!;
        plumingLengthInchController.text = testList[0].lengthOfDamageInches!;
        //testList[0].s34ServicePipe = servicePipe1List.toString();
        plumingServiceFeetController.text = testList[0].lengthOfDamageFeetOne!;
        plumingServiceInchController.text =
            testList[0].lengthOfDamageInchesOne!;
        //testList[0].s1ServicePipe = servicePipe2List.toString();
        plumingService1FeetController.text = testList[0].lengthOfDamageFeetTwo!;
        plumingService1InchController.text =
            testList[0].lengthOfDamageInchesTwo!;

        _updateDB = true;
        isLoading = false;
      });

      if (testList[0].soffitType != "") {
        for (int ii = 0; ii < firstDropDownList.length; ii++) {
          if (firstDropDownList[ii].id == testList[0].soffitType!) {
            setState(() {
              _sofiTypeID = testList[0].soffitType!;
              _currentSelectedValue = firstDropDownList[ii];
            });
          }
        }
      }

      if (testList[0].shingleStyle != "") {
        for (int ii = 0; ii < secondDropDownList.length; ii++) {
          if (secondDropDownList[ii].id == testList[0].shingleStyle!) {
            setState(() {
              _shinglesTypeID = testList[0].shingleStyle!;
              _currentSecondSelectedValue = secondDropDownList[ii];
            });
          }
        }
      }

      if (testList[0].material != "") {
        for (int ii = 0; ii < materialFirst.length; ii++) {
          if (materialFirst[ii].id == testList[0].material!) {
            setState(() {
              _materialId = testList[0].material!;
              _currentMeterial1SelectedValue = materialFirst[ii];
            });
          }
        }
      }

      if (testList[0].materialOne != "") {
        for (int ii = 0; ii < materialSecond.length; ii++) {
          if (materialSecond[ii].id == testList[0].materialOne!) {
            setState(() {
              _materialId1 = testList[0].materialOne!;
              _currentMeterial2SelectedValue = materialSecond[ii];
            });
          }
        }
      }

      if (testList[0].materialTwo != "") {
        for (int ii = 0; ii < materialThird.length; ii++) {
          if (materialThird[ii].id == testList[0].materialTwo!) {
            setState(() {
              _materialId2 = testList[0].materialTwo!;
              _currentMeterial3SelectedValue = materialThird[ii];
            });
          }
        }
      }

      if (testList[0].location != "") {
        //  List<dynamic> deLocationList = jsonDecode(testList[0].location!);

        //print("Encodeeeeeeeeee ${deLocationList}");

        // for (int ii = 0; ii < deLocationList.length; ii++) {
        if (testList[0].location == "INTERIOR") {
          setState(() {
            doorLocation = 'INTERIOR';
            doorLocationID = 1;
          });
        }

        if (testList[0].location == "EXTERIOR") {
          setState(() {
            doorLocation = 'EXTERIOR';
            doorLocationID = 2;
          });
        }
        // }
      }

      if (testList[0].locationOne != "") {
        //  List<dynamic> deLocation1List = jsonDecode(testList[0].locationOne!);

        //print("Encodeeeeeeeeee ${deLocation1List}");

        //  for (int ii = 0; ii < deLocation1List.length; ii++) {
        if (testList[0].locationOne == "INTERIOR") {
          setState(() {
            doorLocation1 = 'INTERIOR';
            doorLocationID1 = 1;
          });
        }

        if (testList[0].locationOne == "EXTERIOR") {
          setState(() {
            doorLocation1 = 'EXTERIOR';
            doorLocationID1 = 2;
          });
        }
        // }
      }

      if (testList[0].locationTwo != "") {
        //  List<dynamic> deLocation2List = jsonDecode(testList[0].locationTwo!);

        //  print("Encodeeeeeeeeee ${deLocation2List}");

        ///  for (int ii = 0; ii < deLocation2List.length; ii++) {
        if (testList[0].locationTwo == "INTERIOR") {
          setState(() {
            doorLocation2 = 'INTERIOR';
            doorLocationID2 = 1;
          });
        }

        if (testList[0].locationTwo == "EXTERIOR") {
          setState(() {
            doorLocation2 = 'EXTERIOR';
            doorLocationID2 = 2;
          });
        }
        // }
      }

      if (testList[0].doorType != "") {
        //  List<dynamic> deDoorTypeList = jsonDecode(testList[0].doorType!);

        //print("Encodeeeeeeeeee ${deDoorTypeList}");

        //for (int ii = 0; ii < deDoorTypeList.length; ii++) {
        if (testList[0].doorType == "SOLID CORE") {
          setState(() {
            doorType = 'SOLID CORE';
            doorTypeID = 1;
          });
        }

        if (testList[0].doorType == "HOLLOW CORE") {
          setState(() {
            doorType = 'HOLLOW CORE';
            doorTypeID = 2;
          });
        }
        //  }
      }

      if (testList[0].doorTypeOne != "") {
        //  List<dynamic> deDoorType1List = jsonDecode(testList[0].doorTypeOne!);

        //   print("Encodeeeeeeeeee ${deDoorType1List}");

        //   for (int ii = 0; ii < deDoorType1List.length; ii++) {
        if (testList[0].doorTypeOne == "SOLID CORE") {
          setState(() {
            doorType1 = 'SOLID CORE';
            doorTypeID1 = 1;
          });
        }

        if (testList[0].doorTypeOne == "HOLLOW CORE") {
          setState(() {
            doorType1 = 'HOLLOW CORE';
            doorTypeID1 = 2;
          });
        }
        //   }
      }

      if (testList[0].doorTypeTwo != "") {
        //  List<dynamic> deDoorType2List = jsonDecode(testList[0].doorTypeTwo!);

        //   print("Encodeeeeeeeeee ${deDoorType2List}");

        //  for (int ii = 0; ii < deDoorType2List.length; ii++) {
        if (testList[0].doorTypeTwo == "SOLID CORE") {
          setState(() {
            doorType2 = 'SOLID CORE';
            doorTypeID2 = 1;
          });
        }

        if (testList[0].doorTypeTwo == "HOLLOW CORE") {
          setState(() {
            doorType2 = 'HOLLOW CORE';
            doorTypeID2 = 2;
          });
        }
        //  }
      }

      if (testList[0].orientation != "") {
        // List<dynamic> deOrientationList = jsonDecode(testList[0].orientation!);

        //  print("Encodeeeeeeeeee ${deOrientationList}");

        //  for (int ii = 0; ii < deOrientationList.length; ii++) {
        if (testList[0].orientation == "LH - IN") {
          setState(() {
            doorOrientation = 'LH - IN';
            doorOrientationID = 1;
          });
        }

        if (testList[0].orientation == "LH - OUT") {
          setState(() {
            doorOrientation = 'LH - OUT';
            doorOrientationID = 2;
          });
        }

        if (testList[0].orientation == "RH - IN") {
          setState(() {
            doorOrientation = 'RH - IN';
            doorOrientationID = 3;
          });
        }

        if (testList[0].orientation == "RH - OUT") {
          setState(() {
            doorOrientation = 'RH - OUT';
            doorOrientationID = 4;
          });
        }

        // }
      }

      //=====================================================================================================================
      if (testList[0].type != "") {
        //List<dynamic> deTypeList = jsonDecode(testList[0].type!);

        //  print("Encodeeeeeeeeee ${deTypeList}");

        //for (int ii = 0; ii < deTypeList.length; ii++) {
        if (testList[0].type == "NON-IMPACT") {
          setState(() {
            windowtype[0] = 'NON-IMPACT';
            windowtypeid[0] = 1;
          });
        }

        if (testList[0].type == "HURRICANE IMPACT") {
          setState(() {
            windowtype[0] = 'HURRICANE IMPACT';
            windowtypeid[0] = 2;
          });
        }
        // }
      }

      if (testList[0].typeOne != "") {
        //List<dynamic> deTypeList = jsonDecode(testList[0].type!);

        //  print("Encodeeeeeeeeee ${deTypeList}");

        //for (int ii = 0; ii < deTypeList.length; ii++) {
        if (testList[0].typeOne == "NON-IMPACT") {
          setState(() {
            windowtype[1] = 'NON-IMPACT';
            windowtypeid[1] = 1;
          });
        }

        if (testList[0].typeOne == "HURRICANE IMPACT") {
          setState(() {
            windowtype[1] = 'HURRICANE IMPACT';
            windowtypeid[1] = 2;
          });
        }
        // }
      }

      if (testList[0].colonialStyle != "") {
        //List<dynamic> deTypeList = jsonDecode(testList[0].type!);

        //  print("Encodeeeeeeeeee ${deTypeList}");

        //for (int ii = 0; ii < deTypeList.length; ii++) {
        if (testList[0].colonialStyle == "COLONIAL") {
          setState(() {
            windowColonialStyle[0] = 'COLONIAL';
            windowtypeColonialStyleID[0] = 1;
          });
        }

        if (testList[0].colonialStyle == "NON-COLONIAL") {
          setState(() {
            windowColonialStyle[0] = 'NON-COLONIAL';
            windowtypeColonialStyleID[0] = 2;
          });
        }
        // }
      }

      if (testList[0].colonialStyleOne != "") {
        //List<dynamic> deTypeList = jsonDecode(testList[0].type!);

        //  print("Encodeeeeeeeeee ${deTypeList}");

        //for (int ii = 0; ii < deTypeList.length; ii++) {
        if (testList[0].colonialStyleOne == "COLONIAL") {
          setState(() {
            windowColonialStyle[1] = 'COLONIAL';
            windowtypeColonialStyleID[1] = 1;
          });
        }

        if (testList[0].colonialStyleOne == "NON-COLONIAL") {
          setState(() {
            windowColonialStyle[1] = 'NON-COLONIAL';
            windowtypeColonialStyleID[1] = 2;
          });
        }
        // }
      }

      if (testList[0].windowStyle != "") {
        //List<dynamic> deTypeList = jsonDecode(testList[0].type!);

        //  print("Encodeeeeeeeeee ${deTypeList}");

        //for (int ii = 0; ii < deTypeList.length; ii++) {
        if (testList[0].windowStyle == "AWNING") {
          setState(() {
            windowStyle[0] = 'AWNING';
            windowStyleID[0] = 1;
          });
        }

        if (testList[0].windowStyle == "SLIDER") {
          setState(() {
            windowStyle[0] = 'SLIDER';
            windowStyleID[0] = 2;
          });
        }
        if (testList[0].windowStyle == "COLONIAL") {
          setState(() {
            windowStyle[0] = 'COLONIAL';
            windowStyleID[0] = 3;
          });
        }
        if (testList[0].windowStyle == "PUSH UP") {
          setState(() {
            windowStyle[0] = 'PUSH UP';
            windowStyleID[0] = 4;
          });
        }
        // }
      }
      if (testList[0].windowStyle != "") {
        //List<dynamic> deTypeList = jsonDecode(testList[0].type!);

        //  print("Encodeeeeeeeeee ${deTypeList}");

        //for (int ii = 0; ii < deTypeList.length; ii++) {
        if (testList[0].windowStyleOne == "AWNING") {
          setState(() {
            windowStyle[1] = 'AWNING';
            windowStyleID[1] = 1;
          });
        }

        if (testList[0].windowStyleOne == "SLIDER") {
          setState(() {
            windowStyle[1] = 'SLIDER';
            windowStyleID[1] = 2;
          });
        }
        if (testList[0].windowStyleOne == "COLONIAL") {
          setState(() {
            windowStyle[1] = 'COLONIAL';
            windowStyleID[1] = 3;
          });
        }
        if (testList[0].windowStyleOne == "PUSH UP") {
          setState(() {
            windowStyle[1] = 'PUSH UP';
            windowStyleID[1] = 4;
          });
        }
        // }
      }
      if (testList[0].typeTwo != "") {
        //List<dynamic> deTypeList = jsonDecode(testList[0].type!);

        //  print("Encodeeeeeeeeee ${deTypeList}");

        //for (int ii = 0; ii < deTypeList.length; ii++) {
        if (testList[0].typeTwo == "NON-IMPACT") {
          setState(() {
            windowtype[2] = 'NON-IMPACT';
            windowtypeid[2] = 1;
          });
        }

        if (testList[0].typeTwo == "HURRICANE IMPACT") {
          setState(() {
            windowtype[2] = 'HURRICANE IMPACT';
            windowtypeid[2] = 2;
          });
        }
        // }
      }
      if (testList[0].colonialStyleTwo != "") {
        //List<dynamic> deTypeList = jsonDecode(testList[0].type!);

        //  print("Encodeeeeeeeeee ${deTypeList}");

        //for (int ii = 0; ii < deTypeList.length; ii++) {
        if (testList[0].colonialStyleTwo == "COLONIAL") {
          setState(() {
            windowColonialStyle[2] = 'COLONIAL';
            windowtypeColonialStyleID[2] = 1;
          });
        }

        if (testList[0].colonialStyleTwo == "NON-COLONIAL") {
          setState(() {
            windowColonialStyle[2] = 'NON-COLONIAL';
            windowtypeColonialStyleID[2] = 2;
          });
        }
        // }
      }

      if (testList[0].windowStyleTwo != "") {
        //List<dynamic> deTypeList = jsonDecode(testList[0].type!);

        //  print("Encodeeeeeeeeee ${deTypeList}");

        //for (int ii = 0; ii < deTypeList.length; ii++) {
        if (testList[0].windowStyleTwo == "AWNING") {
          setState(() {
            windowStyle[2] = 'AWNING';
            windowStyleID[2] = 1;
          });
        }

        if (testList[0].windowStyleTwo == "SLIDER") {
          setState(() {
            windowStyle[2] = 'SLIDER';
            windowStyleID[2] = 2;
          });
        }
        if (testList[0].windowStyleTwo == "COLONIAL") {
          setState(() {
            windowStyle[2] = 'COLONIAL';
            windowStyleID[2] = 3;
          });
        }
        if (testList[0].windowStyleTwo == "PUSH UP") {
          setState(() {
            windowStyle[2] = 'PUSH UP';
            windowStyleID[2] = 4;
          });
        }
        // }
      }

      if (testList[0].orientationOne != "") {
        // List<dynamic> deOrientation1List = jsonDecode(testList[0].orientationOne!);

        //  print("Encodeeeeeeeeee ${deOrientation1List}");

        // for (int ii = 0; ii < deOrientation1List.length; ii++) {
        if (testList[0].orientationOne == "LH - IN") {
          setState(() {
            doorOrientation1 = 'LH - IN';
            doorOrientationID1 = 1;
          });
        }

        if (testList[0].orientationOne == "LH - OUT") {
          setState(() {
            doorOrientation1 = 'LH - OUT';
            doorOrientationID1 = 2;
          });
        }

        if (testList[0].orientationOne == "RH - IN") {
          setState(() {
            doorOrientation1 = 'RH - IN';
            doorOrientationID1 = 3;
          });
        }

        if (testList[0].orientationOne == "RH - OUT") {
          setState(() {
            doorOrientation1 = 'RH - OUT';
            doorOrientationID1 = 4;
          });
        }

        //}
      }

      if (testList[0].orientationTwo != "") {
        // List<dynamic> deOrientation2List = jsonDecode(testList[0].orientationTwo!);

        // print("Encodeeeeeeeeee ${deOrientation2List}");

        // for (int ii = 0; ii < deOrientation2List.length; ii++) {
        if (testList[0].orientationTwo == "LH - IN") {
          setState(() {
            doorOrientation2 = 'LH - IN';
            doorOrientationID2 = 1;
          });
        }

        if (testList[0].orientationTwo == "LH - OUT") {
          setState(() {
            doorOrientation2 = 'LH - OUT';
            doorOrientationID2 = 2;
          });
        }

        if (testList[0].orientationTwo == "RH - IN") {
          setState(() {
            doorOrientation2 = 'RH - IN';
            doorOrientationID2 = 3;
          });
        }

        if (testList[0].orientationTwo == "RH - OUT") {
          setState(() {
            doorOrientation2 = 'RH - OUT';
            doorOrientationID2 = 4;
          });
        }

        // }
      }

      if (testList[0].serviceEntrance != "") {
        //List<dynamic> deServiceEntranceList = jsonDecode(testList[0].serviceEntrance!);

        // print("Encodeeeeeeeeee ${deServiceEntranceList}");

        // for (int ii = 0; ii < deServiceEntranceList.length; ii++) {
        if (testList[0].serviceEntrance == "Needs Repair") {
          setState(() {
            electricalEntrance = 'Needs Repair';
            electricalEntranceID = 1;
          });
        }

        if (testList[0].serviceEntrance == "Needs Replacement") {
          setState(() {
            electricalEntrance = 'Needs Replacement';
            electricalEntranceID = 2;
          });
        }
        // }
      }

      if (testList[0].servicePole != "") {
        // List<dynamic> deServicePoleList = jsonDecode(testList[0].servicePole!);

        // print("Encodeeeeeeeeee ${deServicePoleList}");

        // for (int ii = 0; ii < deServicePoleList.length; ii++) {
        if (testList[0].servicePole == "Needs Repair") {
          setState(() {
            electricalPole = 'Needs Repair';
            electricalPoleID = 1;
          });
        }

        if (testList[0].servicePole == "Needs Replacement") {
          setState(() {
            electricalPole = 'Needs Replacement';
            electricalPoleID = 2;
          });
        }
        // }
      }

      if (testList[0].interiorFlooding != "") {
        //  List<dynamic> deInteriorFloodingList = jsonDecode(testList[0].interiorFlooding!);

        //  print("Encodeeeeeeeeee ${deInteriorFloodingList}");

        // for (int ii = 0; ii < deInteriorFloodingList.length; ii++) {
        if (testList[0].interiorFlooding == "Yes") {
          setState(() {
            electricalInterior = 'Yes';
            electricalInteriorID = 1;
          });
        }

        if (testList[0].interiorFlooding == "No") {
          setState(() {
            electricalInterior = 'No';
            electricalInteriorID = 1;
          });
        }
        // }
      }

      if (testList[0].groundRod != "") {
        List<dynamic> deGroundRodList = jsonDecode(testList[0].groundRod!);

        print("Encodeeeeeeeeee ${deGroundRodList}");

        for (int ii = 0; ii < deGroundRodList.length; ii++) {
          if (deGroundRodList[ii] == "Needs Replacement") {
            setState(() {
              // electricalInterior = 'Needs Replacement';
              eleGroundRod = true;
            });
          }
        }
      }

      if (testList[0].groundClamp != "") {
        List<dynamic> deGroundClampList = jsonDecode(testList[0].groundClamp!);

        print("Encodeeeeeeeeee ${deGroundClampList}");

        for (int ii = 0; ii < deGroundClampList.length; ii++) {
          if (deGroundClampList[ii] == "Needs Replacement") {
            setState(() {
              // electricalInterior = 'Needs Replacement';
              eleGroundClamp = true;
            });
          }
        }
      }

      if (testList[0].groundWire != "") {
        List<dynamic> deGroundWireList = jsonDecode(testList[0].groundWire!);

        print("Encodeeeeeeeeee ${deGroundWireList}");

        for (int ii = 0; ii < deGroundWireList.length; ii++) {
          if (deGroundWireList[ii] == "Needs Replacement") {
            setState(() {
              // electricalInterior = 'Needs Replacement';
              eleGroundwire = true;
            });
          }
        }
      }

      if (testList[0].waterSupply != "") {
        List<dynamic> deWaterSupplyList = jsonDecode(testList[0].waterSupply!);

        print("Encodeeeeeeeeee ${deWaterSupplyList}");

        for (int ii = 0; ii < deWaterSupplyList.length; ii++) {
          if (deWaterSupplyList[ii] == "Needs Repair") {
            setState(() {
              // electricalInterior = 'Needs Replacement';
              plumingwater = true;
            });
          }
        }
      }

      if (testList[0].waterCloset != "") {
        //  List<dynamic> deWaterClosetList = jsonDecode(testList[0].waterCloset!);

        // print("Encodeeeeeeeeee ${deWaterClosetList}");

        //  for (int ii = 0; ii < deWaterClosetList.length; ii++) {
        if (testList[0].waterCloset == "Needs Repair") {
          setState(() {
            // electricalInterior = 'Needs Replacement';
            plumbingwaterID = 1;
            plumbingwater = "Needs Repair";
          });
        }

        if (testList[0].waterCloset == "Needs Replacement") {
          setState(() {
            plumbingwaterID = 2;
            plumbingwater = "Needs Replacement";
          });
        }
        // }
      }

      if (testList[0].s12ServicePipe != "") {
        List<dynamic> deS12ServicePipeList =
            jsonDecode(testList[0].s12ServicePipe!);

        print("Encodeeeeeeeeee ${deS12ServicePipeList}");

        for (int ii = 0; ii < deS12ServicePipeList.length; ii++) {
          if (deS12ServicePipeList[ii] == "Needs Repair") {
            setState(() {
              // electricalInterior = 'Needs Replacement';
              plumingservicePipe1 = true;
            });
          }
        }
      }

      if (testList[0].s34ServicePipe != "") {
        List<dynamic> deS34ServicePipeList =
            jsonDecode(testList[0].s34ServicePipe!);

        print("Encodeeeeeeeeee ${deS34ServicePipeList}");

        for (int ii = 0; ii < deS34ServicePipeList.length; ii++) {
          if (deS34ServicePipeList[ii] == "Needs Repair") {
            setState(() {
              // electricalInterior = 'Needs Replacement';
              plumingservicePipe2 = true;
            });
          }
        }
      }

      if (testList[0].s1ServicePipe != "") {
        List<dynamic> deS1ServicePipeList =
            jsonDecode(testList[0].s1ServicePipe!);

        print("Encodeeeeeeeeee ${deS1ServicePipeList}");

        for (int ii = 0; ii < deS1ServicePipeList.length; ii++) {
          if (deS1ServicePipeList[ii] == "Needs Repair") {
            setState(() {
              // electricalInterior = 'Needs Replacement';
              plumingservicePipe3 = true;
            });
          }
        }
      }
//============================================
//       if (testList[0].type != "") {
//
//         //  List<dynamic> deLocation1List = jsonDecode(testList[0].locationOne!);
//
//         //print("Encodeeeeeeeeee ${deLocation1List}");
//
//         //  for (int ii = 0; ii < deLocation1List.length; ii++) {
//         if (testList[0].type == "NON-IMPACT") {
//           setState(() {
//             windowtype;
//             windowtypeid;
//           });
//         }
//
//         if (testList[0].type == "HURRICANE IMPACT") {
//           setState(() {
//             windowtype;
//             windowtypeid;
//           });
//         }
//         // }
//       }

      print("Test =========       ${testList[0].type}");

      print("dfdafadfdaf ${testList[0].requestKey}");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    evenFeetController = TextEditingController();
    // fetchData();
    addTextController();
    addPlumbingController();
    _query(widget.ids);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    // evenFeetController.dispose();
    // evenInchController.dispose();
    // fasciaFeetController.dispose();
    // fasciaInchController.dispose();
    //
    // soffitBoardFeetController.dispose();
    // soffitBoardInchController.dispose();
    // soffitHeightFeetController.dispose();
    // soffitHeightInchController.dispose();
    //
    // shinglesHeightFeetController.dispose();
    // shinglesHeightInchController.dispose();
    // shinglesWidthFeetController.dispose();
    // shinglesWidthInchController.dispose();
    //
    // plywoodHeightFeetController.dispose();
    // plywoodHeightInchController.dispose();
    // plywoodWidthFeetController.dispose();
    // plywoodWidthInchController.dispose();
    //
    // iceHeightFeetController.dispose();
    // iceHeightInchController.dispose();
    // iceWidthFeetController.dispose();
    // iceWidthInchController.dispose();
    //
    // torchHeightFeetController.dispose();
    // torchHeightInchController.dispose();
    // torchWidthFeetController.dispose();
    // torchWidthInchController.dispose();
    //
    // toughHeightFeetController.dispose();
    // toughHeightInchController.dispose();
    // toughWidthFeetController.dispose();
    // toughWidthInchController.dispose();
    //
    // windowQuantityController.dispose();
    // windowQuantity1Controller.dispose();
    // windowQuantity2Controller.dispose();
    //
    // windowSizeHeightFeetController.dispose();
    // windowSizeHeightInchController.dispose();
    // windowSizeWidthFeetController.dispose();
    // windowSizeWidthInchController.dispose();
    //
    // windowSize1HeightFeetController.dispose();
    // windowSize1HeightInchController.dispose();
    // windowSize1WidthFeetController.dispose();
    // windowSize1WidthInchController.dispose();
    //
    // windowSize2HeightFeetController.dispose();
    // windowSize2HeightInchController.dispose();
    // windowSize2WidthFeetController.dispose();
    // windowSize2WidthInchController.dispose();
    //
    // doorMaterialController.dispose();
    // doorMaterial1Controller.dispose();
    // doorMaterial2Controller.dispose();
    //
    // doorQuantityController.dispose();
    // doorQuantity1Controller.dispose();
    // doorQuantity2Controller.dispose();
    //
    // doorSizeHeightFeetController.dispose();
    // doorSizeHeightInchController.dispose();
    //
    // doorSizeWidthFeetController.dispose();
    //
    // doorSizeWidthInchController.dispose();
    //
    // doorSize1HeightFeetController.dispose();
    // doorSize1HeightInchController.dispose();
    // doorSize1WidthFeetController.dispose();
    // doorSize1WidthInchController.dispose();
    //
    // doorSize2HeightFeetController.dispose();
    // doorSize2HeightInchController.dispose();
    // doorSize2WidthFeetController.dispose();
    // doorSize2WidthInchController.dispose();
    //
    // eleMeterSizeController.dispose();
    // elaMeterSwitchController.dispose();
    //
    // elaFloadingFeetController.dispose();
    // elaFloadingInchController.dispose();
    //
    // plumingLengthFeetController.dispose();
    // plumingLengthInchController.dispose();
    //
    // plumingServiceFeetController.dispose();
    // plumingServiceInchController.dispose();
    //
    // plumingService1FeetController.dispose();
    // plumingService1InchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(child: const CircularProgressIndicator())
          : ListView(controller: _controller, children: [
              Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 30,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            color: Color(0xff16698C),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Roof Damage',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'San Francisco',
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: const Text(
                          'Eave Flashing length of damage',
                          style: TextStyle(
                              color: Color(0xff16698C),
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: evenFeetController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    label: const Text('Feet'),
                                    //      hintText: 'Feet',
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff808B9E),
                                        fontFamily: 'San Francisco'),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color(0xffF2F2F2),
                                    )),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: evenInchController,
                                  decoration: const InputDecoration(
                                    //  hintText: 'Inches',
                                    label: const Text('Inches'),
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff808B9E),
                                        fontFamily: 'San Francisco'),
                                    border: const OutlineInputBorder(
                                        borderSide: const BorderSide(
                                      color: Color(0xffF2F2F2),
                                    )),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              )),
                            ],
                          )),

                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: const Text(
                          'Eave Flashing Size',
                          style: TextStyle(
                              color: Color(0xff16698C),
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              /* Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: fasciaFeetController,
                            decoration: InputDecoration(
                              //  hintText: 'Feet',
                              label: Text('Feet'),
                              labelStyle: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff808B9E),
                                  fontFamily: 'San Francisco'),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                        ),*/
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: evenSizeInchController,
                                  decoration: const InputDecoration(
                                    // hintText: 'Inches',
                                    label: Text('Inches'),
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff808B9E),
                                        fontFamily: 'San Francisco'),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color(0xffF2F2F2),
                                    )),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              )),
                            ],
                          )),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: const Text(
                          'Fascia Board length of damage',
                          style: TextStyle(
                              color: Color(0xff16698C),
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: fasciaFeetController,
                                  decoration: const InputDecoration(
                                    //  hintText: 'Feet',
                                    label: Text('Feet'),
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff808B9E),
                                        fontFamily: 'San Francisco'),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color(0xffF2F2F2),
                                    )),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: fasciaInchController,
                                  decoration: const InputDecoration(
                                    // hintText: 'Inches',
                                    label: Text('Inches'),
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff808B9E),
                                        fontFamily: 'San Francisco'),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color(0xffF2F2F2),
                                    )),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              )),
                            ],
                          )),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Fascia Board Size',
                          style: TextStyle(
                              color: Color(0xff16698C),
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: fasciaSizeFeetController,
                                  decoration: const InputDecoration(
                                    //  hintText: 'Feet',
                                    label: Text('Inches'),
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff808B9E),
                                        fontFamily: 'San Francisco'),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color(0xffF2F2F2),
                                    )),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: fasciaSizeInchController,
                                  decoration: const InputDecoration(
                                    // hintText: 'Inches',
                                    label: Text('Inches'),
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff808B9E),
                                        fontFamily: 'San Francisco'),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color(0xffF2F2F2),
                                    )),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              )),
                            ],
                          )),

                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Soffit Type',
                          style: TextStyle(
                              color: Color(0xff16698C),
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),

                      // DropdownButton(
                      //   value: dropdownvalue.isNotEmpty ? dropdownvalue : null,
                      //   icon: Icon(Icons.keyboard_arrow_down),
                      //   hint: Text(
                      //     "Choose",
                      //     style: TextStyle(
                      //         color: Colors.black,
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w400),
                      //   ),
                      //   items:items.map((String items) {
                      //     return DropdownMenuItem(
                      //         value: items,
                      //         child: Text(items)
                      //     );
                      //   }
                      //   ).toList(),
                      //   onChanged: (String? newValue){
                      //     setState(() {
                      //       dropdownvalue = newValue!;
                      //     });
                      //   },
                      // ),

                      Container(
                        margin:
                            const EdgeInsets.only(left: 15, top: 10, right: 15),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38)),
                        child: DropdownButtonFormField<DropListModel>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          value: _currentSelectedValue,
                          //elevation: 5,
                          style: const TextStyle(color: Colors.black),

                          items: firstDropDownList
                              .map<DropdownMenuItem<DropListModel>>(
                                  (DropListModel value) {
                            return DropdownMenuItem<DropListModel>(
                              value: value,
                              child: Text(value.name),
                            );
                          }).toList(),
                          hint: const Text(
                            "Choose",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          onChanged: (DropListModel? value) {
                            setState(() {
                              _sofiTypeID = value!.id;
                              _currentSelectedValue = value;
                              print("SSSSSSSSSS ${_currentSelectedValue}");
                            });
                          },
                          isExpanded: true,
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Soffit',
                          style: TextStyle(
                              color: Color(0xff16698C),
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: soffitBoardFeetController,
                                decoration: const InputDecoration(
                                  //  hintText: 'Height-Feet',
                                  label: Text('Length-Feet'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: soffitBoardInchController,
                                    decoration: const InputDecoration(
                                      //  hintText: 'Height-Inches',
                                      label: Text('Length-Inches'),
                                      labelStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff808B9E),
                                          fontFamily: 'San Francisco'),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xffF2F2F2),
                                      )),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'This field is required';
                                      }
                                      return null;
                                    },
                                  )),
                            )
                          ])),

                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: soffitHeightFeetController,
                                decoration: const InputDecoration(
                                  //  hintText: 'Width-Feet',
                                  label: Text('Width-Feet'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: soffitHeightInchController,
                                    decoration: const InputDecoration(
                                      //  hintText: 'Width-Inches',
                                      label: Text('Width-Inches'),
                                      labelStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff808B9E),
                                          fontFamily: 'San Francisco'),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xffF2F2F2),
                                      )),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'This field is required';
                                      }
                                      return null;
                                    },
                                  )),
                            )
                          ])),

                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Shingle Styles',
                          style: TextStyle(
                              color: Color(0xff16698C),
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 15, top: 10, right: 15),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38)),
                        child: DropdownButtonFormField<DropListModel>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          value: _currentSecondSelectedValue,
                          //elevation: 5,
                          style: const TextStyle(color: Colors.black),

                          items: secondDropDownList
                              .map<DropdownMenuItem<DropListModel>>(
                                  (DropListModel value) {
                            return DropdownMenuItem<DropListModel>(
                              value: value,
                              child: Text(value.name),
                            );
                          }).toList(),
                          hint: const Text(
                            "Choose",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          onChanged: (DropListModel? value) {
                            setState(() {
                              _shinglesTypeID = value!.id;
                              _currentSecondSelectedValue = value;
                            });
                          },
                          isExpanded: true,
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Shingle',
                          style: TextStyle(
                              color: Color(0xff16698C),
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: shinglesHeightFeetController,
                                decoration: const InputDecoration(
                                  // hintText: 'Height-Feet',
                                  label: Text('Length-Feet'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: shinglesHeightInchController,
                                    decoration: const InputDecoration(
                                      //  hintText: 'Height-Inches',
                                      label: Text('Length-Inches'),
                                      labelStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff808B9E),
                                          fontFamily: 'San Francisco'),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xffF2F2F2),
                                      )),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'This field is required';
                                      }
                                      return null;
                                    },
                                  )),
                            )
                          ])),

                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: shinglesWidthFeetController,
                                decoration: const InputDecoration(
                                  //  hintText: 'Width-Feet',
                                  label: Text('Width-Feet'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: shinglesWidthInchController,
                                    decoration: const InputDecoration(
                                      //  hintText: 'Width-Inches',
                                      label: Text('Width-Inches'),
                                      labelStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff808B9E),
                                          fontFamily: 'San Francisco'),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xffF2F2F2),
                                      )),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'This field is required';
                                      }
                                      return null;
                                    },
                                  )),
                            )
                          ])),

                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Plywood',
                          style: TextStyle(
                              color: Color(0xff16698C),
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: plywoodHeightFeetController,
                                decoration: const InputDecoration(
                                  // hintText: 'Height-Feet',
                                  label: Text('Length-Feet'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: const Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: plywoodHeightInchController,
                                    decoration: const InputDecoration(
                                      //  hintText: 'Height-Inches',
                                      label: Text('Length-Inches'),
                                      labelStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff808B9E),
                                          fontFamily: 'San Francisco'),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xffF2F2F2),
                                      )),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'This field is required';
                                      }
                                      return null;
                                    },
                                  )),
                            )
                          ])),

                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: plywoodWidthFeetController,
                                decoration: const InputDecoration(
                                  // hintText: 'Width-Feet',
                                  label: Text('Width-Feet'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: plywoodWidthInchController,
                                    decoration: const InputDecoration(
                                      // hintText: 'Width-Inches',
                                      label: Text('Width-Inches'),
                                      labelStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff808B9E),
                                          fontFamily: 'San Francisco'),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xffF2F2F2),
                                      )),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'This field is required';
                                      }
                                      return null;
                                    },
                                  )),
                            )
                          ])),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Ice & Water Shield',
                          style: TextStyle(
                              color: Color(0xff16698C),
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: iceHeightFeetController,
                                decoration: const InputDecoration(
                                  // hintText: 'Height-Feet',
                                  label: Text('Length-Feet'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: iceHeightInchController,
                                decoration: const InputDecoration(
                                  // hintText: 'Height-Inches',
                                  label: const Text('Length-Inches'),
                                  labelStyle: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ))
                          ])),

                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: iceWidthFeetController,
                                decoration: const InputDecoration(
                                  // hintText: 'Width-Feet',
                                  label: Text('Width-Feet'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                    color: const Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: iceWidthInchController,
                                decoration: const InputDecoration(
                                  //  hintText: 'Width-Inches',
                                  label: Text('Width-Inches'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ))
                          ])),

                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Tough Guard',
                          style: TextStyle(
                              color: Color(0xff16698C),
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: toughHeightFeetController,
                                decoration: const InputDecoration(
                                  // hintText: 'Height-Feet',
                                  label: Text('Length-Feet'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: toughHeightInchController,
                                decoration: const InputDecoration(
                                  // hintText: 'Height-Inches',
                                  label: Text('Length-Inches'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ))
                          ])),

                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: toughWidthFeetController,
                                decoration: const InputDecoration(
                                  // hintText: 'Width-Feet',
                                  label: Text('Width-Feet'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: toughWidthInchController,
                                    decoration: const InputDecoration(
                                      // hintText: 'Width-Inches',
                                      label: Text('Width-Inches'),
                                      labelStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff808B9E),
                                          fontFamily: 'San Francisco'),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                        color: const Color(0xffF2F2F2),
                                      )),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'This field is required';
                                      }
                                      return null;
                                    },
                                  )),
                            )
                          ])),

                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Torch On',
                          style: TextStyle(
                              color: Color(0xff16698C),
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: torchHeightFeetController,
                                decoration: const InputDecoration(
                                  // hintText: 'Height-Feet',
                                  label: Text('Length-Feet'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: torchHeightInchController,
                                decoration: const InputDecoration(
                                  // hintText: 'Height-Inches',
                                  label: Text('Length-Inches'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ))
                          ])),

                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: torchWidthFeetController,
                                decoration: const InputDecoration(
                                  // hintText: 'Width-Feet',
                                  label: Text('Width-Feet'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: torchWidthInchController,
                                decoration: const InputDecoration(
                                  //  hintText: 'Width-Inches',
                                  label: Text('Width-Inches'),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff808B9E),
                                      fontFamily: 'San Francisco'),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xffF2F2F2),
                                  )),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ))
                          ])),

                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 5),
                              child: Container(
                                height: 30,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                  color: Color(0xff16698C),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Window',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'San Francisco',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            Column(
                              children: List.generate(noOfWindowForms, (i) {
                                return dynmaicFields(context, i);
                              }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Container(
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),
                                        color: Color(0xff16698C),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Door',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'San Francisco',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),

                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.0, bottom: 1, top: 5),
                                    child: Text(
                                      'Location',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff16698C),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'San Francisco'),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Radio(
                                          value: 1,
                                          groupValue: doorLocationID,
                                          onChanged: (val) {
                                            setState(() {
                                              doorLocation = 'INTERIOR';
                                              doorLocationID = 1;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Interior',
                                          style: new TextStyle(fontSize: 12.0),
                                        ),
                                        Radio(
                                          value: 2,
                                          groupValue: doorLocationID,
                                          onChanged: (val) {
                                            setState(() {
                                              doorLocation = 'EXTERIOR';
                                              doorLocationID = 2;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Exterior',
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Padding(
                                  //     padding: EdgeInsets.only(left: 10),
                                  //     child: Row(
                                  //       children: <Widget>[
                                  //         Checkbox(
                                  //           value: this.locationInterior,
                                  //           onChanged: (bool? value) {
                                  //             setState(() {
                                  //               this.locationInterior = value!;
                                  //             });
                                  //           },
                                  //         ),
                                  //         Text(
                                  //           'INTERIOR',
                                  //           style: TextStyle(fontSize: 12.0),
                                  //         ),
                                  //         Checkbox(
                                  //           value: this.locationExterrior,
                                  //           onChanged: (bool? value) {
                                  //             setState(() {
                                  //               this.locationExterrior = value!;
                                  //             });
                                  //           },
                                  //         ),
                                  //         Text(
                                  //           'EXTERIOR',
                                  //           style: TextStyle(fontSize: 12.0),
                                  //         ),
                                  //       ],
                                  //     )),

                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.0, bottom: 1, top: 5),
                                    child: Text(
                                      'Type',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff16698C),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'San Francisco'),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Radio(
                                          value: 1,
                                          groupValue: doorTypeID,
                                          onChanged: (val) {
                                            setState(() {
                                              doorType = 'SOLID CORE';
                                              doorTypeID = 1;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Solid Core',
                                          style: new TextStyle(fontSize: 12.0),
                                        ),
                                        Radio(
                                          value: 2,
                                          groupValue: doorTypeID,
                                          onChanged: (val) {
                                            setState(() {
                                              doorType = 'HOLLOW CORE';
                                              doorTypeID = 2;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Hollow Core',
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Padding(
                                  //   padding: const EdgeInsets.only(left: 10.0),
                                  //   child: Column(
                                  //     children: [
                                  //       Row(
                                  //         children: <Widget>[
                                  //           Checkbox(
                                  //             value: this.locationSolidCore,
                                  //             onChanged: (bool? value) {
                                  //               setState(() {
                                  //                 this.locationSolidCore = value!;
                                  //               });
                                  //             },
                                  //           ),
                                  //           Text(
                                  //             'SOLID CORE',
                                  //             style: TextStyle(fontSize: 12.0),
                                  //           ),
                                  //           Checkbox(
                                  //             value: this.locationHollow,
                                  //             onChanged: (bool? value) {
                                  //               setState(() {
                                  //                 this.locationHollow = value!;
                                  //               });
                                  //             },
                                  //           ),
                                  //           Text(
                                  //             'HOLLOW CORE',
                                  //             style: TextStyle(fontSize: 12.0),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),

                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 16.0, top: 5),
                                    child: Text(
                                      'Material',
                                      style: TextStyle(
                                          color: Color(0xff16698C),
                                          fontFamily: 'San Francisco',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),

                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 15, top: 10, right: 15),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black38)),
                                    child:
                                        DropdownButtonFormField<DropListModel>(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                      value: _currentMeterial1SelectedValue,
                                      //elevation: 5,
                                      style:
                                          const TextStyle(color: Colors.black),

                                      items: materialFirst
                                          .map<DropdownMenuItem<DropListModel>>(
                                              (DropListModel value) {
                                        return DropdownMenuItem<DropListModel>(
                                          value: value,
                                          child: Text(value.name),
                                        );
                                      }).toList(),
                                      hint: const Text(
                                        "Choose",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      onChanged: (DropListModel? value) {
                                        setState(() {
                                          _materialId = value!.id;
                                          _currentMeterial1SelectedValue =
                                              value;
                                        });
                                      },
                                      isExpanded: true,
                                    ),
                                  ),

                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 15, right: 16, bottom: 1, top: 5),
                                  //   child: TextFormField(
                                  //     keyboardType: TextInputType.number,
                                  //     controller: doorMaterialController,
                                  //     decoration: InputDecoration(
                                  //     //  hintText: 'Meterial',
                                  //       label: Text('Meterial'),
                                  //       labelStyle: TextStyle(
                                  //           fontSize: 12,
                                  //           color: Color(0xff808B9E),
                                  //           fontFamily: 'San Francisco'),
                                  //       border: OutlineInputBorder(
                                  //           borderSide: BorderSide(
                                  //               color: Color(0xffF2F2F2),
                                  //               width: 344)),
                                  //     ),
                                  //     validator: (value) {
                                  //       if (value == null || value.trim().isEmpty) {
                                  //         return 'This field is required';
                                  //       }
                                  //       return null;
                                  //     },
                                  //   ),
                                  // ),

                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 16.0, top: 10),
                                    child: Text(
                                      'Orientation ',
                                      style: TextStyle(
                                          fontFamily: 'San Francisco',
                                          color: Color(0xff16698C),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                child: Radio(
                                              value: 1,
                                              groupValue: doorOrientationID,
                                              onChanged: (val) {
                                                setState(() {
                                                  doorOrientation = 'LH - IN';
                                                  doorOrientationID = 1;
                                                });
                                              },
                                            )),
                                            Expanded(
                                                child: Text(
                                              'LH-IN',
                                              style:
                                                  new TextStyle(fontSize: 12.0),
                                            )),
                                            Expanded(
                                                child: Radio(
                                              value: 2,
                                              groupValue: doorOrientationID,
                                              onChanged: (val) {
                                                setState(() {
                                                  doorOrientation = 'LH - OUT';
                                                  doorOrientationID = 2;
                                                });
                                              },
                                            )),
                                            Expanded(
                                                child: Text(
                                              'LH-OUT',
                                              style: new TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            )),
                                            Expanded(
                                                child: Radio(
                                              value: 3,
                                              groupValue: doorOrientationID,
                                              onChanged: (val) {
                                                setState(() {
                                                  doorOrientation = 'RH - IN';
                                                  doorOrientationID = 3;
                                                });
                                              },
                                            )),
                                            Expanded(
                                                child: Text(
                                              'RH-IN',
                                              style:
                                                  new TextStyle(fontSize: 12.0),
                                            )),
                                            Expanded(
                                                child: Radio(
                                              value: 4,
                                              groupValue: doorOrientationID,
                                              onChanged: (val) {
                                                setState(() {
                                                  doorOrientation = 'RH - OUT';
                                                  doorOrientationID = 4;
                                                });
                                              },
                                            )),
                                            Expanded(
                                                child: Text(
                                              'RH-OUT',
                                              style: new TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            )),
                                          ],
                                        ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.start,
                                        //   children: <Widget>[
                                        //
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),

                                  /* Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: this.orientation_LH_Rverse,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.orientation_LH_Rverse = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'LH - REVERSE SWING',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      Checkbox(
                                        value: this.orientation_LH_Out,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.orientation_LH_Out = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'LH - OUT SWING',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: this.orientation_RH_Rverse,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.orientation_RH_Rverse = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'RH - REVERSE SWING',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      Checkbox(
                                        value: this.orientation_RH_Out,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.orientation_RH_Out = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'RH - OUT SWING',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
*/
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 16.0, bottom: 10),
                                    child: Text(
                                      'Quantity',
                                      style: TextStyle(
                                          color: Color(0xff16698C),
                                          fontFamily: 'San Francisco',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 16, bottom: 10),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: doorQuantityController,
                                      decoration: const InputDecoration(
                                        // hintText: 'Quantity',
                                        label: Text('Quantity'),
                                        labelStyle: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff808B9E),
                                            fontFamily: 'San Francisco'),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Color(0xffF2F2F2),
                                        )),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'This field is required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),

                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.0, top: 5, bottom: 10),
                                    child: Text(
                                      'Size',
                                      style: TextStyle(
                                          color: Color(0xff16698C),
                                          fontFamily: 'San Francisco',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(children: [
                                        Expanded(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                doorSizeHeightFeetController,
                                            decoration: const InputDecoration(
                                              // hintText: 'Height-Feet',
                                              label: Text('Height-Feet'),
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff808B9E),
                                                  fontFamily: 'San Francisco'),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: Color(0xffF2F2F2),
                                              )),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                doorSizeHeightInchController,
                                            decoration: const InputDecoration(
                                              //  hintText: 'Height-Inches',
                                              label: Text('Height-Inches'),
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff808B9E),
                                                  fontFamily: 'San Francisco'),
                                              border: const OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                color: Color(0xffF2F2F2),
                                              )),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ))
                                      ])),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(children: [
                                        Expanded(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                doorSizeWidthFeetController,
                                            decoration: const InputDecoration(
                                              // hintText: 'Width-Feet',
                                              label: Text('Width-Feet'),
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff808B9E),
                                                  fontFamily: 'San Francisco'),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: Color(0xffF2F2F2),
                                              )),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                doorSizeWidthInchController,
                                            decoration: const InputDecoration(
                                              // hintText: 'Width-Inches',
                                              label: Text('Width-Inches'),
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff808B9E),
                                                  fontFamily: 'San Francisco'),
                                              border: const OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                color: Color(0xffF2F2F2),
                                              )),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ))
                                      ])),

                                  // -------------------- 2nd dublicate ----------------------

                                  const Padding(
                                    padding: EdgeInsets.only(
                                      left: 16.0,
                                      top: 10,
                                    ),
                                    child: Text(
                                      'Location',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff16698C),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'San Francisco'),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Radio(
                                          value: 1,
                                          groupValue: doorLocationID1,
                                          onChanged: (val) {
                                            setState(() {
                                              doorLocation1 = 'INTERIOR';
                                              doorLocationID1 = 1;
                                            });
                                          },
                                        ),
                                        Text(
                                          'INTERIOR'.toCapitalized(),
                                          style: new TextStyle(fontSize: 12.0),
                                        ),
                                        Radio(
                                          value: 2,
                                          groupValue: doorLocationID1,
                                          onChanged: (val) {
                                            setState(() {
                                              doorLocation1 = 'EXTERIOR';
                                              doorLocationID1 = 2;
                                            });
                                          },
                                        ),
                                        Text(
                                          'EXTERIOR'.toCapitalized(),
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /*   Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: this.locationInterior1,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.locationInterior1 = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'INTERIOR',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      Checkbox(
                                        value: this.locationExterrior1,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.locationExterrior1 = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'EXTERIOR',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),*/
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 16.0, bottom: 5),
                                    child: Text(
                                      'Type',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: const Color(0xff16698C),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'San Francisco'),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Radio(
                                          value: 1,
                                          groupValue: doorTypeID1,
                                          onChanged: (val) {
                                            setState(() {
                                              doorType1 = 'SOLID CORE';
                                              doorTypeID1 = 1;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Solid Core',
                                          style: new TextStyle(fontSize: 12.0),
                                        ),
                                        Radio(
                                          value: 2,
                                          groupValue: doorTypeID1,
                                          onChanged: (val) {
                                            setState(() {
                                              doorType1 = 'HOLLOW CORE';
                                              doorTypeID1 = 2;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Hollow Core',
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  /* Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: this.locationSolidCore1,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.locationSolidCore1 = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'SOLID CORE',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      Checkbox(
                                        value: this.locationHollow1,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.locationHollow1 = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'HOLLOW CORE',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),*/

                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'Material',
                                      style: TextStyle(
                                          color: Color(0xff16698C),
                                          fontFamily: 'San Francisco',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 15, top: 10, right: 15),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black38)),
                                    child:
                                        DropdownButtonFormField<DropListModel>(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                      value: _currentMeterial2SelectedValue,
                                      //elevation: 5,
                                      style:
                                          const TextStyle(color: Colors.black),

                                      items: materialSecond
                                          .map<DropdownMenuItem<DropListModel>>(
                                              (DropListModel value) {
                                        return DropdownMenuItem<DropListModel>(
                                          value: value,
                                          child: Text(value.name),
                                        );
                                      }).toList(),
                                      hint: const Text(
                                        "Choose",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      onChanged: (DropListModel? value) {
                                        setState(() {
                                          _materialId1 = value!.id;
                                          _currentMeterial2SelectedValue =
                                              value;
                                        });
                                      },
                                      isExpanded: true,
                                    ),
                                  ),

                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 15.0, top: 10),
                                    child: Text(
                                      'Orientation ',
                                      style: TextStyle(
                                          color: Color(0xff16698C),
                                          fontFamily: 'San Francisco',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                            child: Radio(
                                          value: 1,
                                          groupValue: doorOrientationID1,
                                          onChanged: (val) {
                                            setState(() {
                                              doorOrientation1 = 'LH - IN';
                                              doorOrientationID1 = 1;
                                            });
                                          },
                                        )),
                                        Expanded(
                                            child: Text(
                                          'LH-IN',
                                          style: new TextStyle(fontSize: 12.0),
                                        )),
                                        Expanded(
                                            child: Radio(
                                          value: 2,
                                          groupValue: doorOrientationID1,
                                          onChanged: (val) {
                                            setState(() {
                                              doorOrientation1 = 'LH - OUT';
                                              doorOrientationID1 = 2;
                                            });
                                          },
                                        )),
                                        Expanded(
                                            child: Text(
                                          'LH-OUT',
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        )),
                                        Expanded(
                                            child: Radio(
                                          value: 3,
                                          groupValue: doorOrientationID1,
                                          onChanged: (val) {
                                            setState(() {
                                              doorOrientation1 = 'RH - IN';
                                              doorOrientationID1 = 3;
                                            });
                                          },
                                        )),
                                        Expanded(
                                            child: Text(
                                          'RH-IN',
                                          style: new TextStyle(fontSize: 12.0),
                                        )),
                                        Expanded(
                                            child: Radio(
                                          value: 4,
                                          groupValue: doorOrientationID1,
                                          onChanged: (val) {
                                            setState(() {
                                              doorOrientation1 = 'RH - OUT';
                                              doorOrientationID1 = 4;
                                            });
                                          },
                                        )),
                                        Expanded(
                                            child: Text(
                                          'RH-OUT',
                                          style: new TextStyle(fontSize: 12.0),
                                        )),
                                      ],
                                    ),
                                  ),

                                  /* Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Checkbox(
                                        value: this.orientation_LH_Rverse1,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.orientation_LH_Rverse1 =
                                                value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'LH-IN',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    Expanded(
                                      child: Checkbox(
                                        value: this.orientation_LH_Out1,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.orientation_LH_Out1 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'LH-OUT',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    Expanded(
                                      child: Checkbox(
                                        value: this.orientation_RH_Rverse1,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.orientation_RH_Rverse1 =
                                                value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'RH-IN',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    Expanded(
                                      child: Checkbox(
                                        value: this.orientation_RH_Out1,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.orientation_RH_Out1 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'RH-OUT',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                  ],
                                )),*/

                                  const Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      'Quantity',
                                      style: TextStyle(
                                          color: Color(0xff16698C),
                                          fontFamily: 'San Francisco',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 16,
                                        bottom: 10,
                                        top: 10),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: doorQuantity1Controller,
                                      decoration: const InputDecoration(
                                        // hintText: 'Quantity',
                                        label: Text('Quantity'),
                                        labelStyle: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff808B9E),
                                            fontFamily: 'San Francisco'),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Color(0xffF2F2F2),
                                        )),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'This field is required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),

                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 16.0, bottom: 10),
                                    child: Text(
                                      'Size',
                                      style: TextStyle(
                                          color: Color(0xff16698C),
                                          fontFamily: 'San Francisco',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(children: [
                                        Expanded(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                doorSize1HeightFeetController,
                                            decoration: const InputDecoration(
                                              //  hintText: 'size-height-feet',
                                              label: Text('Height-Feet'),
                                              labelStyle: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff808B9E),
                                                  fontFamily: 'San Francisco'),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: Color(0xffF2F2F2),
                                              )),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                doorSize1HeightInchController,
                                            decoration: const InputDecoration(
                                              // hintText: 'size-height-inches',
                                              label: Text('Height-Inches'),
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xff808B9E),
                                                  fontFamily: 'San Francisco'),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: Color(0xffF2F2F2),
                                              )),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ))
                                      ])),

                                  const SizedBox(height: 10),

                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(children: [
                                        Expanded(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                doorSize1WidthFeetController,
                                            decoration: const InputDecoration(
                                              // hintText: 'size-width-feet',
                                              label: Text('Width-Feet'),
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xff808B9E),
                                                  fontFamily: 'San Francisco'),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: Color(0xffF2F2F2),
                                              )),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                doorSize1WidthInchController,
                                            decoration: const InputDecoration(
                                              //  hintText: 'size-width-inches',
                                              label: Text('Width-Inches'),
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xff808B9E),
                                                  fontFamily: 'San Francisco'),
                                              border: const OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                color: Color(0xffF2F2F2),
                                              )),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ))
                                      ])),

                                  // ------------------------- dublicate 3rd -----------------------------

                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.0, bottom: 0, top: 10),
                                    child: Text(
                                      'Location',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff16698C),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'San Francisco'),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Radio(
                                          value: 1,
                                          groupValue: doorLocationID2,
                                          onChanged: (val) {
                                            setState(() {
                                              doorLocation2 = 'INTERIOR';
                                              doorLocationID2 = 1;
                                            });
                                          },
                                        ),
                                        Text(
                                          'INTERIOR'.toCapitalized(),
                                          style: new TextStyle(fontSize: 12.0),
                                        ),
                                        Radio(
                                          value: 2,
                                          groupValue: doorLocationID2,
                                          onChanged: (val) {
                                            setState(() {
                                              doorLocation2 = 'EXTERIOR';
                                              doorLocationID2 = 2;
                                            });
                                          },
                                        ),
                                        Text(
                                          'EXTERIOR'.toCapitalized(),
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /*Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: this.locationInterior2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.locationInterior2 = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'INTERIOR',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      Checkbox(
                                        value: this.locationExterrior2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.locationExterrior2 = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'EXTERIOR',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),*/
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 16.0, bottom: 0),
                                    child: Text(
                                      'Type',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff16698C),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'San Francisco'),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Radio(
                                          value: 1,
                                          groupValue: doorTypeID2,
                                          onChanged: (val) {
                                            setState(() {
                                              doorType2 = 'SOLID CORE';
                                              doorTypeID2 = 1;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Solid Core',
                                          style: new TextStyle(fontSize: 12.0),
                                        ),
                                        Radio(
                                          value: 2,
                                          groupValue: doorTypeID2,
                                          onChanged: (val) {
                                            setState(() {
                                              doorType2 = 'HOLLOW CORE';
                                              doorTypeID2 = 2;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Hollow Core',
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  /*  Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: this.locationSolidCore2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.locationSolidCore2 = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'SOLID CORE',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      Checkbox(
                                        value: this.locationHollow2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.locationHollow2 = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'HOLLOW CORE',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),*/

                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'Material',
                                      style: TextStyle(
                                          color: Color(0xff16698C),
                                          fontFamily: 'San Francisco',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 15, top: 10, right: 15),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black38)),
                                    child:
                                        DropdownButtonFormField<DropListModel>(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                      value: _currentMeterial3SelectedValue,
                                      //elevation: 5,
                                      style:
                                          const TextStyle(color: Colors.black),

                                      items: materialThird
                                          .map<DropdownMenuItem<DropListModel>>(
                                              (DropListModel value) {
                                        return DropdownMenuItem<DropListModel>(
                                          value: value,
                                          child: Text(value.name),
                                        );
                                      }).toList(),
                                      hint: const Text(
                                        "Choose",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      onChanged: (DropListModel? value) {
                                        setState(() {
                                          _materialId2 = value!.id;

                                          _currentMeterial3SelectedValue =
                                              value;
                                        });
                                      },
                                      isExpanded: true,
                                    ),
                                  ),

                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 16.0, top: 5),
                                    child: Text(
                                      'Orientation ',
                                      style: TextStyle(
                                          color: Color(0xff16698C),
                                          fontFamily: 'San Francisco',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                            child: Radio(
                                          value: 1,
                                          groupValue: doorOrientationID2,
                                          onChanged: (val) {
                                            setState(() {
                                              doorOrientation2 = 'LH - IN';
                                              doorOrientationID2 = 1;
                                            });
                                          },
                                        )),
                                        Expanded(
                                            child: Text(
                                          'LH-IN',
                                          style: new TextStyle(fontSize: 12.0),
                                        )),
                                        Expanded(
                                            child: Radio(
                                          value: 2,
                                          groupValue: doorOrientationID2,
                                          onChanged: (val) {
                                            setState(() {
                                              doorOrientation2 = 'LH - OUT';
                                              doorOrientationID2 = 2;
                                            });
                                          },
                                        )),
                                        Expanded(
                                            child: Text(
                                          'LH-OUT',
                                          style: new TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        )),
                                        Expanded(
                                            child: Radio(
                                          value: 3,
                                          groupValue: doorOrientationID2,
                                          onChanged: (val) {
                                            setState(() {
                                              doorOrientation2 = 'RH - IN';
                                              doorOrientationID2 = 3;
                                            });
                                          },
                                        )),
                                        Expanded(
                                            child: Text(
                                          'RH -IN',
                                          style: new TextStyle(fontSize: 12.0),
                                        )),
                                        Expanded(
                                            child: Radio(
                                          value: 4,
                                          groupValue: doorOrientationID2,
                                          onChanged: (val) {
                                            setState(() {
                                              doorOrientation2 = 'RH - OUT';
                                              doorOrientationID2 = 4;
                                            });
                                          },
                                        )),
                                        Expanded(
                                            child: Text(
                                          'RH-OUT',
                                          style: new TextStyle(fontSize: 12.0),
                                        )),
                                      ],
                                    ),
                                  ),

                                  /*  Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Checkbox(
                                        value: this.orientation_LH_Rverse2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.orientation_LH_Rverse2 =
                                                value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'LH-IN',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    Expanded(
                                      child: Checkbox(
                                        value: this.orientation_LH_Out2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.orientation_LH_Out2 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'LH-OUT',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    Expanded(
                                      child: Checkbox(
                                        value: this.orientation_RH_Rverse2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.orientation_RH_Rverse2 =
                                                value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'RH-IN',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                    Expanded(
                                      child: Checkbox(
                                        value: this.orientation_RH_Out2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.orientation_RH_Out2 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'RH-OUT',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ),
                                  ],
                                )),*/

                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 16.0, bottom: 10),
                                    child: Text(
                                      'Quantity',
                                      style: TextStyle(
                                          color: Color(0xff16698C),
                                          fontFamily: 'San Francisco',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 10),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: doorQuantity2Controller,
                                      decoration: const InputDecoration(
                                        // hintText: 'Quantity',
                                        label: Text('Quantity'),
                                        labelStyle: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff808B9E),
                                            fontFamily: 'San Francisco'),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Color(0xffF2F2F2),
                                        )),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'This field is required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),

                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 16.0, bottom: 5),
                                    child: Text(
                                      'Size',
                                      style: TextStyle(
                                          color: Color(0xff16698C),
                                          fontFamily: 'San Francisco',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(children: [
                                        Expanded(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                doorSize2HeightFeetController,
                                            decoration: const InputDecoration(
                                              //  hintText: 'Height-Feet',
                                              label: Text('Height-Feet'),
                                              labelStyle: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff808B9E),
                                                  fontFamily: 'San Francisco'),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: Color(0xffF2F2F2),
                                              )),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                doorSize2HeightInchController,
                                            decoration: const InputDecoration(
                                              // hintText: 'Height-Inches',
                                              label: Text('Height-Inches'),
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xff808B9E),
                                                  fontFamily: 'San Francisco'),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: Color(0xffF2F2F2),
                                              )),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ))
                                      ])),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(children: [
                                        Expanded(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                doorSize2WidthFeetController,
                                            decoration: const InputDecoration(
                                              // hintText: 'Width-Feet',
                                              label: Text('Width-Feet'),
                                              labelStyle: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff808B9E),
                                                  fontFamily: 'San Francisco'),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: Color(0xffF2F2F2),
                                              )),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                doorSize2WidthInchController,
                                            decoration: const InputDecoration(
                                              // hintText: 'Width-Inches',
                                              label: Text('Width-Inches'),
                                              labelStyle: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xff808B9E),
                                                  fontFamily: 'San Francisco'),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: Color(0xffF2F2F2),
                                              )),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ))
                                      ])),

                                  // -------------------------- duplicate finish --------------------
                                ]),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Container(
                                height: 30,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                  color: Color(0xff16698C),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Electrical',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'San Francisco',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0, bottom: 5),
                              child: Text(
                                'Service Entrance',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff16698C),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'San Francisco'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Radio(
                                    value: 1,
                                    groupValue: electricalEntranceID,
                                    onChanged: (val) {
                                      setState(() {
                                        electricalEntrance = 'Needs Repair';
                                        electricalEntranceID = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Needs Repair',
                                    style: new TextStyle(fontSize: 12.0),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: electricalEntranceID,
                                    onChanged: (val) {
                                      setState(() {
                                        electricalEntrance =
                                            'Needs Replacement';
                                        electricalEntranceID = 2;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Needs Replacement',
                                    style: new TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /* Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: this.serviceRepair,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.serviceRepair = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'Needs Repair',
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                Checkbox(
                                  value: this.serviceReplacement,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.serviceReplacement = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'Needs Replacement',
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),*/
                            const SizedBox(
                              height: 5,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0, bottom: 0),
                              child: Text(
                                'Service Pole',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff16698C),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'San Francisco'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Radio(
                                    value: 1,
                                    groupValue: electricalPoleID,
                                    onChanged: (val) {
                                      setState(() {
                                        electricalPole = 'Needs Repair';
                                        electricalPoleID = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Needs Repair',
                                    style: new TextStyle(fontSize: 12.0),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: electricalPoleID,
                                    onChanged: (val) {
                                      setState(() {
                                        electricalPole = 'Needs Replacement';
                                        electricalPoleID = 2;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Needs Replacement',
                                    style: new TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /* Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: this.servicePoleRepair,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.servicePoleRepair = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'Needs Repair',
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                Checkbox(
                                  value: this.servicePoleReplacement,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.servicePoleReplacement = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'Needs Replacement',
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),*/

                            Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: const Text(
                                        'Meter Can Size',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff16698C),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'San Francisco'),
                                      ),
                                    ),
                                    const Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              'Meter Switch Size',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff16698C),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'San Francisco'),
                                            ))),
                                  ],
                                )),
                            const SizedBox(
                              height: 7,
                            ),
                            Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: eleMeterSizeController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          // hintText: 'Watts',
                                          label: Text('Watts'),
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff808B9E),
                                              fontFamily: 'San Francisco'),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: elaMeterSwitchController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          //hintText: 'Amps',
                                          label: Text('Amps'),
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff808B9E),
                                              fontFamily: 'San Francisco'),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    )),
                                  ],
                                )),
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0, top: 10),
                              child: Text(
                                'Interior Flooding',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: const Color(0xff16698C),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'San Francisco'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Radio(
                                    value: 1,
                                    groupValue: electricalInteriorID,
                                    onChanged: (val) {
                                      setState(() {
                                        electricalInterior = 'Yes';
                                        electricalInteriorID = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'YES',
                                    style: new TextStyle(fontSize: 12.0),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: electricalInteriorID,
                                    onChanged: (val) {
                                      setState(() {
                                        electricalInterior = 'No';
                                        electricalInteriorID = 2;
                                      });
                                    },
                                  ),
                                  Text(
                                    'NO',
                                    style: new TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /* Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              value: this.eleInteriorYes,
                              onChanged: (bool? value) {
                                setState(() {
                                  this.eleInteriorYes = value!;
                                });
                              },
                            ),
                            Text(
                              'YES',
                              style: TextStyle(fontSize: 12.0),
                            ),
                            Checkbox(
                              value: this.eleInteriorNo,
                              onChanged: (bool? value) {
                                setState(() {
                                  this.eleInteriorNo = value!;
                                });
                              },
                            ),
                            Text(
                              'NO',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),*/
                            Visibility(
                              visible: electricalInterior == 'Yes',
                              child: const Padding(
                                padding:
                                    EdgeInsets.only(left: 16.0, bottom: 10),
                                child: Text(
                                  'Flooding Height',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: const Color(0xff16698C),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'San Francisco'),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: electricalInterior == 'Yes',
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(children: [
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: elaFloadingFeetController,
                                        decoration: const InputDecoration(
                                          // hintText: 'Feet',
                                          label: Text('Feet'),
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff808B9E),
                                              fontFamily: 'San Francisco'),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Color(0xffF2F2F2),
                                          )),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: elaFloadingInchController,
                                        decoration: const InputDecoration(
                                          // hintText: 'Inches',
                                          label: Text('Inches'),
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff808B9E),
                                              fontFamily: 'San Francisco'),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Color(0xffF2F2F2),
                                          )),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ))
                                  ])),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Container(
                                height: 30,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                  color: Color(0xff16698C),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Grounding System',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'San Francisco',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Ground Rod',
                                style: TextStyle(
                                    color: Color(0xff16698C),
                                    fontFamily: 'San Francisco',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: this.eleGroundRod,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        this.eleGroundRod = value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Needs Replacement',
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Ground Clamp',
                                style: TextStyle(
                                    color: Color(0xff16698C),
                                    fontFamily: 'San Francisco',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: this.eleGroundClamp,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        this.eleGroundClamp = value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Needs Replacement',
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: const Text(
                                'Ground Wire',
                                style: const TextStyle(
                                    color: Color(0xff16698C),
                                    fontFamily: 'San Francisco',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: this.eleGroundwire,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        this.eleGroundwire = value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Needs Replacement',
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Container(
                                height: 30,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                  color: Color(0xff16698C),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Plumbing',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'San Francisco',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'Water Supply',
                                style: TextStyle(
                                    color: Color(0xff16698C),
                                    fontFamily: 'San Francisco',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                              ),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: this.plumingwater,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        this.plumingwater = value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Needs Repair',
                                    style: const TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20, top: 15),
                              child: const Text(
                                'Water Closet and (Toilet Only)',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff16698C),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'San Francisco'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Radio(
                                    value: 1,
                                    groupValue: plumbingwaterID,
                                    onChanged: (val) {
                                      setState(() {
                                        plumbingwater = 'Needs Repair';
                                        plumbingwaterID = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Needs Repair',
                                    style: new TextStyle(fontSize: 12.0),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: plumbingwaterID,
                                    onChanged: (val) {
                                      setState(() {
                                        plumbingwater = 'Needs Replacement';
                                        plumbingwaterID = 2;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Needs Replacement',
                                    style: new TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /*  Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: this.plumingwaterclosetRepair,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.plumingwaterclosetRepair = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'Needs Repair',
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                Checkbox(
                                  value: this.plumingwaterclosetReplacment,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.plumingwaterclosetReplacment =
                                          value!;
                                    });
                                  },
                                ),
                                Text(
                                  'Needs Replacement',
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),*/
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, bottom: 15, top: 10),
                              child: Text(
                                '1/2" Service Pipe',
                                style: TextStyle(
                                    color: Color(0xff16698C),
                                    fontFamily: 'San Francisco',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: this.plumingservicePipe1,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        this.plumingservicePipe1 = value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Needs Repair',
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: this.plumingservicePipe1,
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 20, bottom: 20),
                                child: Text(
                                  'Length of damage',
                                  style: TextStyle(
                                      color: const Color(0xff16698C),
                                      fontFamily: 'San Francisco',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: this.plumingservicePipe1,
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(children: [
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: plumingLengthFeetController,
                                        decoration: const InputDecoration(
                                          // hintText: 'length-of-damage-feet',
                                          label: Text('Feet'),
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff808B9E),
                                              fontFamily: 'San Francisco'),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Color(0xffF2F2F2),
                                          )),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: plumingLengthInchController,
                                        decoration: const InputDecoration(
                                          // hintText: 'length-of-damage-inches',
                                          label: Text('Inches'),
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff808B9E),
                                              fontFamily: 'San Francisco'),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Color(0xffF2F2F2),
                                          )),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ))
                                  ])),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 10, left: 20, bottom: 20),
                              child: Text(
                                '3/4" Service Pipe',
                                style: TextStyle(
                                    color: Color(0xff16698C),
                                    fontFamily: 'San Francisco',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: this.plumingservicePipe2,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        this.plumingservicePipe2 = value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Needs Repair',
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: this.plumingservicePipe2,
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 20, bottom: 20),
                                child: Text(
                                  'Length of damage',
                                  style: TextStyle(
                                      color: Color(0xff16698C),
                                      fontFamily: 'San Francisco',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: this.plumingservicePipe2,
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(children: [
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            plumingServiceFeetController,
                                        decoration: const InputDecoration(
                                          // hintText: 'length-of-damage-feet-one',
                                          label: Text('Feet'),
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff808B9E),
                                              fontFamily: 'San Francisco'),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Color(0xffF2F2F2),
                                          )),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            plumingServiceInchController,
                                        decoration: const InputDecoration(
                                          // hintText: 'length-of-damage-inches-one',
                                          label: Text('Inches'),
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff808B9E),
                                              fontFamily: 'San Francisco'),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Color(0xffF2F2F2),
                                          )),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ))
                                  ])),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 10, left: 15, bottom: 15),
                              child: Text(
                                '1" service-pipe',
                                style: TextStyle(
                                    color: Color(0xff16698C),
                                    fontFamily: 'San Francisco',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: this.plumingservicePipe3,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        this.plumingservicePipe3 = value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Needs Repair',
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: this.plumingservicePipe3,
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 20, bottom: 20),
                                child: Text(
                                  'Length of damage',
                                  style: TextStyle(
                                      color: const Color(0xff16698C),
                                      fontFamily: 'San Francisco',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: this.plumingservicePipe3,
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(children: [
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            plumingService1FeetController,
                                        decoration: const InputDecoration(
                                          //  hintText: 'length-of-damage-feet-two',
                                          label: Text('Feet'),
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff808B9E),
                                              fontFamily: 'San Francisco'),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Color(0xffF2F2F2),
                                          )),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            plumingService1InchController,
                                        decoration: const InputDecoration(
                                          //  hintText: 'length-of-damage-inches-two',
                                          label: Text('Inches'),
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff808B9E),
                                              fontFamily: 'San Francisco'),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Color(0xffF2F2F2),
                                          )),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ))
                                  ])),
                            ),
                            Column(
                              children: List.generate(noOfPlumbingFields, (i) {
                                return dynamicPipes(context, i);
                              }),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      noOfPlumbingFields += 1;
                                      addPlumbingController();
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(
                                              0xff16698C), // Set border color
                                          width: 3.0),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                              15.0) //                 <--- border radius here
                                          ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        ' Add Pipe ',
                                        style: TextStyle(
                                            color: Color(0xff16698C),
                                            fontFamily: 'San Francisco',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ]),
              )
            ]),
      bottomNavigationBar: Container(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // widget.tabController.animateTo(1);
                  print(windowtype.length.toString() +
                      '++++++++++++++++++++++++++ button');

                  valiationPage();
                },
                child: const Text('NEXT',
                    style: const TextStyle(
                        fontFamily: 'San Francisco',
                        fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xff12AFC0),
                    fixedSize: const Size(100, 46)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dynamicPipes(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.1,
                child: TextFormField(
                  controller: lableTextContorllerExtra[index],
                  decoration: const InputDecoration(
                    label: Text('Lable'),
                    labelStyle: TextStyle(
                        fontSize: 12,
                        color: Color(0xff808B9E),
                        fontFamily: 'San Francisco'),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xffF2F2F2),
                    )),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  noOfPlumbingFields -= 1;
                  removePlumbingController(index);
                },
                child: const Icon(
                  Icons.delete_outline_outlined,
                  color: Colors.blue,
                  size: 25.0,
                  textDirection: TextDirection.ltr,
                  semanticLabel:
                      'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 13, left: 20, bottom: 10),
          child: Text(
            'Length of damage',
            style: TextStyle(
                color: Color(0xff16698C),
                fontFamily: 'San Francisco',
                fontWeight: FontWeight.w600,
                fontSize: 14),
          ),
        ),
        Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: plumingService1FeetControllerExtra[index],
                  decoration: const InputDecoration(
                    label: Text('Feet'),
                    labelStyle: TextStyle(
                        fontSize: 12,
                        color: Color(0xff808B9E),
                        fontFamily: 'San Francisco'),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xffF2F2F2),
                    )),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: plumingService1InchControllerExtra[index],
                  decoration: const InputDecoration(
                    label: Text('Inches'),
                    labelStyle: TextStyle(
                        fontSize: 12,
                        color: Color(0xff808B9E),
                        fontFamily: 'San Francisco'),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xffF2F2F2),
                    )),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
              ))
            ])),
      ],
    );
  }

  Widget dynmaicFields(BuildContext context, int index) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0, bottom: 1, top: 10),
                child: Text(
                  'Type',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff16698C),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'San Francisco'),
                ),
              ),
              index + 1 == noOfWindowForms
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          noOfWindowForms += 1;
                          addTextController();
                        });
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.blue,
                        size: 25.0,
                        textDirection: TextDirection.ltr,
                        semanticLabel:
                            'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                      ),
                    )
                  : noOfWindowForms > 1
                      ? InkWell(
                          onTap: () {
                            noOfWindowForms -= 1;
                            removeTextController(index);
                          },
                          child: const Icon(
                            Icons.delete_outline_outlined,
                            color: Colors.blue,
                            size: 25.0,
                            textDirection: TextDirection.ltr,
                            semanticLabel:
                                'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                          ),
                        )
                      : Container(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue:
                      windowtypeid.length > index ? windowtypeid[index] : 0,
                  onChanged: (val) {
                    setState(() {
                      if (windowtypeid.length > index) {
                        windowtype[index] = 'NON-IMPACT';
                        windowtypeid[index] = 1;
                      } else {
                        windowtype.add('NON-IMPACT');
                        windowtypeid.add(1);
                      }
                    });
                  },
                ),
                Text(
                  'Non-Impact',
                  style: new TextStyle(fontSize: 12.0),
                ),
                Radio(
                  value: 2,
                  groupValue:
                      windowtypeid.length > index ? windowtypeid[index] : 0,
                  onChanged: (val) {
                    setState(() {
                      if (windowtypeid.length > index) {
                        windowtype[index] = 'HURRICANE IMPACT';
                        windowtypeid[index] = 2;
                      } else {
                        windowtype.add('HURRICANE IMPACT');
                        windowtypeid.add(2);
                      }
                    });
                  },
                ),
                Text(
                  'Hurricane Impact',
                  style: new TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 0),
            child: const Text(
              'Casement Style',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff16698C),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'San Francisco'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: windowtypeColonialStyleID.length > index
                      ? windowtypeColonialStyleID[index]
                      : 0,
                  onChanged: (val) {
                    setState(() {
                      if (windowtypeColonialStyleID.length > index) {
                        windowColonialStyle[index] = 'COLONIAL';
                        windowtypeColonialStyleID[index] = 1;
                      } else {
                        windowColonialStyle.add('COLONIAL');
                        windowtypeColonialStyleID.add(1);
                      }
                    });
                  },
                ),
                Text(
                  'Colonial',
                  style: new TextStyle(fontSize: 12.0),
                ),
                Radio(
                  value: 2,
                  groupValue: windowtypeColonialStyleID.length > index
                      ? windowtypeColonialStyleID[index]
                      : 0,
                  onChanged: (val) {
                    setState(() {
                      if (windowtypeColonialStyleID.length > index) {
                        windowColonialStyle[index] = 'NON-COLONIAL';
                        windowtypeColonialStyleID[index] = 2;
                      } else {
                        windowColonialStyle.add('NON-COLONIAL');
                        windowtypeColonialStyleID.add(2);
                      }
                    });
                  },
                ),
                Text(
                  'Non-Colonial',
                  style: new TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),

          /* Padding(
                                  padding: EdgeInsets.only(left: 9),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: typeNonImpact2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.typeNonImpact2 = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'NON-IMPACT',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      Checkbox(
                                        value: this.typeHurImpact2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.typeHurImpact2 = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'HURRICANE IMPACT',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  )),*/
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 1, top: 5),
            child: Text(
              'Window Style',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff16698C),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'San Francisco'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Radio(
                  value: 1,
                  groupValue:
                      windowStyleID.length > index ? windowStyleID[index] : 0,
                  onChanged: (val) {
                    setState(() {
                      if (windowStyleID.length > index) {
                        windowStyle[index] = 'AWNING';
                        windowStyleID[index] = 1;
                      } else {
                        windowStyle.add('AWNING');
                        windowStyleID.add(1);
                      }
                    });
                  },
                )),
                Expanded(
                    child: Text(
                  'Awning',
                  style: new TextStyle(fontSize: 12.0),
                )),
                Expanded(
                    child: Radio(
                  value: 2,
                  groupValue:
                      windowStyleID.length > index ? windowStyleID[index] : 0,
                  onChanged: (val) {
                    setState(() {
                      if (windowStyleID.length > index) {
                        windowStyle[index] = 'SLIDER';
                        windowStyleID[index] = 2;
                      } else {
                        windowStyle.add('SLIDER');
                        windowStyleID.add(2);
                      }
                    });
                  },
                )),
                Expanded(
                    child: Text(
                  'Slider',
                  style: new TextStyle(
                    fontSize: 12.0,
                  ),
                )),
                Expanded(
                    child: Radio(
                  value: 3,
                  groupValue:
                      windowStyleID.length > index ? windowStyleID[index] : 0,
                  onChanged: (val) {
                    setState(() {
                      if (windowStyleID.length > index) {
                        windowStyle[index] = 'COLONIAL';
                        windowStyleID[index] = 3;
                      } else {
                        windowStyle.add('COLONIAL');
                        windowStyleID.add(3);
                      }
                    });
                  },
                )),
                Expanded(
                    child: Text(
                  'Colonial',
                  style: new TextStyle(fontSize: 12.0),
                )),
                Expanded(
                    child: Radio(
                  value: 4,
                  groupValue:
                      windowStyleID.length > index ? windowStyleID[index] : 0,
                  onChanged: (val) {
                    setState(() {
                      if (windowStyleID.length > index) {
                        windowStyle[index] = 'PUSH UP';
                        windowStyleID[index] = 4;
                      } else {
                        windowStyle.add('PUSH UP');
                        windowStyleID.add(4);
                      }
                    });
                  },
                )),
                Expanded(
                    child: Text(
                  'Push up',
                  style: new TextStyle(fontSize: 12.0),
                )),
              ],
            ),
          ),

          /* Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Checkbox(
                                            value: windowAwing2,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                this.windowAwing2 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Awining',
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                        ),
                                        Expanded(
                                          child: Checkbox(
                                            value: this.windowSlider2,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                this.windowSlider2 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Slider',
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                        ),
                                        Expanded(
                                          child: Checkbox(
                                            value: this.windowcolonial2,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                this.windowcolonial2 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Colonial',
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                        ),
                                        Expanded(
                                          child: Checkbox(
                                            value: this.windowpush2,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                this.windowpush2 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Push up',
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),*/
        ],
      ),
      const Padding(
        padding: EdgeInsets.all(16.0),
        child: const Text(
          'Quantity',
          style: TextStyle(
              color: Color(0xff16698C),
              fontFamily: 'San Francisco',
              fontWeight: FontWeight.w500,
              fontSize: 14),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 16, bottom: 10),
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: windowQuantityController[index],
          decoration: const InputDecoration(
            // hintText: 'Quantity',
            label: Text('Quantity'),
            labelStyle: TextStyle(
                fontSize: 12,
                color: Color(0xff808B9E),
                fontFamily: 'San Francisco'),
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Color(0xffF2F2F2),
            )),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Size',
          style: TextStyle(
              color: Color(0xff16698C),
              fontFamily: 'San Francisco',
              fontWeight: FontWeight.w500,
              fontSize: 14),
        ),
      ),
      Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: windowSizeHeightFeetController[index],
                decoration: const InputDecoration(
                  // hintText: 'Height-Feet',
                  label: Text('Height-Feet'),
                  labelStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0xff808B9E),
                      fontFamily: 'San Francisco'),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xffF2F2F2),
                  )),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                left: 5,
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: windowSizeHeightInchController[index],
                decoration: const InputDecoration(
                  // hintText: 'Height-Inches',
                  label: Text('Height-Inches'),
                  labelStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0xff808B9E),
                      fontFamily: 'San Francisco'),
                  border: const OutlineInputBorder(
                      borderSide: const BorderSide(
                    color: Color(0xffF2F2F2),
                  )),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ))
          ])),
      const SizedBox(
        height: 10,
      ),
      Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: windowSizeWidthFeetController[index],
                decoration: const InputDecoration(
                  // hintText: 'Width-Feet',
                  label: Text('Width-Feet'),
                  labelStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0xff808B9E),
                      fontFamily: 'San Francisco'),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xffF2F2F2),
                  )),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                left: 5,
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: windowSizeWidthInchController[index],
                decoration: const InputDecoration(
                  //  hintText: 'Width-Inches',
                  label: const Text('Width-Inches'),
                  labelStyle: const TextStyle(
                      fontSize: 12,
                      color: const Color(0xff808B9E),
                      fontFamily: 'San Francisco'),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xffF2F2F2),
                  )),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ))
          ])),
    ]);
  }

  addPlumbingController() {
    setState(() {
      plumingservicePipe3Extra.add(false);
      plumingService1FeetControllerExtra.add(TextEditingController());
      plumingService1InchControllerExtra.add(TextEditingController());
      lableTextContorllerExtra.add(TextEditingController());
    });
  }

  removePlumbingController(int index) {
    setState(() {
      plumingservicePipe3Extra.removeAt(index);
      plumingService1FeetControllerExtra.removeAt(index);
      plumingService1InchControllerExtra.removeAt(index);
      lableTextContorllerExtra.removeAt(index);
    });
  }

  addTextController() {
    setState(() {
      windowQuantityController.add(TextEditingController());
      windowSizeHeightFeetController.add(TextEditingController());
      windowSizeHeightInchController.add(TextEditingController());
      windowSizeWidthFeetController.add(TextEditingController());
      windowSizeWidthInchController.add(TextEditingController());
      windowtypeid.add(0);
      windowStyleID.add(0);
      windowtypeColonialStyleID.add(0);
      windowtype.add('');
      windowColonialStyle.add('');
      windowStyle.add('');
      // _animateToIndex(10);
    });
    setState(() {});
  }

  removeTextController(int index) {
    print(index.toString() + '+++++++++++++++++++  remove++');
    setState(() {
      windowQuantityController.removeAt(index);
      windowSizeHeightFeetController.removeAt(index);
      windowSizeHeightInchController.removeAt(index);
      windowSizeWidthFeetController.removeAt(index);
      windowSizeWidthInchController.removeAt(index);
      windowtypeid.removeAt(index);
      windowStyleID.removeAt(index);
      windowtypeColonialStyleID.removeAt(index);
      windowtype.removeAt(index);
      windowColonialStyle.removeAt(index);
      windowStyle.removeAt(index);
    });
  }

  void _animateToIndex(int index) {
    _controller.animateTo(
      index * 300,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOutCubicEmphasized,
    );
  }

  Future<void> valiationPage() async {
    print(windowtype.length.toString() + '+++++++++++++++++++ validaiotn');

    if (doorLocation == "INTERIOR") {
      //  this.locationList.add("INTERIOR");
      doorLocation = 'INTERIOR';
    }

    if (doorLocation == "EXTERIOR") {
      //  this.locationList.add("EXTERIOR");
      doorLocation = 'EXTERIOR';
    }

    if (doorLocation1 == "INTERIOR") {
      // this.location1List.add("INTERIOR");
      doorLocation1 = 'INTERIOR';
    }

    if (doorLocation1 == "EXTERIOR") {
      // this.location1List.add("EXTERIOR");
      doorLocation1 = 'EXTERIOR';
    }

    if (doorLocation2 == "INTERIOR") {
      //this.location2List.add("INTERIOR");
      doorLocation2 = 'INTERIOR';
    }

    if (doorLocation2 == "EXTERIOR") {
      //this.location2List.add("EXTERIOR");
      doorLocation2 = 'EXTERIOR';
    }

    print("sdfdsfdsfdsfdsf$doorType");

    if (doorType == "SOLID CORE") {
      // this.doorTypeList.add("SOLID CORE");
      doorType = "SOLID CORE";
    }

    if (doorType == "HOLLOW CORE") {
      //this.doorTypeList.add("HOLLOW CORE");
      doorType = "HOLLOW CORE";
    }

    if (doorType1 == "SOLID CORE") {
      // this.doorType1List.add("SOLID CORE");
      doorType1 = "SOLID CORE";
    }

    if (doorType1 == "HOLLOW CORE") {
      // this.doorType1List.add("HOLLOW CORE");

      doorType1 = "HOLLOW CORE";
    }
    if (doorType2 == "SOLID CORE") {
      doorType2 = "SOLID CORE";

      // this.doorType2List.add("SOLID CORE");
    }

    if (doorType2 == "HOLLOW CORE") {
      doorType2 = "HOLLOW CORE";
      // this.doorType2List.add("HOLLOW CORE");
    }

    /*-------------- Doors Orientation ----------------- */

    if (doorOrientation == "LH - IN") {
      // this.orientationList.add("LH - IN");
      //  this.orientationList.add("LH - REVERSE SWING");

      doorOrientation = "LH - IN";
    }

    if (doorOrientation == "LH - OUT") {
      // this.orientationList.add("LH - OUT");
      //this.orientationList.add("LH - OUT SWING");
      doorOrientation = "LH - OUT";
    }

    if (doorOrientation == "RH - IN") {
      //  this.orientationList.add("RH - IN");
      //  this.orientationList.add("RH - REVERSE SWING");
      doorOrientation = "RH - IN";
    }

    if (doorOrientation == "RH - OUT") {
      // this.orientationList.add("RH - OUT");
      // this.orientationList.add("RH - OUT SWING");
      doorOrientation = "RH - OUT";
    }

    if (doorOrientation1 == "LH - IN") {
      // this.orientation1List.add("LH-IN");
      doorOrientation1 = "LH - IN";
    }

    if (doorOrientation1 == "LH - OUT") {
      // this.orientation1List.add("LH-OUT");
      doorOrientation1 = "LH - OUT";
    }

    if (doorOrientation1 == "RH - IN") {
      //  this.orientation1List.add("RH-IN");
      doorOrientation1 = "RH - IN";
    }

    if (doorOrientation1 == "RH - OUT") {
      //  this.orientation1List.add("RH-OUT");
      doorOrientation1 = "RH - OUT";
    }

    if (doorOrientation2 == "LH - IN") {
      //  this.orientation2List.add("LH-IN");
      doorOrientation2 = "LH - IN";
    }

    if (doorOrientation2 == "LH - OUT") {
      // this.orientation2List.add("LH-OUT");
      doorOrientation2 = "LH - OUT";
    }

    if (doorOrientation2 == "RH - IN") {
      // this.orientation2List.add("RH-IN");
      doorOrientation2 = "RH - IN";
    }

    if (doorOrientation2 == "RH - OUT") {
      //   this.orientation2List.add("RH-OUT");
      doorOrientation2 = "RH - OUT";
    }

    /* if (orientation_LH_Rverse == true) {
      this.orientationList.add("LH - REVERSE SWING");
    }
    if (orientation_LH_Out == true) {
      this.orientationList.add("LH - OUT SWING");
    }
    if (orientation_RH_Rverse == true) {
      this.orientationList.add("RH - REVERSE SWING");
    }
    if (orientation_RH_Out == true) {
      this.orientationList.add("RH - OUT SWING");
    }
    if (orientation_LH_Rverse1 == true) {
      this.orientation1List.add("LH - IN");
    }
    if (orientation_LH_Out1 == true) {
      this.orientation1List.add("LH - OUT");
    }
    if (orientation_RH_Rverse1 == true) {
      this.orientation1List.add("RH - IN");
    }
    if (orientation_RH_Out1 == true) {
      this.orientation1List.add("RH - OUT");
    }
    if (orientation_LH_Rverse2 == true) {
      this.orientation2List.add("LH - IN");
    }
    if (orientation_LH_Out2 == true) {
      this.orientation2List.add("LH - OUT");
    }
    if (orientation_RH_Rverse2 == true) {
      this.orientation2List.add("RH - IN");
    }
    if (orientation_RH_Out2 == true) {
      this.orientation2List.add("RH - OUT");
    }*/

    /*---------------------- Electriacal -----------------*/

    if (electricalEntrance == "Needs Repair") {
      //this.serviceEntList.add("Needs Repair");
      electricalEntrance = "Needs Repair";
    }

    if (electricalEntrance == "Needs Replacement") {
      // this.serviceEntList.add("Needs Replacement");
      electricalEntrance = "Needs Replacement";
    }

    if (electricalPole == "Needs Repair") {
      //  this.servicePoleList.add("Needs Repair");
      electricalPole = "Needs Repair";
    }

    if (electricalPole == "Needs Replacement") {
      // this.servicePoleList.add("Needs Replacement");
      electricalPole = "Needs Replacement";
    }

    if (electricalInterior == "Yes") {
      // this.yerornoList.add("Yes");
      electricalInterior = "Yes";
    }

    if (electricalInterior == "No") {
      // this.yerornoList.add("No");
      electricalInterior = "No";
    }
    /*if (serviceRepair == true) {
      this.serviceEntList.add("Needs Repair");
    }
    if (serviceReplacement == true) {
      this.serviceEntList.add("Needs Replacement");
    }
    if (servicePoleRepair == true) {
      this.servicePoleList.add("Needs Repair");
    }
    if (servicePoleReplacement == true) {
      this.servicePoleList.add("Needs Replacement");
    }
    if (eleInteriorYes == true) {
      this.yerornoList.add("Yes");
    }
    if (eleInteriorNo == true) {
      this.yerornoList.add("No");
    }*/

    if (eleGroundRod == true) {
      this.groundRodList.add("Needs Replacement");
    }
    if (eleGroundClamp == true) {
      this.groundClampList.add("Needs Replacement");
    }

    if (eleGroundwire == true) {
      this.groundWireList.add("Needs Replacement");
    }

    if (plumingwater == true) {
      this.groundWatersupplyList.add("Needs Repair");
    }

    if (plumbingwater == "Needs Repair") {
      //  this.groundWaterClosestList.add("Needs Repair");
      plumbingwater = "Needs Repair";
    }

    if (plumbingwater == "Needs Replacement") {
      //   this.groundWaterClosestList.add("Needs Replacement");
      plumbingwater = "Needs Replacement";
    }

    /* if (plumingwaterclosetRepair == true) {
      this.groundWaterClosestList.add("Needs Repair");
    }
    if (plumingwaterclosetReplacment == true) {
      this.groundWaterClosestList.add("Needs Replacement");
    }*/

    if (plumingservicePipe1 == true) {
      this.servicePipeList.add("Needs Repair");
    }

    if (plumingservicePipe2 == true) {
      this.servicePipe1List.add("Needs Repair");
    }

    if (plumingservicePipe3 == true) {
      this.servicePipe2List.add("Needs Repair");
    }

    Map<String, dynamic>? plumbingPipes = Map();
    for (int i = 0; i < noOfPlumbingFields; i++) {
      if (i != 0) {
        plumbingPipes[
            ('length-of-damage-feet-extra-${NumberToWord().convert('en-in', i)}')
                .trim()] = plumingService1FeetControllerExtra[i].text;
        plumbingPipes[
            ('length-of-damage-inches-extra-${NumberToWord().convert('en-in', i)}')
                .trim()] = plumingService1InchControllerExtra[i].text;
        plumbingPipes[('pipe-lable-extra-${NumberToWord().convert('en-in', i)}')
            .trim()] = lableTextContorllerExtra[i].text;
      } else {
        plumbingPipes['length-of-damage-feet-extra'] =
            plumingService1FeetControllerExtra[i].text;
        plumbingPipes['length-of-damage-inches-extra'] =
            plumingService1InchControllerExtra[i].text;
        plumbingPipes['pipe-lable-extra'] = lableTextContorllerExtra[i].text;
      }
    }

    Map<String, dynamic>? windowData = Map();

    for (int i = 0; i < noOfWindowForms; i++) {
      if (i != 0) {
        windowData[('type-${NumberToWord().convert('en-in', i)}').trim()] =
            windowtype[i];
        windowData[('colonial-style-${NumberToWord().convert('en-in', i)}')
            .trim()] = windowColonialStyle[i];
        windowData[('window-style-${NumberToWord().convert('en-in', i)}')
            .trim()] = windowStyle[i];
        windowData[('quantity-${NumberToWord().convert('en-in', i)}').trim()] =
            windowQuantityController[i].text;
        windowData[('size-height-feet-${NumberToWord().convert('en-in', i)}')
            .trim()] = windowSizeHeightFeetController[i].text;
        windowData[('size-height-inches-${NumberToWord().convert('en-in', i)}')
            .trim()] = windowSizeHeightInchController[i].text;
        windowData[('size-width-feet-${NumberToWord().convert('en-in', i)}')
            .trim()] = windowSizeWidthFeetController[i].text;
        windowData[('size-width-inches-${NumberToWord().convert('en-in', i)}')
            .trim()] = windowSizeWidthInchController[i].text;
      } else {
        windowData['type'] = windowtype[i];
        windowData['colonial-style'] = windowColonialStyle[i];
        windowData['window-style'] = windowStyle[i];
        windowData['quantity'] = windowQuantityController[i].text;
        windowData['size-height-feet'] = windowSizeHeightFeetController[i].text;
        windowData['size-height-inches'] =
            windowSizeHeightInchController[i].text;
        windowData['size-width-feet'] = windowSizeWidthFeetController[i].text;
        windowData['size-width-inches'] = windowSizeWidthInchController[i].text;
      }
    }
    data = {
      'step': '2',
      'eave-flashing-inches': evenInchController.text,
      'eave-flashing-feet': evenFeetController.text,
      'eave-flashing-size': evenSizeInchController.text,
      'fascia-board-feet': fasciaFeetController.text,
      'fascia-board-inches': fasciaInchController.text,
      'fascia-board-size-inches-one': fasciaSizeFeetController.text,
      'fascia-board-size-inches-two': fasciaSizeInchController.text,
      'soffit-height-feet': soffitBoardFeetController.text,
      'soffit-height-inches': soffitBoardInchController.text,
      'soffit-width-feet': soffitHeightFeetController.text,
      'soffit-width-inches': soffitHeightInchController.text,
      'soffit-type': '$_sofiTypeID',
      'shingles-height-feet': shinglesHeightFeetController.text,
      'shingles-height-inches': shinglesHeightInchController.text,
      'shingles-width-feet': shinglesWidthFeetController.text,
      'shingles-width-inches': shinglesWidthInchController.text,
      'shingle-style': '$_shinglesTypeID',
      'plywood-height-feet': plywoodHeightFeetController.text,
      'plywood-height-inches': plywoodHeightInchController.text,
      'plywood-width-feet': plywoodWidthFeetController.text,
      'plywood-width-inches': plywoodWidthInchController.text,
      'ice-and-water-shield-height-feet': iceHeightFeetController.text,
      'ice-and-water-shield-width-feet': iceWidthFeetController.text,
      'ice-and-water-shield-width-inches': iceWidthInchController.text,
      'ice-and-water-shield-height-inches': iceHeightInchController.text,
      'torch-on-height-feet': torchHeightFeetController.text,
      'torch-on-height-inches': torchHeightInchController.text,
      'torch-on-width-feet': torchWidthFeetController.text,
      'torch-on-width-inches': torchWidthInchController.text,
      'tough-guard-height-feet': toughHeightFeetController.text,
      'tough-guard-height-inches': toughHeightInchController.text,
      'tough-guard-width-feet': toughWidthFeetController.text,
      'tough-guard-width-inches': toughWidthInchController.text,
      'location': doorLocation,
      'door-type': doorType,
      'meterial': _materialId,
      'orientation': doorOrientation,
      'door-quantity': doorQuantityController.text,
      'door-size-height-feet': doorSizeHeightFeetController.text,
      'door-size-height-inches': doorSizeHeightInchController.text,
      'door-size-width-feet': doorSizeWidthFeetController.text,
      'door-size-width-inches': doorSizeWidthInchController.text,
      'location-one': doorLocation1,
      'door-type-one': doorType1,
      'meterial-one': _materialId1,
      'orientation-one': doorOrientation1,
      'door-quantity-one': doorQuantity1Controller.text,
      'door-size-height-feet-one': doorSize1HeightFeetController.text,
      'door-size-height-inches-one': doorSize1HeightInchController.text,
      'door-size-width-feet-one': doorSize1WidthFeetController.text,
      'door-size-width-inches-one': doorSize1WidthInchController.text,
      'location-two': doorLocation2,
      'door-type-two': doorType2,
      'meterial-two': _materialId2,
      'orientation-two': doorOrientation2,
      'door-quantity-two': doorQuantity2Controller.text,
      'door-size-height-feet-two': doorSize2HeightFeetController.text,
      'door-size-height-inches-two': doorSize2HeightInchController.text,
      'door-size-width-feet-two': doorSize2WidthFeetController.text,
      'door-size-width-inches-two': doorSize2WidthInchController.text,
      'service-entrance': electricalEntrance,
      'service-pole': electricalPole,
      'meter-can-size': eleMeterSizeController.text,
      'meter-switch-size': eleMeterSizeController.text,
      'interior-flooding': electricalInterior,
      'flooding-height-feet': elaFloadingFeetController.text,
      'flooding-height-inches': elaFloadingInchController.text,
      'ground-rod': groundRodList,
      'ground-clamp': groundClampList,
      'ground-wire': groundWireList,
      'water-supply': groundWatersupplyList,
      'water-closet': plumbingwater,
      '1/2-service-pipe': servicePipeList,
      'length-of-damage-feet': plumingLengthFeetController.text,
      'length-of-damage-inches': plumingLengthInchController.text,
      '3/4-service-pipe': servicePipe1List,
      'length-of-damage-feet-one': plumingServiceFeetController.text,
      'length-of-damage-inches-one': plumingServiceInchController.text,
      '1-service-pipe': servicePipe2List,
      'length-of-damage-feet-two': plumingService1FeetController.text,
      'length-of-damage-inches-two': plumingService1InchController.text,
      'form_type': 'create',
      'request_id': '${widget.ids}'
    };
    data?.addAll(windowData);
    data?.addAll(plumbingPipes);

    //_updateDetail(data);
    inspect(data);

    // for(int i=0; i<selectedItems.length; i++){
    //
    //   print(selectedItems[i].orderId!);
    //
    //   data!.addAll({"order_id[$i]":selectedItems[i].orderId!.toString()});
    //
    //
    // }
    String _enGroundRodList = jsonEncode(groundRodList);
    String _enGroundClampList = jsonEncode(groundClampList);
    String _enGroundWireList = jsonEncode(groundWireList);
    String _enGroundWatersupplyList = jsonEncode(groundWatersupplyList);
    // String _enGroundWaterClosestList = jsonEncode(groundWaterClosestList);
    String _enServicePipeList = jsonEncode(servicePipeList);
    String _enServicePipe1List = jsonEncode(servicePipe1List);
    String _enServicePipe2List = jsonEncode(servicePipe2List);

    if (_updateDB == false) {
      var user = AssesmentDataBaseModel();
      user.eaveFlashingFeet = evenFeetController.text;
      user.eaveFlashingInches = evenInchController.text;
      user.eaveFlashingSize = evenSizeInchController.text;
      user.fasciaBoardFeet = fasciaFeetController.text;
      user.fasciaBoardInches = fasciaInchController.text;
      user.fasciaBoardSizeInchesOne = fasciaSizeFeetController.text;
      user.fasciaBoardSizeInchesTwo = fasciaSizeInchController.text;
      user.soffitHeightFeet = soffitBoardFeetController.text;
      user.soffitHeightInches = soffitBoardInchController.text;
      user.soffitWidthFeet = soffitHeightFeetController.text;
      user.soffitWidthInches = soffitHeightInchController.text;
      user.soffitType = _sofiTypeID;
      user.shinglesHeightFeet = shinglesHeightFeetController.text;
      user.shinglesHeightInches = shinglesHeightInchController.text;
      user.shinglesWidthFeet = shinglesWidthFeetController.text;
      user.shinglesWidthInches = shinglesWidthInchController.text;
      user.shingleStyle = _shinglesTypeID;
      user.plywoodHeightFeet = plywoodHeightFeetController.text;
      user.plywoodHeightInches = plywoodHeightInchController.text;
      user.plywoodWidthFeet = plywoodWidthFeetController.text;
      user.plywoodWidthInches = plywoodWidthInchController.text;
      user.iceAndWaterShieldHeightFeet = iceHeightFeetController.text;
      user.iceAndWaterShieldHeightInches = iceHeightInchController.text;
      user.iceAndWaterShieldWidthFeet = iceWidthFeetController.text;
      user.iceAndWaterShieldWidthInches = iceWidthInchController.text;
      user.torchOnHeightFeet = torchHeightFeetController.text;
      user.torchOnHeightInches = torchHeightInchController.text;
      user.torchOnWidthFeet = torchWidthFeetController.text;
      user.torchOnWidthFeet = torchWidthInchController.text;
      user.toughGuardHeightFeet = toughHeightFeetController.text;
      user.toughGuardHeightInches = toughHeightInchController.text;
      user.toughGuardWidthFeet = toughWidthFeetController.text;
      user.toughGuardWidthInches = toughWidthInchController.text;

      user.quantity = windowQuantityController[0].text;
      user.sizeHeightFeet = windowSizeHeightFeetController[0].text;
      user.sizeHeightInches = windowSizeHeightInchController[0].text;
      user.sizeWidthInches = windowSizeWidthInchController[0].text;
      user.sizeWidthFeet = windowSizeWidthFeetController[0].text;

      user.location = doorLocation;
      user.doorType = doorType;
      user.material = _materialId;
      user.orientation = doorOrientation;
      user.doorQuantity = doorQuantityController.text;
      user.doorSizeHeightFeet = doorSizeHeightFeetController.text;
      user.doorSizeHeightInches = doorSizeHeightInchController.text;
      user.doorSizeWidthFeet = doorSizeWidthFeetController.text;
      user.doorSizeWidthInches = doorSizeWidthInchController.text;

      user.locationOne = doorLocation1;
      user.doorTypeOne = doorType1;
      user.materialOne = _materialId1;
      user.orientationOne = doorOrientation1;
      user.doorQuantityOne = doorQuantity1Controller.text;
      user.doorSizeHeightFeetOne = doorSize1HeightFeetController.text;
      user.doorSizeHeightInchesOne = doorSize1HeightInchController.text;
      user.doorSizeWidthFeetOne = doorSize1WidthFeetController.text;
      user.doorSizeWidthInchesOne = doorSize1WidthInchController.text;

      user.locationTwo = doorLocation2;
      user.doorTypeTwo = doorType2;
      user.materialTwo = _materialId2;
      user.orientationTwo = doorOrientation2;
      user.doorQuantityTwo = doorQuantity2Controller.text;
      user.doorSizeHeightFeetTwo = doorSize2HeightFeetController.text;
      user.doorSizeHeightInchesTwo = doorSize2HeightInchController.text;
      user.doorSizeWidthFeetTwo = doorSize2WidthFeetController.text;
      user.doorSizeWidthInchesTwo = doorSize2WidthInchController.text;

      user.serviceEntrance = electricalEntrance;
      user.servicePole = electricalPole;
      user.meterCanSize = eleMeterSizeController.text;
      user.meterSwitchSize = elaMeterSwitchController.text;
      user.interiorFlooding = electricalInterior;
      user.floodingHeightFeet = elaFloadingFeetController.text;
      user.floodingHeightInches = elaFloadingInchController.text;
      user.groundRod = _enGroundRodList;
      user.groundClamp = _enGroundClampList;
      user.groundWire = _enGroundWireList;
      user.waterSupply = _enGroundWatersupplyList;
      user.waterCloset = plumbingwater;
      user.s12ServicePipe = _enServicePipeList;
      user.lengthOfDamageFeet = plumingLengthFeetController.text;
      user.lengthOfDamageInches = plumingLengthInchController.text;
      user.s34ServicePipe = _enServicePipe1List;
      user.lengthOfDamageFeetOne = plumingServiceFeetController.text;
      user.lengthOfDamageInchesOne = plumingServiceInchController.text;
      user.s1ServicePipe = _enServicePipe2List;
      user.lengthOfDamageFeetTwo = plumingService1FeetController.text;
      user.lengthOfDamageInchesTwo = plumingService1InchController.text;
      user.name = widget.str_name;
      user.emailAddress = widget.str_email;
      user.additionalComment = "";
      user.damageSnaps = "";

      user.requestKey = widget.ids;
      var result = await _userService.SaveUser(user);
      print("gbfgffgfgfdgfgfg $result");

      if (result != null) {
        widget.tabonTab!(list: [true, false, true]);

        widget.tabController.animateTo(1);
      }
    } else {
      var user = AssesmentDataBaseModel();
      user.id = testList[0].id!;
      user.eaveFlashingFeet = evenFeetController.text;
      user.eaveFlashingInches = evenInchController.text;
      user.eaveFlashingSize = evenSizeInchController.text;
      user.fasciaBoardFeet = fasciaFeetController.text;
      user.fasciaBoardInches = fasciaInchController.text;
      user.fasciaBoardSizeInchesOne = fasciaSizeFeetController.text;
      user.fasciaBoardSizeInchesTwo = fasciaSizeInchController.text;
      user.soffitHeightFeet = soffitBoardFeetController.text;
      user.soffitHeightInches = soffitBoardInchController.text;
      user.soffitWidthFeet = soffitHeightFeetController.text;
      user.soffitWidthInches = soffitHeightInchController.text;
      user.soffitType = _sofiTypeID;
      user.shinglesHeightFeet = shinglesHeightFeetController.text;
      user.shinglesHeightInches = shinglesHeightInchController.text;
      user.shinglesWidthFeet = shinglesWidthFeetController.text;
      user.shinglesWidthInches = shinglesWidthInchController.text;
      user.shingleStyle = _shinglesTypeID;
      user.plywoodHeightFeet = plywoodHeightFeetController.text;
      user.plywoodHeightInches = plywoodHeightInchController.text;
      user.plywoodWidthFeet = plywoodWidthFeetController.text;
      user.plywoodWidthInches = plywoodWidthInchController.text;
      user.iceAndWaterShieldHeightFeet = iceHeightFeetController.text;
      user.iceAndWaterShieldHeightInches = iceHeightInchController.text;
      user.iceAndWaterShieldWidthFeet = iceWidthFeetController.text;
      user.iceAndWaterShieldWidthInches = iceWidthInchController.text;
      user.torchOnHeightFeet = torchHeightFeetController.text;
      user.torchOnHeightInches = torchHeightInchController.text;
      user.torchOnWidthFeet = torchWidthFeetController.text;
      user.torchOnWidthFeet = torchWidthInchController.text;
      user.toughGuardHeightFeet = toughHeightFeetController.text;
      user.toughGuardHeightInches = toughHeightInchController.text;
      user.toughGuardWidthFeet = toughWidthFeetController.text;
      user.toughGuardWidthInches = toughWidthInchController.text;

      user.location = doorLocation;
      user.doorType = doorType;
      user.material = _materialId;
      user.orientation = doorOrientation;
      user.doorQuantity = doorQuantityController.text;
      user.doorSizeHeightFeet = doorSizeHeightFeetController.text;
      user.doorSizeHeightInches = doorSizeHeightInchController.text;
      user.doorSizeWidthFeet = doorSizeWidthFeetController.text;
      user.doorSizeWidthInches = doorSizeWidthInchController.text;

      user.locationOne = doorLocation1;
      user.doorTypeOne = doorType1;
      user.materialOne = _materialId1;
      user.orientationOne = doorOrientation1;
      user.doorQuantityOne = doorQuantity1Controller.text;
      user.doorSizeHeightFeetOne = doorSize1HeightFeetController.text;
      user.doorSizeHeightInchesOne = doorSize1HeightInchController.text;
      user.doorSizeWidthFeetOne = doorSize1WidthFeetController.text;
      user.doorSizeWidthInchesOne = doorSize1WidthInchController.text;

      user.locationTwo = doorLocation2;
      user.doorTypeTwo = doorType2;
      user.materialTwo = _materialId2;
      user.orientationTwo = doorOrientation2;
      user.doorQuantityTwo = doorQuantity2Controller.text;
      user.doorSizeHeightFeetTwo = doorSize2HeightFeetController.text;
      user.doorSizeHeightInchesTwo = doorSize2HeightInchController.text;
      user.doorSizeWidthFeetTwo = doorSize2WidthFeetController.text;
      user.doorSizeWidthInchesTwo = doorSize2WidthInchController.text;

      user.serviceEntrance = electricalEntrance;
      user.servicePole = electricalPole;
      user.meterCanSize = eleMeterSizeController.text;
      user.meterSwitchSize = elaMeterSwitchController.text;
      user.interiorFlooding = electricalInterior;
      user.floodingHeightFeet = elaFloadingFeetController.text;
      user.floodingHeightInches = elaFloadingInchController.text;
      user.groundRod = _enGroundRodList;
      user.groundClamp = _enGroundClampList;
      user.groundWire = _enGroundWireList;
      user.waterSupply = _enGroundWatersupplyList;
      user.waterCloset = plumbingwater;
      user.s12ServicePipe = _enServicePipeList;
      user.lengthOfDamageFeet = plumingLengthFeetController.text;
      user.lengthOfDamageInches = plumingLengthInchController.text;
      user.s34ServicePipe = _enServicePipe1List;
      user.lengthOfDamageFeetOne = plumingServiceFeetController.text;
      user.lengthOfDamageInchesOne = plumingServiceInchController.text;
      user.s1ServicePipe = _enServicePipe2List;
      user.lengthOfDamageFeetTwo = plumingService1FeetController.text;
      user.lengthOfDamageInchesTwo = plumingService1InchController.text;
      user.additionalComment = "${testList[0].additionalComment}";
      user.damageSnaps = "${testList[0].damageSnaps}";
      user.name = widget.str_name;
      user.emailAddress = widget.str_email;

      user.type = windowtype[0];
      user.colonialStyle = windowColonialStyle[0];
      user.windowStyle = windowStyle[0];
      user.quantity = windowQuantityController[0].text;
      user.sizeHeightFeet = windowSizeHeightFeetController[0].text;
      user.sizeHeightInches = windowSizeHeightInchController[0].text;
      user.sizeWidthInches = windowSizeWidthInchController[0].text;
      user.sizeWidthFeet = windowSizeWidthFeetController[0].text;

      if (windowtype.length > 1) {
        user.typeOne = windowtype[1];
        user.colonialStyleOne = windowColonialStyle[1];
        user.windowStyleOne = windowStyle[1];
        user.quantityOne = windowQuantityController[1].text;
        user.sizeHeightFeetOne = windowSizeHeightFeetController[1].text;
        user.sizeHeightInchesOne = windowSizeHeightInchController[1].text;
        user.sizeWidthInchesOne = windowSizeWidthInchController[1].text;
        user.sizeWidthFeetOne = windowSizeWidthFeetController[1].text;
      }
      if (windowtype.length > 2) {
        user.typeTwo = windowtype[2];
        user.colonialStyleTwo = windowColonialStyle[2];
        user.windowStyleTwo = windowStyle[2];
        user.quantityTwo = windowQuantityController[2].text;
        user.sizeHeightFeetTwo = windowSizeHeightFeetController[2].text;
        user.sizeHeightInchesTwo = windowSizeHeightInchController[2].text;
        user.sizeWidthInchesTwo = windowSizeWidthInchController[2].text;
        user.sizeWidthFeetTwo = windowSizeWidthFeetController[2].text;
      }

//=================================================

      user.requestKey = widget.ids;

      var result = await _userService.UpdateUser(user);
      print('Updateeeeeeeeeee 1111 ${result}');

      widget.tabonTab!(list: [true, false, true]);

      widget.tabController.animateTo(1);
    }

    print('CHEKKKKKKKKKK VALUESSSSSSS 1111 ${data}');
  }

// void _updateDetail(_datas) async {
//   setState(() {
//     isLoading = true;
//   });
//
//   dynamic res = await _apiClient.damagesApi(_datas, widget.ids);
//   setState(() {
//     isLoading = false;
//   });
//   if (res?.statusCode == 200) {
//     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     //   content: const Text('Assessment Form Store Successfully'),
//     //   backgroundColor: Colors.green.shade300,
//     // ));
//
//     widget.tabonTab!(list: [true, false, true]);
//
//     widget.tabController.animateTo(1);
//     // Navigator.push(
//     //     context,
//     //     MaterialPageRoute(
//     //         builder: (context) => Basic(ids: '',)));
//   } else {
//     setState(() {
//       isLoading = false;
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(res.data['error']),
//         backgroundColor: Colors.red.shade300,
//       ),
//     );
//   }
// }

  save(String accessToken) async {
    localStorage.setString('access_token', accessToken);
  }

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => SecondRoute()),
      // );
    }
  }

  void prefildata() {
    if (dataList.soffitType != "NA") {
      for (int ii = 0; ii < firstDropDownList.length; ii++) {
        if (firstDropDownList[ii].id == dataList.soffitType!) {
          setState(() {
            _sofiTypeID = dataList.soffitType!;
            _currentSelectedValue = firstDropDownList[ii];
          });
        }
      }
    }

    if (dataList.shingleStyle != "NA") {
      for (int ii = 0; ii < secondDropDownList.length; ii++) {
        if (secondDropDownList[ii].id == dataList.shingleStyle!) {
          setState(() {
            _shinglesTypeID = dataList.shingleStyle!;
            _currentSecondSelectedValue = secondDropDownList[ii];
          });
        }
      }
    }

    if (dataList.meterial != "NA") {
      for (int ii = 0; ii < materialFirst.length; ii++) {
        if (materialFirst[ii].id == dataList.meterial!) {
          setState(() {
            _materialId = dataList.meterial!;
            _currentMeterial1SelectedValue = materialFirst[ii];
          });
        }
      }
    }

    if (dataList.meterialOne != "NA") {
      for (int ii = 0; ii < materialSecond.length; ii++) {
        if (materialSecond[ii].id == dataList.meterialOne!) {
          setState(() {
            _materialId1 = dataList.meterialOne!;
            _currentMeterial2SelectedValue = materialSecond[ii];
          });
        }
      }
    }

    if (dataList.meterialTwo != "NA") {
      for (int ii = 0; ii < materialThird.length; ii++) {
        if (materialThird[ii].id == dataList.meterialTwo!) {
          setState(() {
            _materialId2 = dataList.meterialTwo!;
            _currentMeterial3SelectedValue = materialThird[ii];
          });
        }
      }
    }

    if (dataList != null) {
      windowColonialStyle.clear();
      windowtypeid.clear();
      windowtype.clear();
      windowtypeColonialStyleID.clear();
      windowStyleID.clear();
      windowStyle.clear();
    }
    int countWindowQuantity = 0;
    int countHeightFeetController = 0;
    int countHeightInchController = 0;
    int countWidthFeetController = 0;
    int countWidthInchController = 0;

    dataList.toJson().forEach((key, value) {
      print(key + ':  ' + value.toString() + '----------------------------');
      if (key.length >= 4) {
        if (key.substring(0, 4) == 'type' && value != "NA" && value != null) {
          print(key + '   ' + value.toString() + ' type');

          if (value == "NON-IMPACT") {
            windowtypeid.add(1);
            windowtype.add("NON-IMPACT");
          }
          if (value == "HURRICANE IMPACT") {
            windowtype.add(value);
            windowtypeid.add(2);
          }
        }
      }
      if (key.length >= 14) {
        if (key.substring(0, 14) == 'colonial-style' &&
            value != "NA" &&
            value != null) {
          if (value == "COLONIAL") {
            windowtypeColonialStyleID.add(1);
            windowColonialStyle.add("COLONIAL");
          }

          if (value == "NON-COLONIAL") {
            windowtypeColonialStyleID.add(2);
            windowColonialStyle.add("NON-COLONIAL");
          }
        }
      }
      if (key.length >= 12) {
        if (key.substring(0, 12) == 'window-style' &&
            value != "NA" &&
            value != null) {
          if (value == "AWNING") {
            windowStyleID.add(1);
            windowStyle.add("AWNING");
          }

          if (value == "SLIDER") {
            windowStyleID.add(2);
            windowStyle.add("SLIDER");
          }

          if (value == "COLONIAL") {
            windowStyleID.add(3);
            windowStyle.add("COLONIAL");
          }

          if (value == "PUSH UP") {
            windowStyleID.add(4);
            windowStyle.add("PUSH UP");
          }
        }
      }
      if (key.length >= 8) {
        if (key.substring(0, 8) == 'quantity') {
          setState(() {
            windowQuantityController.add(TextEditingController());
            windowQuantityController[countWindowQuantity].text =
                value != "NA" && value != null ? value : '';
            countWindowQuantity += 1;
          });
        }
      }
      if (key.length >= 16) {
        if (key.substring(0, 16) == 'size-height-feet') {
          setState(() {
            windowSizeHeightFeetController.add(TextEditingController());
            windowSizeHeightFeetController[countHeightFeetController].text =
                value != "NA" && value != null ? value : '';
            countHeightFeetController += 1;
          });
        }
      }
      if (key.length >= 18) {
        if (key.substring(0, 18) == 'size-height-inches') {
          setState(() {
            windowSizeHeightInchController.add(TextEditingController());
            windowSizeHeightInchController[countHeightInchController].text =
                value != "NA" && value != null ? value : '';
            countHeightInchController += 1;
          });
        }
      }
      if (key.length >= 15) {
        if (key.substring(0, 15) == 'size-width-feet') {
          setState(() {
            windowSizeWidthFeetController.add(TextEditingController());
            windowSizeWidthFeetController[countWidthFeetController].text =
                value != "NA" && value != null ? value : '';
            countWidthFeetController += 1;
          });
        }
      }
      if (key.length >= 17) {
        if (key.substring(0, 17) == 'size-width-inches') {
          setState(() {
            windowSizeWidthInchController.add(TextEditingController());
            windowSizeWidthInchController[countWidthInchController].text =
                value != "NA" && value != null ? value : '';
            countWidthInchController += 1;
          });
        }
      }
    });

    setState(() {
      windowtypeColonialStyleID = windowtypeColonialStyleID.reversed.toList();
      windowColonialStyle = windowColonialStyle.reversed.toList();
      if (windowtype.isEmpty) {
        setState(() {
          addTextController();
          noOfWindowForms = 1;
        });
      } else {
        noOfWindowForms = windowtype.length;
      }
    });
    if (dataList.location != "NA") {
      // String _locations = dataList.location!;
      // List<String> lList = _locations.split(",");

      //for (int ci = 0; ci < lList.length; ci++) {
      if (dataList.location == "INTERIOR") {
        setState(() {
          //locationInterior = true;
          doorLocationID = 1;
          doorLocation = "INTERIOR";
        });
      }

      if (dataList.location == "EXTERIOR") {
        setState(() {
          // locationExterrior = true;
          doorLocationID = 2;
          doorLocation = "EXTERIOR";
        });
      }

      //  print(lList);
      //}
    }

    if (dataList.locationOne != "NA") {
      // String _locationOne = dataList.locationOne!;
      //  List<String> lOneList = _locationOne.split(",");

      //for (int ci = 0; ci < lOneList.length; ci++) {
      if (dataList.locationOne == "INTERIOR") {
        setState(() {
          //  locationInterior1 = true;
          doorLocationID1 = 1;
          doorLocation1 = "INTERIOR";
        });
      }

      if (dataList.locationOne == "EXTERIOR") {
        setState(() {
          //locationExterrior1 = true;
          doorLocationID1 = 2;
          doorLocation1 = "EXTERIOR";
        });
      }

      //  print(lOneList);
      // }
    }

    if (dataList.locationTwo != "NA") {
      // String _locationTwo = dataList.locationTwo!;
      // List<String> lTwoList = _locationTwo.split(",");

      // for (int ci = 0; ci < lTwoList.length; ci++) {
      if (dataList.locationTwo == "INTERIOR") {
        setState(() {
          //locationInterior2 = true;
          doorLocationID2 = 1;
          doorLocation2 = "INTERIOR";
        });
      }

      if (dataList.locationTwo == "EXTERIOR") {
        setState(() {
          //locationExterrior2 = true;
          doorLocationID2 = 2;
          doorLocation2 = "EXTERIOR";
        });
      }

      // print(lTwoList);
      //  }
    }

    if (dataList.doorType != "NA") {
      //  String _doorType = dataList.doorType!;
      //   List<String> _doorTypeList = _doorType.split(",");

      // for (int ci = 0; ci < _doorTypeList.length; ci++) {
      if (dataList.doorType == "SOLID CORE") {
        setState(() {
          // locationSolidCore = true;
          doorTypeID = 1;
          doorType = "SOLID CORE";
        });
      }

      if (dataList.doorType == "HOLLOW CORE") {
        setState(() {
          // locationHollow = true;

          doorTypeID = 2;
          doorType = "HOLLOW CORE";
        });
      }

      // print(doorTypeList);
      // }
    }

    if (dataList.doorTypeOne != "NA") {
      //  String _doorTypeOne = dataList.doorTypeOne!;
      //  List<String> _doorTypeOneList = _doorTypeOne.split(",");

      //for (int ci = 0; ci < _doorTypeOneList.length; ci++) {
      if (dataList.doorTypeOne == "SOLID CORE") {
        setState(() {
          // locationSolidCore1 = true;
          doorType1 = "SOLID CORE";
          doorTypeID1 = 1;
        });
      }

      if (dataList.doorTypeOne == "HOLLOW CORE") {
        setState(() {
          // locationHollow1 = true;
          doorTypeID1 = 2;
          doorType1 = "HOLLOW CORE";
        });
      }

      // print(_doorTypeOneList);
      //  }
    }

    if (dataList.doorTypeTwo != "NA") {
      //  String _doorTypeTwo = dataList.doorTypeTwo!;
      // List<String> _doorTypeTwoList = _doorTypeTwo.split(",");

      // for (int ci = 0; ci < _doorTypeTwoList.length; ci++) {
      if (dataList.doorTypeTwo == "SOLID CORE") {
        setState(() {
          // locationSolidCore2 = true;
          doorType2 = "SOLID CORE";
          doorTypeID2 = 1;
        });
      }

      if (dataList.doorTypeTwo == "HOLLOW CORE") {
        setState(() {
          // locationHollow2 = true;
          doorTypeID2 = 2;
          doorType2 = "HOLLOW CORE";
        });
      }

      //  print(_doorTypeTwoList);
      // }
    }

    if (dataList.orientation != "NA") {
      // String _orientation = dataList.orientation!;
      //  List<String> _orientationList = _orientation.split(",");

      // for (int ci = 0; ci < _orientationList.length; ci++) {
      if (dataList.orientation == "LH - IN") {
        setState(() {
          // orientation_LH_Rverse = true;
          doorOrientationID = 1;
          doorOrientation = "LH - IN";
        });
      }

      if (dataList.orientation == "LH - OUT") {
        setState(() {
          // orientation_LH_Out = true;
          // doorOrientation = "LH - OUT SWING";
          doorOrientation = "LH - OUT";
          doorOrientationID = 2;
        });
      }

      if (dataList.orientation == "RH - IN") {
        setState(() {
          // orientation_RH_Rverse = true;
          doorOrientation = "RH - IN";
          doorOrientationID = 3;
        });
      }

      if (dataList.orientation == "RH - OUT") {
        setState(() {
          // orientation_RH_Out = true;
          // doorOrientation = "RH - OUT SWING";
          doorOrientation = "RH - OUT";
          doorOrientationID = 4;
        });
      }

      //  print(_orientationList);
      // }
    }

    if (dataList.orientationOne != "NA") {
      // String _orientationOne = dataList.orientationOne!;
      //List<String> _orientationOneList = _orientationOne.split(",");

      //   for (int ci = 0; ci < _orientationOneList.length; ci++) {
      if (dataList.orientationOne == "LH - IN") {
        setState(() {
          // orientation_LH_Rverse1 = true;

          doorOrientationID1 = 1;
          doorOrientation1 = "LH - IN";
        });
      }

      if (dataList.orientationOne == "LH - OUT") {
        setState(() {
          //  orientation_LH_Out1 = true;

          doorOrientationID1 = 2;
          doorOrientation1 = "LH - OUT";
        });
      }

      if (dataList.orientationOne == "RH - IN") {
        setState(() {
          //orientation_RH_Rverse1 = true;
          doorOrientationID1 = 3;
          doorOrientation1 = "RH - IN";
        });
      }

      if (dataList.orientationOne == "RH - OUT") {
        setState(() {
          // orientation_RH_Out1 = true;
          doorOrientation1 = "RH - OUT";
          doorOrientationID1 = 4;
        });
      }

      //  print(_orientationOneList);
      // }
    }

    if (dataList.orientationTwo != "NA") {
      //  String _orientationTwo = dataList.orientationTwo!;
      //  List<String> _orientationTwoList = _orientationTwo.split(",");

      // for (int ci = 0; ci < _orientationTwoList.length; ci++) {
      if (dataList.orientationTwo == "LH - IN") {
        setState(() {
          //  orientation_LH_Rverse2 = true;
          doorOrientationID2 = 1;
          doorOrientation2 = "LH - IN";
        });
      }

      if (dataList.orientationTwo == "LH - OUT") {
        setState(() {
          // orientation_LH_Out2 = true;
          doorOrientationID2 = 2;
          doorOrientation2 = "LH - OUT";
        });
      }

      if (dataList.orientationTwo == "RH - IN") {
        setState(() {
          // orientation_RH_Rverse2 = true;
          doorOrientationID2 = 3;
          doorOrientation2 = "RH - IN";
        });
      }

      if (dataList.orientationTwo == "RH - OUT") {
        setState(() {
          //orientation_RH_Out2 = true;
          doorOrientation2 = "RH - OUT";
          doorOrientationID2 = 4;
        });
      }

      // print(_orientationTwoList);
      // }
    }

    if (dataList.serviceEntrance != "NA") {
      //  String _serviceEntrance = dataList.serviceEntrance!;
      //   List<String> _serviceEntranceList = _serviceEntrance.split(",");

      //  for (int ci = 0; ci < _serviceEntranceList.length; ci++) {
      if (dataList.serviceEntrance == "Needs Repair") {
        setState(() {
          //serviceRepair = true;
          electricalEntranceID = 1;
          electricalEntrance = "Needs Repair";
        });
      }

      if (dataList.serviceEntrance == "Needs Replacement") {
        setState(() {
          //serviceReplacement = true;
          electricalEntranceID = 2;
          electricalEntrance = "Needs Replacement";
        });
      }

      // print(_serviceEntranceList);
      // }
    }

    if (dataList.servicePole != "NA") {
      //  String _servicePole = dataList.servicePole!;
      //    List<String> _servicePoleList = _servicePole.split(",");

      // for (int ci = 0; ci < _servicePoleList.length; ci++) {
      if (dataList.servicePole == "Needs Repair") {
        setState(() {
          // servicePoleRepair = true;
          electricalPoleID = 1;
          electricalPole = "Needs Repair";
        });
      }

      if (dataList.servicePole == "Needs Replacement") {
        setState(() {
          // servicePoleReplacement = true;
          electricalPoleID = 2;
          electricalPole = "Needs Replacement";
        });
      }

      // print(_servicePoleList);
      // }
    }

    if (dataList.groundRod != "NA") {
      String _groundRod = dataList.groundRod!;

      if (_groundRod == "Needs Replacement") {
        eleGroundRod = true;
      }
    }

    if (dataList.groundClamp != "NA") {
      String _groundClamp = dataList.groundClamp!;

      if (_groundClamp == "Needs Replacement") {
        eleGroundClamp = true;
      }
    }

    if (dataList.groundWire != "NA") {
      String _groundWire = dataList.groundWire!;

      if (_groundWire == "Needs Replacement") {
        eleGroundwire = true;
      }
    }

    if (dataList.waterSupply != "NA") {
      String _waterSupply = dataList.waterSupply!;

      if (_waterSupply == "Needs Repair") {
        plumingwater = true;
      }
    }

    if (dataList.waterCloset != "NA") {
      //   String _waterCloset = dataList.waterCloset!;
      //  List<String> _waterClosetList = _waterCloset.split(",");

      /// for (int ci = 0; ci < _waterClosetList.length; ci++) {
      if (dataList.waterCloset == "Needs Repair") {
        setState(() {
          // plumingwaterclosetRepair = true;
          plumbingwaterID = 1;
          plumbingwater = "Needs Repair";
        });
      }

      if (dataList.waterCloset == "Needs Replacement") {
        setState(() {
          // plumingwaterclosetReplacment = true;
          plumbingwater = "Needs Replacement";
          plumbingwaterID = 2;
        });
      }

      // print(_waterClosetList);
      // }
    }

    print("fgfdgdfgdfgfdgfd ${dataList.interiorFlooding}");

    if (dataList.interiorFlooding != "NA") {
      //  String _waterCloset = dataList.interiorFlooding!;
      // List<String> _waterClosetList = _waterCloset.split(",");

      //  for (int ci = 0; ci < _waterClosetList.length; ci++) {
      if (dataList.interiorFlooding == "Yes") {
        setState(() {
          // plumingwaterclosetRepair = true;
          electricalInteriorID = 1;
          electricalInterior = "Yes";
        });
      }

      if (dataList.interiorFlooding == "No") {
        setState(() {
          // plumingwaterclosetReplacment = true;
          electricalInterior = "No";
          electricalInteriorID = 2;
        });
      }

      //  print(_waterClosetList);
      //  }

    }

    if (dataList.s12ServicePipe != "NA") {
      String _s12ServicePipe = dataList.s12ServicePipe!;

      if (_s12ServicePipe == "Needs Repair") {
        plumingservicePipe1 = true;
      }
    }

    if (dataList.s34ServicePipe != null) {
      if (dataList.s34ServicePipe != "NA") {
        String _s34ServicePipe = dataList.s34ServicePipe!;

        if (_s34ServicePipe == "Needs Repair") {
          plumingservicePipe2 = true;
        }
      }
    }

    if (dataList.s1ServicePipe != "NA") {
      String _s1ServicePipe = dataList.s1ServicePipe!;

      if (_s1ServicePipe == "Needs Repair") {
        plumingservicePipe3 = true;
      }
    }

    //  elaFloadingFeetController.text=dataList.settlement??"";
    evenFeetController.text =
        dataList.eaveFlashingFeet! != "NA" ? dataList.eaveFlashingFeet! : '';
    evenSizeInchController.text =
        dataList.eaveFlashingSize! != "NA" ? dataList.eaveFlashingSize! : '';
    evenInchController.text = dataList.eaveFlashingInches! != "NA"
        ? dataList.eaveFlashingInches!
        : '';
    fasciaFeetController.text =
        dataList.fasciaBoardFeet! != "NA" ? dataList.fasciaBoardFeet! : '';
    fasciaInchController.text =
        dataList.fasciaBoardInches! != "NA" ? dataList.fasciaBoardFeet! : '';
    fasciaSizeFeetController.text = dataList.fasciaBoardSizeInchesOne! != "NA"
        ? dataList.fasciaBoardSizeInchesOne!
        : '';
    fasciaSizeInchController.text = dataList.fasciaBoardSizeInchesTwo! != "NA"
        ? dataList.fasciaBoardSizeInchesTwo!
        : '';

    soffitBoardFeetController.text =
        dataList.soffitHeightFeet! != "NA" ? dataList.soffitHeightFeet! : '';
    soffitBoardInchController.text = dataList.soffitHeightInches! != "NA"
        ? dataList.soffitHeightInches!
        : '';
    soffitHeightFeetController.text =
        dataList.soffitWidthFeet! != "NA" ? dataList.soffitWidthFeet! : '';
    soffitHeightInchController.text =
        dataList.soffitWidthInches! != "NA" ? dataList.soffitWidthInches! : '';
    //  'soffit-type': '$_sofiTypeID',
    shinglesHeightFeetController.text = dataList.shinglesHeightFeet! != "NA"
        ? dataList.shinglesHeightFeet!
        : '';
    shinglesHeightInchController.text = dataList.shinglesHeightInches! != "NA"
        ? dataList.shinglesHeightInches!
        : '';
    shinglesWidthFeetController.text =
        dataList.shinglesWidthFeet! != "NA" ? dataList.shinglesWidthFeet! : '';
    shinglesWidthInchController.text = dataList.shinglesWidthInches! != "NA"
        ? dataList.shinglesWidthInches!
        : '';
    //  'shingle-style': '$_shinglesTypeID',
    plywoodHeightFeetController.text =
        dataList.plywoodHeightFeet! != "NA" ? dataList.plywoodHeightFeet! : '';
    plywoodHeightInchController.text = dataList.plywoodHeightInches! != "NA"
        ? dataList.plywoodHeightInches!
        : '';
    plywoodWidthFeetController.text =
        dataList.plywoodWidthFeet! != "NA" ? dataList.plywoodWidthFeet! : '';
    plywoodWidthInchController.text = dataList.plywoodWidthInches! != "NA"
        ? dataList.plywoodWidthInches!
        : '';
    iceHeightFeetController.text = dataList.iceAndWaterShieldHeightFeet! != "NA"
        ? dataList.iceAndWaterShieldHeightFeet!
        : '';
    iceWidthFeetController.text = dataList.iceAndWaterShieldWidthFeet! != "NA"
        ? dataList.iceAndWaterShieldWidthFeet!
        : '';
    iceWidthInchController.text = dataList.iceAndWaterShieldWidthInches! != "NA"
        ? dataList.iceAndWaterShieldWidthInches!
        : '';
    iceHeightInchController.text =
        dataList.iceAndWaterShieldHeightInches! != "NA"
            ? dataList.iceAndWaterShieldHeightInches!
            : '';
    torchHeightFeetController.text =
        dataList.torchOnHeightFeet! != "NA" ? dataList.torchOnHeightFeet! : '';
    torchHeightInchController.text = dataList.torchOnHeightInches! != "NA"
        ? dataList.torchOnHeightInches!
        : '';
    torchWidthFeetController.text =
        dataList.torchOnWidthFeet! != "NA" ? dataList.torchOnWidthFeet! : '';
    torchWidthInchController.text = dataList.torchOnWidthInches! != "NA"
        ? dataList.torchOnWidthInches!
        : '';
    toughHeightFeetController.text = dataList.toughGuardHeightFeet! != "NA"
        ? dataList.toughGuardHeightFeet!
        : '';
    toughHeightInchController.text = dataList.toughGuardHeightInches! != "NA"
        ? dataList.toughGuardHeightInches!
        : '';
    toughWidthFeetController.text = dataList.toughGuardWidthFeet! != "NA"
        ? dataList.toughGuardWidthFeet!
        : '';
    toughWidthInchController.text = dataList.toughGuardWidthInches! != "NA"
        ? dataList.toughGuardWidthInches!
        : '';
    //  'type': typeList,
    // 'window-style': windowList,
    //  'type-one': type1List,
    //  'window-style-one': window1List,
    //   'type-two': type2List,
    // 'window-style-two': window2List,
    // 'location': locationList,
    //'door-type': doorTypeList,
    //'metirial': _materialId,
    // 'orientation': orientationList,
    doorQuantityController.text =
        dataList.doorQuantity! != "NA" ? dataList.doorQuantity! : '';
    doorSizeHeightFeetController.text = dataList.doorSizeHeightFeet! != "NA"
        ? dataList.doorSizeHeightFeet!
        : '';
    doorSizeHeightInchController.text = dataList.doorSizeHeightInches! != "NA"
        ? dataList.doorSizeHeightInches!
        : '';
    doorSizeWidthFeetController.text =
        dataList.doorSizeWidthFeet! != "NA" ? dataList.doorSizeWidthFeet! : '';
    doorSizeWidthInchController.text = dataList.doorSizeWidthInches! != "NA"
        ? dataList.doorSizeWidthInches!
        : '';
    // 'location-one': location1List,
    // 'door-type-one': doorTypeList,
    // 'meterial-one': _materialId1,
    //  'orientation-one': orientation1List,
    doorQuantity1Controller.text =
        dataList.doorQuantityOne! != "NA" ? dataList.doorQuantityOne! : '';
    doorSize1HeightFeetController.text = dataList.doorSizeHeightFeetOne! != "NA"
        ? dataList.doorSizeHeightFeetOne!
        : '';
    doorSize1HeightInchController.text =
        dataList.doorSizeHeightInchesOne! != "NA"
            ? dataList.doorSizeHeightInchesOne!
            : '';
    doorSize1WidthFeetController.text = dataList.doorSizeWidthInchesOne! != "NA"
        ? dataList.doorSizeWidthInchesOne!
        : '';
    doorSize1WidthInchController.text = dataList.doorSizeWidthInchesOne! != "NA"
        ? dataList.doorSizeWidthInchesOne!
        : '';
    // 'location-two': location2List,
    // 'door-type-two': doorType2List,
    // 'meterial-two': _materialId2,
    // 'orientation-two': orientation2List,
    doorQuantity2Controller.text =
        dataList.doorQuantityTwo! != "NA" ? dataList.doorQuantityTwo! : '';
    doorSize2HeightFeetController.text = dataList.doorSizeHeightFeetTwo! != "NA"
        ? dataList.doorSizeHeightFeetTwo!
        : '';
    doorSize2HeightInchController.text =
        dataList.doorSizeHeightInchesTwo! != "NA"
            ? dataList.doorSizeHeightInchesTwo!
            : '';
    doorSize2WidthFeetController.text = dataList.doorSizeWidthFeetTwo! != "NA"
        ? dataList.doorSizeWidthFeetTwo!
        : '';
    doorSize2WidthInchController.text = dataList.doorSizeWidthInchesTwo! != "NA"
        ? dataList.doorSizeWidthInchesTwo!
        : '';
    // 'service-entrance': serviceEntList,
    // 'service-pole': servicePoleList,
    eleMeterSizeController.text =
        dataList.meterCanSize! != "NA" ? dataList.meterCanSize! : '';
    eleMeterSizeController.text =
        dataList.meterSwitchSize! != "NA" ? dataList.meterSwitchSize! : '';
    //  'interior-flooding': yerornoList,
    elaFloadingFeetController.text = dataList.floodingHeightFeet! != "NA"
        ? dataList.floodingHeightFeet!
        : '';
    elaFloadingInchController.text = dataList.floodingHeightInches! != "NA"
        ? dataList.floodingHeightInches!
        : '';
    // 'ground-rod': groundRodList,
    // 'ground-clamp': groundClampList,
    // 'ground-wire': groundWireList,
    // 'water-supply': groundWatersupplyList,
    // 'water-closet': groundWaterClosestList,
    // '1/2-service-pipe': servicePipeList,
    plumingLengthFeetController.text = dataList.lengthOfDamageFeet! != "NA"
        ? dataList.lengthOfDamageFeet!
        : '';
    plumingLengthInchController.text = dataList.lengthOfDamageInches! != "NA"
        ? dataList.lengthOfDamageInches!
        : '';
    plumingServiceFeetController.text = dataList.lengthOfDamageFeetOne! != "NA"
        ? dataList.lengthOfDamageFeetOne!
        : '';
    plumingServiceInchController.text =
        dataList.lengthOfDamageInchesOne! != "NA"
            ? dataList.lengthOfDamageInchesOne!
            : '';
    plumingService1FeetController.text = dataList.lengthOfDamageFeetTwo! != "NA"
        ? dataList.lengthOfDamageFeetTwo!
        : '';
    plumingService1InchController.text =
        dataList.lengthOfDamageInchesTwo! != "NA"
            ? dataList.lengthOfDamageInchesTwo!
            : '';
  }

// fetchData() async {
//   setState(() {
//     isLoading = true;
//   });
//   var accessToken = '';
//   await SharedPreferences.getInstance().then((token) {
//     accessToken = token.getString("accessToken")!;
//   });
//   print('tok${widget.ids}');
//
//   final response = await get(
//       Uri.parse('${BASE_URL}assessments/assessment_detail/${widget.ids}'),
//       headers: {'Authorization': 'Bearer ${accessToken}'});
//   if (response.statusCode == 200) {
//     setState(() {
//       isLoading = false;
//     });
//     print(response.body);
//     dataList = AssessmentDetailsList.fromJson(
//         json.decode(response.body)['assessmentDetailsList']);
//
//     prefildata();
//
//     print("IMAGESSSSSSSSSSS${dataList.damageSnaps}");
//   } else {
//     setState(() {
//       isLoading = false;
//     });
//
//     throw Exception('Unexpected error occured!');
//   }
// }
}

class DropListModel {
  String name;
  String id;
  DropListModel(this.name, this.id);
}
