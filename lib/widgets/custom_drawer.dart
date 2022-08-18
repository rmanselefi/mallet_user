import 'package:flutter/material.dart';
import 'package:mallet_user/widgets/contact_us.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';


class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _launchURL(var url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color:Color(0xff2a2e42),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/mall_sid.png'))),
              child: Container(),
            ),
            Divider(
              color: Color(0xff29b6f6).withOpacity(0.9),
            ),
            Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.inbox,color: Color(0xff29b6f6)),
                  title: Text('Contact Us',style: TextStyle(color: Colors.white),),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactUs()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.star,color: Color(0xff29b6f6)),
                  title: Text('Rate Us',style: TextStyle(color: Colors.white),),
                  onTap: () {
                    _launchURL("https://play.google.com/store/apps/details?id=com.qemer.mallet_user");
                  },
                ),ListTile(
                  leading: Icon(Icons.share,color: Color(0xff29b6f6)),
                  title: Text('Share App',style: TextStyle(color: Colors.white),),
                  onTap: () {
                    Share.share(
                        'https://play.google.com/store/apps/details?id=com.qemer.mallet_user');
                  },
                ),
                Divider(
                  color: Color(0xff29b6f6).withOpacity(0.9),
                ),
                // ListTile(
                //   leading: Icon(Icons.people,color: Color(0xff29b6f6)),
                //   title: Text('Join Us',style: TextStyle(color: Colors.white),),
                //   onTap: () {
                //     _launchURL("https://t.me/MallETEthiopia");
                //   },
                // ),
                // ListTile(
                //   leading: Icon(Icons.send,color:  Color(0xff29b6f6).withOpacity(0.9)),
                //   title: Text('Quick Support',style: TextStyle(
                //       color: Colors.white
                //   )),
                //   onTap: () {
                //     _launchURL("https://t.me/MallETclientSupport");
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.update,color:  Color(0xff29b6f6).withOpacity(0.9)),
                  title: Text('Update',style: TextStyle(
                      color: Colors.white
                  )),
                  onTap: () {
                    _launchURL("https://play.google.com/store/apps/details?id=com.qemer.mallet_user");
                  },
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
