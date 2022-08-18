// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailInfo extends StatefulWidget {
  final MainModel? model;
  ProductDetailInfo({this.model});
  @override
  _ProductDetailInfoState createState() => _ProductDetailInfoState();
}

class _ProductDetailInfoState extends State<ProductDetailInfo> {
  @override
  Widget build(BuildContext context) {
    var model = widget.model;
    return FutureBuilder<Shop?>(
        future: model!.getShopDetail(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snap.data == null) {
              return Center(
                child: Text('No data to show'),
              );
            }

            return Expanded(
              child: Container(
//          padding: EdgeInsets.only(top: 5.0),
                decoration: BoxDecoration(color: Colors.white),
                child: ListView(
                  children: <Widget>[
                    Divider(
                      color: Colors.grey,
                    ),
                    Container(
//                padding: EdgeInsets.only(top: 10.0),
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            snap.data!.shopPhone != ''
                                ? ListTile(
                                    title: Text(
                                      'Phone Number',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: SelectableText(
                                      snap.data!.shopPhone.toString(),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                : Container(),
//                    Row(
//                      children: <Widget>[
//                        SizedBox(width: 15.0,),
//                        Text('Phone Number',style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,),),
//                        SizedBox(width: 25.0,),
//                        Expanded(
//                            child: Text(snap.data.shopPhone,style: TextStyle(color: Colors.grey),))
//                      ],
//                    )
                            Divider(
                              height: 15.0,
                            ),
                            snap.data?.shopWebsite.toString() != ''
                                ? ListTile(
                                    title: Text(
                                      'Website',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: RichText(
                                      text: new TextSpan(
                                        children: [
                                          new TextSpan(
                                            text: snap.data!.shopWebsite,
                                            style: new TextStyle(
                                                color: Colors.blueAccent),
                                            recognizer:
                                                new TapGestureRecognizer()
                                                  ..onTap = () {
                                                    launch(
                                                        '${snap.data!.shopWebsite}');
                                                  },
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                            padding: EdgeInsets.only(left: 15.0),
//                            child: Text('Website',style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold),)
//                        ),
//                        SizedBox(width: 25.0,),
//                        Expanded(child: RichText(
//                          text: new TextSpan(
//                            children: [
//                              new TextSpan(
//                                text: snap.data.shopWebsite,
//                                style: new TextStyle(color: Colors.blueAccent),
//                                recognizer: new TapGestureRecognizer()
//                                  ..onTap = () { launch('${snap.data.shopWebsite}');
//                                  },
//                              ),
//                            ],
//                          ),
//                        ),
//                        )
//                      ],
//                    ):Container(),

                            Divider(
                              height: 15.0,
                            ),
//                    snap.data.shopTelegram!=''?
//                    ListTile(
//                      title: Text('Telegram Link',style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,),),
//                      subtitle:  RichText(
//                        text: new TextSpan(
//                          children: [
//                            new TextSpan(
//                              text: snap.data.shopWebsite,
//                              style: new TextStyle(color: Colors.blueAccent),
//                              recognizer: new TapGestureRecognizer()
//                                ..onTap = () { launch('${snap.data.}');
//                                },
//                            ),
//                          ],
//                        ),
//                      ),
//                    ):Container(),
//
//                    Row(
//                      children: <Widget>[
//                        SizedBox(width: 15.0,),
//                        Text('Telegram Link',style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold),),
//                        SizedBox(width: 25.0,),
//                        Expanded(
//                            child: RichText(
//                              text: new TextSpan(
//                                children: [
//                                  new TextSpan(
//                                    text: snap.data.shopTelegram,
//                                    style: new TextStyle(color: Colors.blueAccent,),
//                                    recognizer: new TapGestureRecognizer()
//                                      ..onTap = () { launch(snap.data.shopWebsite);
//                                      },
//                                  ),
//                                ],
//                              ),
//                            ),
//                        )
//                      ],
//                    ):Container(),

                            snap.data!.shopDescription != ''
                                ? ListTile(
                                    title: Text(
                                      'Description',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      snap.data!.shopDescription.toString(),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                : Container(),
//                    Row(
//                      children: <Widget>[
//                        SizedBox(width: 15.0,),
//                        Text('Description',style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold),),
//                        SizedBox(width: 25.0,),
//                        Expanded(child: Text(snap.data.shopDescription,style: TextStyle(color: Colors.grey),))
//                      ],
//                    ):Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
