import 'package:bettips/utils/constants.dart';
import 'package:bettips/utils/styles.dart';
import 'package:bettips/views/partials/drawer.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var taps = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x00008B), //Color(0xFFFFFFFF),
        elevation: 0.0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Text(
            "About",
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 23.0,
                color: Colors.black,
                fontWeight: FontWeight.w700),
          ),
        ),

        leading: Builder(
          builder: (BuildContext context) {
            return new GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Icon(
                    EvaIcons.menu2Outline,
                    color: Colors.black,
                  ),
            );
          },
          // actions: <Widget>[
          //   Padding(
          //     padding: const EdgeInsets.only(right: 10.0),
          //     child:
          //         InkWell(onTap: () {}, child: Icon(EvaIcons.personOutline)),
          //   ),
          // ],
        ),
      ),
      drawer: HomeDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black12,
        padding: EdgeInsets.all(Constants.commonPadding),
        child: Card(
          color: Styles.commonDarkCardBackground,
          elevation: 5,
          child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(Constants.appName,
                        style: TextStyle(color: Colors.black, fontSize: 35)),
                  ),
                  GestureDetector(
                    onDoubleTap: () {
                      taps++;
                      if (taps == 3) {
                        Navigator.pushNamed(context, '/login');
                        taps = 0;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Constants.version,
                          style: TextStyle(color: Colors.redAccent, fontSize: 25)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(Constants.appTagLine,
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(Constants.appAbout,
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
