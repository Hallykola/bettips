// import 'package:flutter/material.dart';
// import 'package:intro_views_flutter/Models/page_view_model.dart';
// import 'package:intro_views_flutter/intro_views_flutter.dart';
// import 'package:bettips/utils/constants.dart';
// import 'package:bettips/utils/styles.dart';
// import 'package:bettips/views/partials/fake_bottom_buttons.dart';
// import 'package:bettips/views/partials/Concept1Drawer/Concept1Drawer.dart';

// //import 'home.dart';

// class IntroScreenPage extends StatefulWidget {
//   @override
//   _IntroScreenPageState createState() => _IntroScreenPageState();
// }

// class _IntroScreenPageState extends State<IntroScreenPage> {
//   static final List<String> images = [
//     'assets/images/freetips.png',
//     'assets/images/win.gif',
//     'assets/images/justgo.png',
//   ];

//   static final List<String> titles = [
//     Constants.appName,
//     'Flutter Boilerplate/Starter Kit',
//     'Enjoy Coding',
//   ];

//   static final List<String> descriptions = [
//     'Win Tips',
//     'A Proud product of AceLords System Engineers',
//     'Just start coding!',
//   ];

//   final pages = [
//     PageViewModel(
//         pageColor: Styles.appPrimaryColor,
//         // iconImageAssetPath: 'assets/air-hostess.png',
//         bubble: Image.asset(images[1]),
//         title: Text(titles[0]),
//         body: Text(descriptions[0]),
//         titleTextStyle: TextStyle(fontFamily: 'Radicals', color: Colors.white),
//         bodyTextStyle: Styles.p.copyWith(
//           color: Colors.white,
//           fontFamily: 'Comfortaa',
//           fontStyle: FontStyle.italic,
//         ),
//         mainImage: Image.asset(
//           images[0],
//           height: 285.0,
//           width: 285.0,
//           alignment: Alignment.center,
//         )),
//     PageViewModel(
//       pageColor: const Color(0xFF8BC34A),
//       iconImageAssetPath: images[2],
//       title: Text(titles[1]),
//       body: Text(descriptions[1]),
//       mainImage: Image.asset(
//         images[1],
//         height: 285.0,
//         width: 285.0,
//         alignment: Alignment.center,
//       ),
//       titleTextStyle: TextStyle(fontFamily: 'Radicals', color: Colors.white),
//       bodyTextStyle: Styles.p.copyWith(
//         color: Colors.white,
//         fontFamily: 'Comfortaa',
//         fontStyle: FontStyle.italic,
//       ),
//     ),
//     PageViewModel(
//       pageColor: const Color.fromRGBO(22, 160, 133, 1),
//       iconImageAssetPath: images[1],
//       title: Text(titles[2]),
//       body: Text(descriptions[2]),
//       mainImage: Image.asset(
//         images[2],
//         height: 285.0,
//         width: 285.0,
//         alignment: Alignment.center,
//       ),
//       titleTextStyle: TextStyle(fontFamily: 'Radicals', color: Colors.white),
//       bodyTextStyle: Styles.p.copyWith(
//         color: Colors.white,
//         fontFamily: 'Comfortaa',
//         fontStyle: FontStyle.italic,
//       ),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (context) => Container(
//         color: Colors.red,
//         child: Scaffold(
// //          persistentFooterButtons: FakeBottomButtons(height: 40.0), // showcase admob banner
//           body: IntroViewsFlutter(
//             pages,
//             showNextButton: true,
//             showBackButton: true,
//             onTapDoneButton: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Concept1Drawer(),
//                 ),
//               );
//             },
//             pageButtonTextStyles: TextStyle(
//               color: Colors.white,
//               fontSize: 18.0,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:bettips/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

class IntroScreenPage extends StatefulWidget {
  @override
  _IntroScreenPageState createState() => _IntroScreenPageState();
}

class _IntroScreenPageState extends State<IntroScreenPage> {
  static final List<String> images = [
    'assets/images/freetips.png',
    'assets/images/win.gif',
    'assets/images/justgo.png',
  ];

  // REQUIRED: USED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 0.

  // OPTIONAL: can be set directly.
  int dotCount = images.length;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text(
      //     'Concept 4',
      //     style: TextStyle(fontFamily: "Sofia", color: Colors.black),
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0.0,
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            children: [
              steps(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: DotStepper(
                    dotCount: dotCount,
                    dotRadius: 12,
                    activeStep: activeStep,
                    shape: Shape.stadium,
                    spacing: 10,
                    indicator: Indicator.shift,
                    onDotTapped: (tappedDotIndex) {
                      setState(() {
                        activeStep = tappedDotIndex;
                      });
                    },
                    fixedDotDecoration: FixedDotDecoration(
                      color: Colors.black12,
                    ),
                    indicatorDecoration: IndicatorDecoration(
                      color: Colors.orangeAccent,
                    ),
                    lineConnectorDecoration: LineConnectorDecoration(
                      color: Colors.red,
                      strokeWidth: 0,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [previousButton(), nextButton()],
                    )),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget steps() {
    return Container(
        color: Styles.appPrimaryColorDark,
        // padding: EdgeInsets.all(5.0),
        child: Center(
          child: Image.asset(
            images[activeStep],
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
          ),
        ));
  }

  /// Returns the next button widget.
  Widget nextButton() {
    if (activeStep == dotCount - 1) {
      return ElevatedButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, '/');
        },
        child: Text("Proceed"),
      );
    }
    return ElevatedButton(
      child: Text('Next'),
      onPressed: () {
        /// ACTIVE STEP MUST BE CHECKED FOR (dotCount - 1) AND NOT FOR dotCount To PREVENT Overflow ERROR.
        if (activeStep < dotCount - 1) {
          setState(() {
            activeStep++;
          });
        }
      },
    );
  }

  /// Returns the previous button widget.
  Widget previousButton() {
    if (activeStep == 0) {
      return SizedBox(
        width: 2.0,
      );
    }
    return GestureDetector(
        onTap: () {
          // activeStep MUST BE GREATER THAN 0 TO PREVENT OVERFLOW.
          if (activeStep > 0) {
            setState(() {
              activeStep--;
            });
          }
        },
        child: Text(
          'Prev',
          style: TextStyle(fontSize: 20, fontFamily: 'Sophia'),
        ));
  }
}
