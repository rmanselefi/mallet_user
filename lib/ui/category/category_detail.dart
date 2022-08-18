// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/ui/shop/shop_detail.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:responsive_grid/responsive_grid.dart';

class CategoryDetail extends StatefulWidget {
  final String cat;

  CategoryDetail(this.cat);

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 150) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: Color(0xff2a2e42),
      appBar: AppBar(
        backgroundColor: Color(0xff2a2e42),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff29b6f6),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
        title: Text(
          widget.cat,
          style: TextStyle(color: Colors.white, fontFamily: 'SegoeUI'),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          decoration: const BoxDecoration(
            color: Color(0xff2a2e42),
          ),
          child: Stack(
            children: <Widget>[
              ScopedModelDescendant(builder:
                  (BuildContext context, Widget child, MainModel model) {
                return Container(
//                  height: MediaQuery.of(context).size.height,
                    child: GridView.count(
//                      minSpacing: 5,
//                      desiredItemWidth: MediaQuery
//                          .of(context).size.width > 370 ? 150 : 120,
//                      scroll: true,
                  crossAxisCount: 2,
                  childAspectRatio:
                      MediaQuery.of(context).size.width > 370 ? 0.9 : 0.8,
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  children: model.shops.map<Widget>((f) {
                    return InkWell(
                      onTap: () {
                        model.selectShop(f.Id.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShopDetail(f, model)),
                        );
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 5.0),
                            height: 250.0,
                            width: 200.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 6.0,
                                  ),
                                ],
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    // image: AssetImage('')
                                    image: f.back_image.toString().isNotEmpty
                                        ? NetworkImage(f.back_image.toString())
                                        : AssetImage('assets/shop_bsck.jpg')
                                            as ImageProvider)),
                          ),
                          Positioned.fill(
                            top: 145.0,
                            child: Opacity(
                              opacity: 0.9,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 5.0),
                                height: 40.0,
                                width: 185.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
//                              border: Border.all(
//                                color: Color(0xff29b6f6),
//                              ),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                        child: Text(
                                      f.shopName.toString(),
                                      style: const TextStyle(
                                        color: Color(0xff5a5d6e),
                                        fontSize: 15,
                                        fontFamily: 'SegoeUI',
                                      ),
                                    )),
                                    Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              120.0, 4.0, 0.0, 0.0),
                                          child: Text(
                                            f.shopRoomNumber.toString(),
                                            style: const TextStyle(
                                              color: Color(0xfff56667),
                                              fontSize: 15,
                                              fontFamily: 'SegoeUI',
                                            ),
                                          )),
                                    ), //
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ));
              })
            ],
          )),
    );
  }
}
