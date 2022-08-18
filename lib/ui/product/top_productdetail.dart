import 'package:flutter/material.dart';
import 'package:mallet_user/models/product.dart';


class ProductDetailTop extends StatefulWidget {
  final Product? product;
  ProductDetailTop({this.product});
  @override
  _ProductDetailTopState createState() => _ProductDetailTopState();
}

class _ProductDetailTopState extends State<ProductDetailTop> {
  @override
  Widget build(BuildContext context) {
    if(widget.product!.productImage=='' || widget.product!.productImage==null){
      return Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height/2,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/back.jpg'),
                  fit: BoxFit.cover)),
        ),

        Container(
          height: MediaQuery.of(context).size.height/2,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff2a2e42).withOpacity(0.5),
          ),
        ),
//        Positioned.fill(
//          top: 50.0,
//          child: Align(
//            alignment: Alignment.centerRight,
//            child: Center(
//              child: Text(
//                name,
//                style: TextStyle(fontSize: 20.0, color: Colors.white),
//              ),
//            ),
//          ),
//        ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.white,
          ),
        ),
      ]);
    }
    return Stack(children: <Widget>[
      Container(
          height: MediaQuery.of(context).size.height/2,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.product!.productImage.toString()),
                  fit: BoxFit.cover)),
        ),

//      Container(
//        height: 300.0,
//        width: double.infinity,
//        decoration: BoxDecoration(
//          color: Color(0xff2a2e42).withOpacity(0.5),
//        ),
//      ),
//      Positioned.fill(
//        top: 50.0,
//        child: Align(
//          alignment: Alignment.centerRight,
//          child: Center(
//            child: Text(
//              name,
//              style: TextStyle(fontSize: 20.0, color: Colors.white),
//            ),
//          ),
//        ),
//      ),
      Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: Icon(Icons.arrow_back,color: Color(0xff29b6f6),),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
      ),
    ]);
  }
}
