import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mallet_user/scoped_models/main.dart';

class Carousel extends StatefulWidget {
  final mall;
  final MainModel? model;
  final String? name;
  final double? height;
  Carousel({this.mall, this.name, this.height, this.model});
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    var name = widget.name;
    return CarouselSlider(
      options: CarouselOptions(
        autoPlayInterval: Duration(seconds: 6),
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayAnimationDuration: Duration(seconds: 2),
        height: widget.height,
        viewportFraction: 1.0,
      ),
      items: widget.model!.mallImages.map<Widget>((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: 400.0,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  color: Color(0xff29b6f6),
                  borderRadius: BorderRadius.circular(10.0),
//                  border: Border.all(
//                    color: Color(0xff29b6f6),
//                    width: 1,
//                  ),
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
                      i.image.toString(),
                    ),
                  )),
              child: Container(),
            );
          },
        );
      }).toList(),
    );
  }
}
