import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mallet_user/models/platform.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/services/platform_services.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class PlatformCarousel extends StatefulWidget {
  @override
  _PlatformCarouselState createState() => _PlatformCarouselState();
}

class _PlatformCarouselState extends State<PlatformCarousel> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PlatformService().getPlatformImages();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      return model.platforms.length != 0
          ? CarouselSlider(
              options: CarouselOptions(
                autoPlayInterval: Duration(seconds: 6),
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 2),
                height: 150.0,
                viewportFraction:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 1.0
                        : 2.0,
              ),
              items: model.platforms.map<Widget>((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: 400.0,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Color(0xff29b6f6),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 10.0,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              i.url.toString(),
                            ),
                          )),
                      // child: Container(
                      //   padding: EdgeInsets.all(10),
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(15),
                      //       gradient: LinearGradient(
                      //           begin: Alignment.topRight,
                      //           colors: [
                      //             Colors.black.withOpacity(.9),
                      //             Colors.black.withOpacity(.1),
                      //           ])),
                      // ),
                    );
                  },
                );
              }).toList(),
            )
          : Center(
              child: CircularProgressIndicator(),
            );
    });
  }
}
