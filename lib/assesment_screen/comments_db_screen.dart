import 'package:flutter/material.dart';

import '../db_helper/assesmentService.dart';
import '../models/AssesmentDataBaseModel.dart';

class CommentsDBScreen extends StatefulWidget {
  const CommentsDBScreen(
      {Key? key,
      required this.tabController,
      required this.str_id,
      this.tabonTab})
      : super(key: key);
  final TabController tabController;
  final String str_id;
  final Function? tabonTab;

  @override
  State<CommentsDBScreen> createState() => _CommentsDBScreenState();
}

class _CommentsDBScreenState extends State<CommentsDBScreen> {
  final TextEditingController commentController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  List<AssesmentDataBaseModel> testList = <AssesmentDataBaseModel>[];
  var _userService = AssesmentService();

  bool _updateDB = false;

  void initState() {
    super.initState();

    _query(widget.str_id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    commentController.dispose();
    super.dispose();
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

      if (testList[0].additionalComment != "") {
        commentController.text = testList[0].additionalComment ?? "";
      }

      /*if (testList[0].damageSnaps != "") {

        List<dynamic> deTypeList = jsonDecode(testList[0].damageSnaps!);

        print("Encodeeeeeeeeee ${deTypeList}");

        for (int ii = 0; ii < deTypeList.length; ii++) {

          setState(() {
            imageStrList.add(deTypeList[ii]);
          });


        }
      }*/

      print("Test        ${testList[0].type}");

      print("dfdafadfdaf ${testList[0].requestKey}");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Additional Comments',
                      style: TextStyle(
                          color: Color(0xff16698C),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: 'San Francisco'),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 16, bottom: 308),
                    child: TextFormField(
                      controller: commentController,
                      minLines: 8,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Comment here',
                        hintStyle: TextStyle(
                            fontSize: 12,
                            color: Color(0xff808B9E),
                            fontFamily: 'San Francisco'),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffF2F2F2), width: 344)),
                      ),
                      // validator: (value) {
                      //   if (value == null || value.trim().isEmpty) {
                      //     return 'This field is required';
                      //   }
                      //   return null;
                      // },
                    ),
                  ),
                ],
              ),
            )),
      bottomNavigationBar: Container(
        child: Row(
          children: [
            Expanded(
              child: FlatButton(
                height: 40,
                color: Color(0xffD45128),
                textColor: Colors.white,
                onPressed: () {
                  widget.tabonTab!(list: [false, true, true]);

                  widget.tabController.animateTo(0);
                },
                child: Text('PREVIOUS',
                    style: TextStyle(
                        color: Colors.white,
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
                onPressed: () async {
                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) {
                    //  Get.off(HomePage());

                    return;
                  }

                  valiationPage();

                  /* var accessToken;
                  print(commentController.text);
                  print(widget.str_id);
                  await SharedPreferences.getInstance().then((token) {
                    accessToken = token.getString("accessToken")!;
                    // fetchData(accessToken);
                  });
                  print("dsadasdads $accessToken");
                  _updateDetailcomment(id: 'widget.str_id', accessToken: 'accessToken', comment: 'commentController.text');*/
                },
                child: Text('NEXT',
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
          testList[0].iceAndWaterShieldHeightInches ?? '';
      user.iceAndWaterShieldWidthFeet = testList[0].iceAndWaterShieldWidthFeet!;
      user.iceAndWaterShieldWidthInches =
          testList[0].iceAndWaterShieldWidthInches ?? '';
      user.torchOnHeightFeet = testList[0].torchOnHeightFeet ?? '';
      user.torchOnHeightInches = testList[0].torchOnHeightInches ?? '';
      user.torchOnWidthFeet = testList[0].torchOnWidthFeet ?? '';
      user.torchOnWidthInches = testList[0].torchOnWidthInches ?? "";
      user.toughGuardHeightFeet = testList[0].toughGuardHeightFeet ?? '';
      user.toughGuardHeightInches = testList[0].toughGuardHeightInches ?? '';
      user.toughGuardWidthFeet = testList[0].toughGuardWidthFeet ?? '';
      user.toughGuardWidthInches = testList[0].toughGuardWidthInches ?? '';
      user.type = testList[0].type ?? '';
      user.quantity = testList[0].quantity ?? '';
      user.sizeHeightFeet = testList[0].sizeHeightFeet ?? '';
      user.sizeHeightInches = testList[0].sizeHeightInches ?? '';
      user.sizeWidthFeet = testList[0].sizeWidthFeet ?? '';
      user.sizeWidthInches = testList[0].sizeWidthInches ?? '';

      user.quantityOne = testList[0].quantityOne ?? '';
      user.sizeHeightFeetOne = testList[0].sizeHeightFeetOne ?? '';
      user.sizeHeightInchesOne = testList[0].sizeHeightInchesOne ?? '';
      user.sizeWidthFeetOne = testList[0].sizeWidthFeetOne ?? '';
      user.sizeWidthInchesOne = testList[0].sizeWidthInchesOne ?? '';
      user.typeOne = testList[0].typeOne ?? '';
      user.windowStyleOne = testList[0].windowStyleOne ?? '';

      user.type = testList[0].type ?? '';
      user.windowStyle = testList[0].windowStyle ?? '';
      user.quantity = testList[0].quantity ?? '';
      user.sizeHeightFeet = testList[0].sizeHeightFeet ?? '';
      user.sizeHeightInches = testList[0].sizeHeightInches ?? '';
      user.sizeWidthFeet = testList[0].sizeWidthFeet ?? '';
      user.sizeWidthInches = testList[0].sizeWidthInches ?? '';

      user.typeTwo = testList[0].typeTwo ?? '';
      user.windowStyleTwo = testList[0].windowStyleTwo ?? '';
      user.quantityTwo = testList[0].quantityTwo ?? '';
      user.sizeHeightFeetTwo = testList[0].sizeHeightFeetTwo ?? '';
      user.sizeHeightInchesTwo = testList[0].sizeHeightInchesTwo ?? '';
      user.sizeWidthFeetTwo = testList[0].sizeWidthFeetTwo ?? '';
      user.sizeWidthInchesTwo = testList[0].sizeWidthInchesTwo ?? '';

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
      user.additionalComment = commentController.text;
      user.damageSnaps = testList[0].damageSnaps!;
      user.name = testList[0].name;
      user.emailAddress = testList[0].emailAddress;

      user.eaveFlashingSize = testList[0].eaveFlashingSize;
      user.fasciaBoardSizeInchesOne = testList[0].fasciaBoardSizeInchesOne;
      user.colonialStyle = testList[0].colonialStyle;
      user.fasciaBoardSizeInchesTwo = testList[0].fasciaBoardSizeInchesTwo;
      user.colonialStyleOne = testList[0].colonialStyleOne;
      user.colonialStyleTwo = testList[0].colonialStyleTwo;

      user.requestKey = widget.str_id;

      var result = await _userService.UpdateUser(user);
      print('Updateeeeeeeeeee 1111 ${result}');
      FocusScope.of(context).requestFocus(FocusNode());
      widget.tabonTab!(list: [true, true, false]);
      widget.tabController.animateTo(2);
    }

    ///  print('CHEKKKKKKKKKK VALUESSSSSSS 1111 ${data}');
  }
}
