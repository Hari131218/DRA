import 'package:flutter/material.dart';



extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

class EmptyData extends StatelessWidget {
//  const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("No results found ",style: TextStyle(color: Colors.black,fontSize: 22),),

        SizedBox(height: 5,),

        Text("There is no result that matches for this search",style: TextStyle(color:Color(0xff808B9E),fontSize: 12),),

      ],),);
  }
}
