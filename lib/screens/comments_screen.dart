import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/app_constants.dart';
import '../models/login_page_api/api_login.dart';
import '../models/sumitted_form_model.dart';

class Comments extends StatefulWidget {
  const Comments(
      {Key? key,
      required this.tabController,
      required this.str_id,
      this.tabonTab})
      : super(key: key);
  final TabController tabController;
  final String str_id;
  final Function? tabonTab;

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final TextEditingController commentController = TextEditingController();
  bool isLoading = false;
  final ApiClient _apiClient = ApiClient();
  final _formKey = GlobalKey<FormState>();
  late AssessmentDetailsList dataList;

  void initState() {
    super.initState();
    var accessToken = "";
    fetchData();
    // SharedPreferences.getInstance().then((token) {
    //   accessToken = token.getString("accessToken")!;
    //
    //   // futureData = fetchData(accessToken);
    // });
  }

  fetchData() async {
    setState(() {
      isLoading = true;
    });
    var accessToken = '';
    await SharedPreferences.getInstance().then((token) {
      accessToken = token.getString("accessToken")!;
    });
    print('tok${widget.str_id}');

    final response = await get(
        Uri.parse('${BASE_URL}assessments/assessment_detail/${widget.str_id}'),
        headers: {'Authorization': 'Bearer ${accessToken}'});
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      print(response.body);
      dataList = AssessmentDetailsList.fromJson(
          json.decode(response.body)['assessmentDetailsList']);

      if (dataList.additionalComment != null) {
        commentController.text = dataList.additionalComment!;
      }

      print("IMAGESSSSSSSSSSS${dataList.damageSnaps}");
    } else {
      setState(() {
        isLoading = false;
      });

      throw Exception('Unexpected error occured!');
    }
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

                  var accessToken;
                  print(commentController.text);
                  print(widget.str_id);
                  await SharedPreferences.getInstance().then((token) {
                    accessToken = token.getString("accessToken")!;
                    // fetchData(accessToken);
                  });
                  print("dsadasdads $accessToken");
                  _updateDetailcomment(
                      id: 'widget.str_id',
                      accessToken: 'accessToken',
                      comment: 'commentController.text');
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

  void _updateDetailcomment(
      {required String id,
      required String comment,
      required String accessToken}) async {
    setState(() {
      isLoading = true;
    });
    dynamic res = await _apiClient.Comment_screen(
        commentController.text, accessToken, widget.str_id);

    if (res?.statusCode == 200) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: const Text('Assessment Form Store Successfully'),
      //   backgroundColor: Colors.green.shade300,
      // ));

      setState(() {
        isLoading = false;
      });

      widget.tabonTab!(list: [true, true, false]);
      widget.tabController.animateTo(2);
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
}
