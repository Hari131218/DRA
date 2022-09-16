import 'dart:convert';

import 'package:dra_project/models/requestinfo_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/app_constants.dart';
import '../models/login_page_api/api_login.dart';
import 'basic_screen.dart';

class requestinfo extends StatefulWidget {
  const requestinfo({
    Key? key,
    required this.ids,
  }) : super(key: key);

  final String ids;

  @override
  State<requestinfo> createState() => _requestinfoState();
}

class _requestinfoState extends State<requestinfo> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController lastnamecontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  final TextEditingController islandcontroller = TextEditingController();
  final TextEditingController homenumcontroller = TextEditingController();
  final TextEditingController settlementcontroller = TextEditingController();
  final TextEditingController statuscontroller = TextEditingController();
  final TextEditingController webidcontroller = TextEditingController();
  final TextEditingController flagcontroller = TextEditingController();
  final TextEditingController assement_request_idcontroller =
      TextEditingController();

  late SharedPreferences localStorage;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final ApiClient _apiClient = ApiClient();

  //*start
  // late Future<List<requestinfoapi>> futureData;
  List<AssessorNameList> dataList = [];
  List<String> items = List.generate(10, (index) => 'Hello $index');

  fetchData(accessToken) async {
    setState(() {
      isLoading = true;
    });

    print('tok${accessToken}');
    final response = await get(
        Uri.parse('${BASE_URL}assessments/edit?id=${widget.ids}'),
        headers: {'Authorization': 'Bearer ${accessToken}'});
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      print(response.body);
      dataList = (json.decode(response.body)['assessment_details'] as List)
          .map((e) => AssessorNameList.fromJson(e))
          .toList();

      print(dataList.toString());
      emailcontroller.text = dataList[0].email ?? "";
      namecontroller.text = dataList[0].name ?? "";
      lastnamecontroller.text = dataList[0].lastName ?? "";
      phonecontroller.text = dataList[0].callnumber.toString();
      addresscontroller.text = dataList[0].address ?? "";
      islandcontroller.text = dataList[0].island ?? "";
      homenumcontroller.text = dataList[0].homeNumber.toString();
      settlementcontroller.text = dataList[0].settlement ?? "";
      statuscontroller.text = dataList[0].status.toString();
    } else {
      setState(() {
        isLoading = false;
      });

      throw Exception('Unexpected error occured!');
    }
  }

  @override
  void initState() {
    super.initState();
    var accessToken = "";

    SharedPreferences.getInstance().then((token) {
      accessToken = token.getString("accessToken")!;
      fetchData(accessToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        localStorage = value;
      });
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff16698c),
        centerTitle: true,
        title: Text(
          'Edit Information',
          style: TextStyle(fontFamily: 'San Francisco'),
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final assimentList = dataList[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16, bottom: 23.97, top: 10),
                          child: Text(
                            'Home Owner Information',
                            style: TextStyle(
                                color: Color(0xff16698C),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'San Francisco'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 16, bottom: 10),
                          child: TextFormField(
                            controller: namecontroller,
                            decoration: InputDecoration(
                              labelText: 'Enter First Name',
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffF2F2F2)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your Name';
                              }
                              // Return null if the entered email is valid
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 16, bottom: 10),
                          child: TextFormField(
                            controller: lastnamecontroller,
                            decoration: InputDecoration(
                              labelText: 'Enter Last Name',
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffF2F2F2)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your Name';
                              }
                              // Return null if the entered email is valid
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 16, bottom: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: phonecontroller,
                            decoration: InputDecoration(
                              labelText: 'Enter Mobile Number',
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffF2F2F2)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please Enter Mobile Number';
                              }
                              // else if (value == null || value.length != 10) {
                              //   return 'Please Enter Mobile Number';
                              // }
                              // Return null if the entered email is valid
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 16, bottom: 10),
                          child: TextFormField(
                            controller: emailcontroller,
                            decoration: InputDecoration(
                              labelText: 'Enter Email id',
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffF2F2F2)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please Enter Email id';
                              }
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return "Please enter a valid email address";
                              }

                              // Return null if the entered email is valid
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 16, bottom: 10),
                          child: TextFormField(
                            controller: addresscontroller,
                            decoration: InputDecoration(
                              labelText: 'Enter Street Address',
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffF2F2F2)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please Enter Street Address';
                              } else if (value == null || value.length < 5) {
                                return 'Please Enter More than 5 characters';
                              }
                              // Return null if the entered email is valid
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 16, bottom: 10),
                          child: TextFormField(
                            controller: islandcontroller,
                            decoration: InputDecoration(
                              labelText: 'Enter Island',
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffF2F2F2)),
                              ),
                              //  hintText: '${assimentList.island}'
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please Enter Island';
                              }
                              // Return null if the entered email is valid
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 16, bottom: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: homenumcontroller,
                            decoration: InputDecoration(
                              labelText: 'Enter Home Number',
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffF2F2F2)),
                              ),
                              //    hintText: '${assimentList.alterPhoneNumber}'
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please Enter Home Number';
                              }
                              // Return null if the entered email is valid
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 16, bottom: 10),
                          child: TextFormField(
                            controller: settlementcontroller,
                            decoration: InputDecoration(
                              labelText: 'Enter Settlement',
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffF2F2F2)),
                              ),
                              //     hintText: '${assimentList.settlement}'
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please Enter Settlement';
                              }
                              // Return null if the entered email is valid
                            },
                          ),
                        ),
                        SizedBox(
                          height: 120,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Basic(
                                                  ids: '${widget.ids}',
                                                )));
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
                                      fixedSize: Size(85, 46)),
                                ),
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _trySubmitForm,
                                  child: Text(
                                    'UPDATE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'San Francisco',
                                        fontSize: 12),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xff12AFC0),
                                      fixedSize: Size(85, 46)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                    //  NewWidget(assimentList: assimentList);
                  }),
            ),
    );
  }

  save(String accessToken) async {
    localStorage.setString('access_token', accessToken);
  }

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      _updateDetail();
    }
  }

  void _updateDetail({required}) async {
    var email = emailcontroller.text;
    var name = namecontroller.text;
    var lastName = lastnamecontroller.text;
    var phonenumber = phonecontroller.text;
    var address = addresscontroller.text;
    var home = homenumcontroller.text;
    var status = statuscontroller.text;
    var settlement = settlementcontroller.text;
    var webid = widget.ids;
    var assement_request_id = widget.ids;
    var flag = flagcontroller.text;
    var island = islandcontroller.text;
    var accessToken = '';
    await SharedPreferences.getInstance().then((token) {
      accessToken = token.getString("accessToken")!;
      email = token.getString("email")!;
      print("email${token.getString("email")}");
      print('id${assement_request_id}');
// fetchData(accessToken);
    });

    setState(() {
      isLoading = true;
    });

    dynamic res = await _apiClient.requestinfoedit(
      email: '${email}',
      accessor_id: '${assement_request_id}',
      flag: '${flag}',
      assement_request_id: '${assement_request_id}',
      settlement: '${settlement}',
      web_id: '${webid}',
      island: '${island}',
      home_number: '${home}',
      first_name: '${name}',
      last_name: '${lastName}',
      address: '${address}',
      status: '${status}',
      accesstoken: '${accessToken}',
      phone_number: '${phonenumber}',
      id: '',
    );

    if (res?.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Details Sent for Approval'),
        backgroundColor: Colors.green.shade300,
      ));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Basic(ids: '${widget.ids}')));
    } else {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
//content: Text('data'),
          content: Text(res.data['error']),
          backgroundColor: Colors.red.shade300,
        ),
      );
    }
  }
}
