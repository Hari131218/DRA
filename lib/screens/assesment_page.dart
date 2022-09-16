import 'package:flutter/material.dart';

import 'basic_screen.dart';
import 'camera_access.dart';
import 'comments_screen.dart';
import 'damages_screen.dart';

class AssesmentPage extends StatefulWidget {
  const AssesmentPage({Key? key, required this.str_id, required this.str_webId})
      : super(key: key);

  final String str_id;
  final String str_webId;

  @override
  State<AssesmentPage> createState() => _AssesmentPageState();
}

class _AssesmentPageState extends State<AssesmentPage>
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
              'Web ID',
              style: TextStyle(fontSize: 14, fontFamily: 'San Francisco'),
            ),
            Text('#${widget.str_webId}',
                style: TextStyle(fontSize: 12, fontFamily: 'San Francisco'))
          ],
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Basic(
                            ids: '${widget.str_id}',
                          )));
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
          Damages(
            tabController: this.myTabController,
            ids: '${widget.str_id}',
            tabonTab: enableTabs,
          ),
          Comments(
              tabController: this.myTabController,
              str_id: '${widget.str_id}',
              tabonTab: enableTabs),
          AddPhoto(
              tabController: this.myTabController,
              strIds: '${widget.str_id}',
              tabonTab: enableTabs),
        ],
      ),
    );
  }
}
