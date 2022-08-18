import 'package:flutter/material.dart';
import 'package:mallet_user/models/shop.dart';

class GeneralCard extends StatefulWidget {
  final Shop shop;
  GeneralCard(this.shop);

  @override
  _GeneralCardState createState() => _GeneralCardState();
}

class _GeneralCardState extends State<GeneralCard> {
  @override
  Widget build(BuildContext context) {
    var sf = widget.shop;
    return Column(
      children: <Widget>[
        Container(
          height: 160.0,
          width: 185.0,
          decoration: BoxDecoration(
              color: Color(0xffF5F5F5),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
              image: DecorationImage(
                fit: BoxFit.fill,
                image: sf.back_image != ''
                    ? NetworkImage(
                        sf.back_image.toString(),
                      )
                    : AssetImage('assets/shop_bsck.jpg') as ImageProvider,
              )),
        ),
        Container(
          height: 60.0,
          width: 185.0,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black26,
                width: 0.4
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
          child: Column(
            children: <Widget>[
              Center(
                  child: Text(
                sf.shopName.toString(),
                style: TextStyle(
                  color: Color(0xff5a5d6e),
                  fontSize: 15,
                  fontFamily: 'SegoeUI',
                ),
              )),
              Expanded(
                child: Container(
                    margin: EdgeInsets.fromLTRB(120.0, 4.0, 0.0, 0.0),
                    child: Text(
                      sf.shopRoomNumber.toString(),
                      style: TextStyle(
                        color: Color(0xfff56667),
                        fontSize: 15,
                        fontFamily: 'SegoeUI',
                      ),
                    )),
              ), //
            ],
          ),
        )
      ],
    );
  }
}
