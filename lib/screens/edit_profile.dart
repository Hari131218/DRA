import 'dart:convert';
import 'dart:io';

import 'package:dra_project/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/login_page_api/api_login.dart';
import '../common/app_constants.dart';
import '../models/profilescreen_api.dart';

class profscreen extends StatefulWidget {
  const profscreen({Key? key}) : super(key: key);

  @override
  State<profscreen> createState() => _profscreenState1();
}

class _profscreenState1 extends State<profscreen> {
  final TextEditingController firstnamecontroller = TextEditingController();
  final TextEditingController lastnamecontroller = TextEditingController();
  final TextEditingController emailaddresscontroller = TextEditingController();
  final TextEditingController mobilenumbercontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  final TextEditingController selectstatecontroller = TextEditingController();
  final TextEditingController selectcitycontroller = TextEditingController();
  final TextEditingController zipcodecontroller = TextEditingController();
  bool isLoading = false;
  XFile? imageFile = null;
  String _imagePath = "";

  final ApiClient _apiClient = ApiClient();
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;

  UserProfile? userObjcet;

  fetchData() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences.getInstance().then((token) async {
      var accessToken = token.getString("accessToken")!;
      final response = await post(Uri.parse('${BASE_URL}user'),
          headers: {'Authorization': 'Bearer ${accessToken}'});
      if (response.statusCode == 200) {
        userObjcet =
            UserProfile.fromJson((json.decode(response.body)['userProfile']));

        firstnamecontroller.text = userObjcet!.firstName.toString();
        lastnamecontroller.text = userObjcet!.lastName.toString();
        emailaddresscontroller.text = userObjcet!.email.toString();
        mobilenumbercontroller.text = userObjcet!.mobileNo.toString();
        addresscontroller.text = userObjcet!.address.toString();
        selectcitycontroller.text = userObjcet!.city.toString();
        selectstatecontroller.text = userObjcet!.state.toString();
        zipcodecontroller.text = userObjcet!.pincode.toString();

        print(userObjcet!.toJson());
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Unexpected error occured!');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    getStringValuesSF();
    super.initState();
  }

  getStringValuesSF() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('YAY! Free cute dog pics!');
      //  Provider.of<AssessorProvider>(context, listen: false).getAssessment();

      fetchData();
    } else {
      print('No internet :( Reason:');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please check your internet connection and try again"),
        backgroundColor: Colors.red.shade300,
      ));

      // print(InternetConnectionChecker().lastTryResults);
    }

    // print("SHAREDDDDDDDDDD $stringValue");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: TextStyle(
                color: Colors.white, fontFamily: 'San Francisco', fontSize: 18),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profile()));
              },
              icon: Icon(Icons.arrow_back_rounded)),
          backgroundColor: Color(0xff16698C),
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            _settingModalBottomSheet(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: imageFile != null
                                ? CircleAvatar(
                                    radius: 48,
                                    child: Container(
                                        width: 120.0,
                                        height: 120.0,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: FileImage(
                                                File(imageFile!.path),
                                              ),
                                            ))),
                                  )
                                : userObjcet?.userPhoto?.isNotEmpty ?? false
                                    ? CircleAvatar(
                                        radius: 48, // Image radius
                                        backgroundImage: NetworkImage(
                                            userObjcet!.userPhoto!),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: 48,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            Icons.person,
                                            size: 48,
                                          ),
                                          color: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 25, top: 10),
                        child: TextFormField(
                          controller: firstnamecontroller,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808B9E),
                                fontFamily: 'San Francisco'),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffF2F2F2), width: 344)),
                          ),
                          validator: (value) {
                            // Check if this field is empty
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 25),
                        child: TextFormField(
                          controller: lastnamecontroller,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808B9E),
                                fontFamily: 'San Francisco'),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffF2F2F2), width: 344)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 25),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailaddresscontroller,
                          decoration: InputDecoration(
                            hintText: 'E-mail Address',
                            hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808B9E),
                                fontFamily: 'San Francisco'),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffF2F2F2), width: 344)),
                          ),
                          validator: (value) {
                            // Check if this field is empty
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }

                            // using regular expression
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return "Please enter a valid email address";
                            }

                            // the email is valid
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 25),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: mobilenumbercontroller,
                          decoration: InputDecoration(
                            hintText: 'Mobile Number',
                            hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808B9E),
                                fontFamily: 'San Francisco'),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffF2F2F2), width: 344)),
                          ),
                          validator: (value) {
                            // Check if this field is empty
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 25),
                        child: TextFormField(
                          controller: addresscontroller,
                          decoration: InputDecoration(
                            hintText: 'Address',
                            hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808B9E),
                                fontFamily: 'San Francisco'),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffF2F2F2), width: 344)),
                          ),
                          validator: (value) {
                            // Check if this field is empty
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 25),
                        child: TextFormField(
                          controller: selectstatecontroller,
                          decoration: InputDecoration(
                            hintText: 'Select State',
                            hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808B9E),
                                fontFamily: 'San Francisco'),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffF2F2F2), width: 344)),
                          ),
                          validator: (value) {
                            // Check if this field is empty
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 25),
                        child: TextFormField(
                          controller: selectcitycontroller,
                          decoration: InputDecoration(
                            hintText: 'Select City',
                            hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808B9E),
                                fontFamily: 'San Francisco'),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffF2F2F2), width: 344)),
                          ),
                          validator: (value) {
                            // Check if this field is empty
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 25),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: zipcodecontroller,
                          decoration: InputDecoration(
                            hintText: 'Zipcode',
                            hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xff808B9E),
                                fontFamily: 'San Francisco'),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffF2F2F2), width: 344)),
                          ),
                          validator: (value) {
                            // Check if this field is empty
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                              height: 50,
                              width: 344,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff12AFC0),
                                ),
                                onPressed: () {
                                  print("Abcd");
                                  // _updateDetail();
                                  _saveForm();
                                },
                                child: Text(
                                  'UPDATE',
                                  style: TextStyle(
                                      fontFamily: 'San Francisco',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ));
  }

  void _updateDetail() async {
    var email = emailaddresscontroller.text;
    var first_name = firstnamecontroller.text;
    var last_name = lastnamecontroller.text;
    var mobile_no = mobilenumbercontroller.text;
    var address = addresscontroller.text;
    var state = selectstatecontroller.text;
    var city = selectcitycontroller.text;
    var pincode = zipcodecontroller.text;

    final mobileRemove = mobile_no.replaceAll(RegExp('-'), ''); // abc

    print("svdvdavdavdasv $mobileRemove");

    var accessToken = '';
    await SharedPreferences.getInstance().then((token) {
      accessToken = token.getString("accessToken")!;
      email = token.getString("email")!;
      print("email${token.getString("email")}");
      // fetchData(accessToken);
    });
    dynamic res = await _apiClient.editProfile(
      email,
      accessToken,
      first_name,
      last_name,
      mobileRemove,
      address,
      state,
      city,
      pincode,
    );
    setState(() {
      isLoading = false;
    });
    if (res?.statusCode == 200) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: const Text(' Profile update successfully'),
      //   backgroundColor: Colors.green.shade300,
      // ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => profile()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.data['error']),
          backgroundColor: Colors.red.shade300,
        ),
      );
    }
  }

  void _upload(String _token) async {
    setState(() {
      isLoading = true;
    });

    var kyc = Uri.parse("${BASE_URL}user_update");
    var request = new http.MultipartRequest("POST", kyc);
    // request.headers.addAll(headers);
    request.headers['Authorization'] = "Bearer $_token";
    request.fields['email'] = emailaddresscontroller.text;
    request.fields['first_name'] = firstnamecontroller.text;
    request.fields['last_name'] = lastnamecontroller.text;
    request.fields['mobile_no'] = mobilenumbercontroller.text;
    request.fields['address'] = addresscontroller.text;
    request.fields['state'] = selectstatecontroller.text;
    request.fields['city'] = selectcitycontroller.text;
    request.fields['pincode'] = zipcodecontroller.text;

    if (_imagePath != "") {
      request.files
          .add(await http.MultipartFile.fromPath('user_photo', "$_imagePath"));
    }

    await request.send().then((value) {
      if (value.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => profile()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Profile update successfully"),
          backgroundColor: Colors.green.shade300,
        ));

        print("asadasdsadasdadsasdasd");
      }
    });
  }

// Image picker
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    title: new Text('Gallery'),
                    onTap: () => {
                          imageSelector(context, "gallery"),
                          Navigator.pop(context),
                        }),
                new ListTile(
                  title: new Text('Camera'),
                  onTap: () => {
                    imageSelector(context, "camera"),
                    Navigator.pop(context)
                  },
                ),
              ],
            ),
          );
        });
  }

  Future imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":

        /// GALLERY IMAGE PICKER
        imageFile = await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 90);
        break;

      case "camera": // CAMERA CAPTURE CODE
        imageFile = await ImagePicker()
            .pickImage(source: ImageSource.camera, imageQuality: 90);
        break;
    }

    if (imageFile != null) {
      print("You selected  image : " + imageFile!.path);

      setState(() {
        _imagePath = imageFile!.path;
      });

      debugPrint("SELECTED IMAGE PICK   $imageFile");
    } else {
      print("You have not taken image");
    }
  }

  void _saveForm() {
    setState(() async {
      _isValid = _formKey.currentState!.validate();
      if (_isValid == true) {
        await SharedPreferences.getInstance().then((token) {
          _upload(token.getString("accessToken")!);
          // fetchData(accessToken);
        });
      }
    });
  }
}
