import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShopDetailCard extends StatefulWidget {
  final String? name;
  final String? price;
  final String? url;

  ShopDetailCard({this.name,this.price,this.url});
  @override
  _ShopDetailCardState createState() => _ShopDetailCardState();
}

class _ShopDetailCardState extends State<ShopDetailCard> {
  @override
  Widget build(BuildContext context) {
    var name=widget.name;
    var url=widget.url;
    var price=widget.price;
    var size=MediaQuery.of(context).size;
    final double itemHeight=(size.height-kToolbarHeight-150)/2;
    final double itemWidth=size.width/2;
    return AspectRatio(
      aspectRatio: itemWidth/itemHeight,
      child:CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: Color(0xff2a2e42),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black45,
          //     offset: Offset(0.0, 2.0), //(x,y)
          //     blurRadius: 10.0,
          //   ),
          // ],
          borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                ),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(.9),
                      Colors.black.withOpacity(.1),
                    ]
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                price!=''?Text("$price", style: TextStyle(color: Colors.white),):Text(''),
                Text(name.toString(), style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
        ),
        placeholder: (context, url) => Container(
          height: 60,
          width: 60,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
//
    );
//    child: Container(
//        margin: EdgeInsets.only(right: 10),
//        decoration: BoxDecoration(
//          color: Color(0xff2a2e42),
//          boxShadow: [
//            BoxShadow(
//              color: Colors.black45,
//              offset: Offset(0.0, 2.0), //(x,y)
//              blurRadius: 10.0,
//            ),
//          ],
//          borderRadius: BorderRadius.circular(15),
//          image: DecorationImage(
//              image: url != '' ? CachedNetworkImageProvider(url) : AssetImage(
//                  'assets/placeh.png'),
//              fit: BoxFit.cover
//          ),
//
//        ),
//        child: Container(
//          padding: EdgeInsets.all(10),
//          decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(15),
//              gradient: LinearGradient(
//                  begin: Alignment.bottomRight,
//                  colors: [
//                    Colors.black.withOpacity(.9),
//                    Colors.black.withOpacity(.1),
//                  ]
//              )
//          ),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Text(name, style: TextStyle(color: Colors.white),),
//              price!=''?Text("$price ETB", style: TextStyle(color: Colors.white),):Text('')
//            ],
//          ),
//        ),
//      ),
  }

}
