import 'package:flutter/material.dart';
import 'package:mallet_user/models/mall.dart';

class NearbyReusableCard extends StatefulWidget {
  final Mall malls;


  NearbyReusableCard(this.malls);
  @override
  _NearbyReusableCardState createState() => _NearbyReusableCardState();
}

class _NearbyReusableCardState extends State<NearbyReusableCard> {
  @override
  Widget build(BuildContext context) {
    var malls = widget.malls;
    return Column(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0)),
          elevation: 10.0,
          child: Container(
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: malls.mallImage != ""
                        ? NetworkImage(malls.mallImage.toString())
                        : AssetImage('assets/placeholder.png') as ImageProvider)),
          ),
        ),
        Container(
          height: 50.0,
          width: 200.0,
          decoration: BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide(color: Colors.black26, width: 0.5),
                vertical: BorderSide(color: Colors.black26, width: 0.5)),
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    malls.mallName.toString(),
                    style: TextStyle(
                      color: Color(0xff5a5d6e),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: 'SegoeUI',
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
