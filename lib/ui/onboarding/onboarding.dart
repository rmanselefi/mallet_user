import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mallet_user/models/mall.dart';
import 'package:mallet_user/models/user_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/services/mall_service.dart';
import 'package:mallet_user/ui/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  final MainModel? model;
  final UserLocation? currentLocation;
  final List<Mall>? malls;
  OnBoardingPage(this.model, this.currentLocation, this.malls);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MallService().fetchNearByMalls(widget.currentLocation);
  }

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first_time', false);
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) =>
              Home(widget.model, widget.currentLocation, widget.malls)),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(
      'assets/$assetName',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.topRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(

      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      // descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
      fullScreen: true

    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,

      pages: [
        PageViewModel(
          title: "",
          body:
              "",
          image: _buildImage('introd1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body:
              "",
          image: _buildImage('introd2.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body:
              "",
          image: _buildImage('introd3.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body:
              "",
          image: _buildImage('introd4.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body: "",
          image: _buildImage('intro5.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body: "",
          image: _buildImage('introd6.jpg'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
      next: const Icon(Icons.arrow_forward,color: Colors.black,),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
      curve: Curves.fastLinearToSlowEaseIn,

      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
