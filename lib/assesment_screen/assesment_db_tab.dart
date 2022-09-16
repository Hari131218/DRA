import 'package:dra_project/assesment_screen/addphoto_db_screen.dart';
import 'package:dra_project/assesment_screen/damages_db_screen.dart';
import 'package:dra_project/screens/screens.dart';
import 'package:flutter/material.dart';

import 'comments_db_screen.dart';

class AssesmentDBTab extends StatefulWidget {
  const AssesmentDBTab(
      {Key? key,
      required this.str_id,
      required this.str_name,
      required this.str_email,
      required this.str_webId})
      : super(key: key);

  final String str_id;
  final String str_name;
  final String str_email;
  final String str_webId;

  @override
  State<AssesmentDBTab> createState() => _AssesmentDBTabState();
}

class _AssesmentDBTabState extends State<AssesmentDBTab>
    with TickerProviderStateMixin {
  late TabController myTabController;
  int _currentTab = 0;

  List<bool> _isDisabled = [false, true, true];
  final List<Widget> _tabs = <Tab>[
    Tab(text: "Damages"),
    Tab(text: "Comments"),
    Tab(text: "Add Photo"),
  ];

  // List<Widget> _tabs=[
  //
  //   Comments(),
  //   AddPhoto(),
  // ];

  @override
  void initState() {
    super.initState();
    myTabController =
        TabController(initialIndex: 0, length: _tabs.length, vsync: this);
    myTabController.addListener(onTaps);
  }

  @override
  void dispose() {
    myTabController.dispose();
    super.dispose();
  }

  onTaps() {
    if (_isDisabled[myTabController.index]) {
      int index = myTabController.previousIndex;
      setState(() {
        myTabController.index = index;
      });
    }
  }

  enableTabs({required List<bool> list}) {
    print("vcxvxvsvdsvdsv");

    _isDisabled = list;
    // if (list[myTabController.index]) {
    //   int index = myTabController.previousIndex;
    //   setState(() {
    //     myTabController.index = index;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomSheet: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Visibility(
      //       visible: _currentTab!=0 ,
      //       child: Padding(
      //         padding: const EdgeInsets.only(right: 20),
      //         child: ElevatedButton(
      //           onPressed: (){
      //             if(_currentTab!=0) {
      //               _currentTab--;
      //               myTabController.index = _currentTab ;
      //               setState(() {
      //               });
      //             }
      //
      //           },
      //           child: Text('PREVIOUS',
      //               style: TextStyle(
      //                   fontFamily: 'San Francisco',
      //                   fontWeight: FontWeight.w600)),
      //           style: ElevatedButton.styleFrom(
      //               primary: Color(0xff12AFC0), fixedSize: Size(100, 46)),
      //         ),
      //       ),
      //     ),
      //     ElevatedButton(
      //       onPressed: (){
      //         print("---$_currentTab---${_tabs.length-1}");
      //         if(_currentTab!=_tabs.length-1) {
      //           _currentTab++;
      //           myTabController.index = _currentTab ;
      //
      //           setState(() {
      //
      //           });
      //         }
      //
      //       },
      //       child: Text((_currentTab!=_tabs.length-1)?'NEXT':'SUBMIT',
      //           style: TextStyle(
      //               fontFamily: 'San Francisco',
      //               fontWeight: FontWeight.w600)),
      //       style: ElevatedButton.styleFrom(
      //           primary: Color(0xff12AFC0), fixedSize: Size(100, 46)),
      //     ),
      //   ],
      // ),
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Web Id',
              style: TextStyle(fontSize: 14, fontFamily: 'San Francisco'),
            ),
            Text('#${widget.str_webId}',
                style: TextStyle(fontSize: 12, fontFamily: 'San Francisco'))
          ],
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
            icon: Icon(Icons.arrow_back_outlined)),
        backgroundColor: Color(0xff16698c),
        centerTitle: true,
        bottom: TabBar(
          controller: myTabController,
          // controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          // controller: controller,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 4,
              color: Color(0xff00b3bf),
            ),
          ),
          tabs: [
            Tab(text: "Damages"),
            Tab(text: "Comments"),
            Tab(text: "Add Photo"),
          ],
        ),
      ),

      body: TabBarView(
        controller: myTabController,
        physics: NeverScrollableScrollPhysics(),
        //  controller: controller,
        children: [
          DamagesDbScreen(
            tabController: this.myTabController,
            ids: '${widget.str_id}',
            tabonTab: enableTabs,
            str_name: '${widget.str_name}',
            str_email: '${widget.str_email}',
          ),
          CommentsDBScreen(
              tabController: this.myTabController,
              str_id: '${widget.str_id}',
              tabonTab: enableTabs),
          AddPhotoDBScreen(
              tabController: this.myTabController,
              strIds: '${widget.str_id}',
              tabonTab: enableTabs),
        ],
      ),
    );
  }
}
