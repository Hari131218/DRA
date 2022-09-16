import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff16698C),
        // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(

                    prefixIcon: const Icon(Icons.search,color: Color(0xffB6BED4),),
                    suffixIcon: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: IconButton(
                        icon: Image.asset('assets/images/close.png',height: 20,width: 20,),
                        onPressed: () {
                        },
                      ),
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
    );
  }
}
