import 'package:flutter/material.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/ui/shop/full_picture.dart';

class ShopDetailTop extends StatefulWidget {
  final Shop? shop;
  ShopDetailTop({this.shop});
  @override
  _ShopDetailTopState createState() => _ShopDetailTopState();
}

class _ShopDetailTopState extends State<ShopDetailTop> {
  @override
  Widget build(BuildContext context) {
    var name = widget.shop!.shopName;
    if (widget.shop!.back_image == '' || widget.shop!.back_image == null) {
      return Stack(children: <Widget>[
        Container(
          height: 200.0,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/back.jpg'), fit: BoxFit.cover)),
        ),
        Container(
          height: 200.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff2a2e42).withOpacity(0.7),
          ),
        ),
        Positioned.fill(
          top: 50.0,
          child: Align(
            alignment: Alignment.centerRight,
            child: Center(
              child: Text(
                name.toString(),
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xff29b6f6),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
        ),
      ]);
    }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FullPicture(url: widget.shop!.back_image)),
        );
      },
      child: Stack(children: <Widget>[
        Container(
          height: 200.0,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.shop!.back_image.toString()),
                  fit: BoxFit.cover)),
        ),

        // Container(
        //   height: 200.0,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     color: Color(0xff2a2e42).withOpacity(0.7),
        //   ),
        // ),
        Positioned.fill(
          top: 15.0,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2a2e42).withOpacity(0.4),
              ),
              child: Text(
                name.toString(),
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xff29b6f6)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.white,
          ),
        ),
      ]),
    );
  }
}
