import 'package:flutter/material.dart';

class FullPicture extends StatefulWidget {
  final url;
  FullPicture({this.url});
  @override
  _FullPictureState createState() => _FullPictureState();
}

class _FullPictureState extends State<FullPicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(

          children: [
            SizedBox(
              height: 100.0,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height/2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.url),
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
