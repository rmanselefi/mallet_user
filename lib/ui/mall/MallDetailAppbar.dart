import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mallet_user/ui/search/search_delgate.dart';
import 'package:mallet_user/ui/search/search_mall.dart';

class MallDetailAppBar extends StatefulWidget {
  final String? searchPlace;
  MallDetailAppBar({this.searchPlace});
  @override
  _MallDetailAppBarState createState() => _MallDetailAppBarState();
}

class _MallDetailAppBarState extends State<MallDetailAppBar> {
  @override
  Widget build(BuildContext context) {
    var togo=widget.searchPlace;
    return Row(
      children: <Widget>[
        Material(
          elevation: 10.0,
          borderRadius: BorderRadius.circular(20.0),
          shadowColor: Colors.black54,
          color: Color(0xffd8eceb),
          child: Container(
            width: MediaQuery.of(context).size.width-90,
            height: 35.0,
//            margin: EdgeInsets.only(right: 20.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff29b6f6),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              onTap: () {
                showSearch(context: context, delegate: togo=='whole'?DataSearch(): MallSearch());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Text(
                    togo=='whole'?'Search...':'Search...',
                    style: TextStyle(
                        color: Color(0xff5a5d6e), fontFamily: 'SegoeUI'),
                  ),
//                  SizedBox(
//                    width:togo=='whole'? MediaQuery.of(context).size.width-286:MediaQuery.of(context).size.width-310,
//                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Color(0xff5a5d6e),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
