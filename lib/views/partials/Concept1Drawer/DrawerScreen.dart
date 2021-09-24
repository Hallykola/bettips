// import 'package:bettingtips/utils/constants.dart';
// import 'package:bettingtips/utils/styles.dart';
// import 'package:bettingtips/views/partials/Concept1Drawer/tipsdetails.dart';
// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:bettingtips/views/partials/Concept1Drawer/Concept1Drawer.dart';
// import 'package:provider/provider.dart';

// class MenuScreen extends StatelessWidget {
//   final String imageUrl =
//       "https://celebritypets.net/wp-content/uploads/2016/12/Adriana-Lima.jpg";

//   final List<MenuItem> options = [
//     MenuItem(Icons.search, 'Search'),
//     MenuItem(Icons.shopping_basket, 'Performance'),
//     MenuItem(Icons.favorite, 'Leaderboard'),
//     MenuItem(Icons.code, 'Lessons'),
//     MenuItem(Icons.format_list_bulleted, 'Podcast'),
//     MenuItem(Icons.format_list_bulleted, 'Store'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanUpdate: (details) {
//         //on swiping left
//         if (details.delta.dx < -6) {
//           Provider.of<MenuController>(context, listen: false).toggle();
//         }
//       },
//       child: Container(
//         padding: EdgeInsets.only(
//             top: 90,
//             left: 12,
//             bottom: 8,
//             right: MediaQuery.of(context).size.width / 2.9),
//         decoration: BoxDecoration(
//             gradient: LinearGradient(colors: [
//           Styles.appPrimaryColorDark,
//           Styles.appPrimaryColor
//         ])), //Color(0xFFF07DA4), Color(0xFFF5AE87)
//         child: Column(
//           children: <Widget>[
//             InkWell(
//               onTap: () {},
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(right: 15),
//                     child: Container(
//                       height: 50.0,
//                       width: 50.0,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                           image:
//                               DecorationImage(image: NetworkImage(imageUrl))),
//                     ),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         Constants.appName,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                           fontFamily: "Sofia",
//                           fontSize: 20,
//                         ),
//                       ),
//                       Text(
//                         Constants.apptag,
//                         style: TextStyle(
//                           color: Colors.white54,
//                           fontFamily: "Sofia",
//                           fontSize: 15,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Spacer(),
//             Column(
//               children: <Widget>[
//                 GestureDetector(
//                     onTap: () {
//                       Provider.of<MenuController>(context, listen: false)
//                           .toggle();
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => Concept1Drawer(),
//                         ),
//                       );
//                     },
//                     child: _listText("Categories", EvaIcons.bell)),
//                 GestureDetector(
//                     onTap: () {
//                       Provider.of<MenuController>(context, listen: false)
//                           .toggle();
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => TipsDetails(),
//                         ),
//                       );
//                     },
//                     child: _listText("Details", EvaIcons.bell)),
//                 // _mylistText("Subscribe", EvaIcons.phone, context, "/about"),
//                 // _mylistText("Login", EvaIcons.phone, context, "/login"),
//                 _mylistText("About", EvaIcons.phone, context, "/about"),
//                 // _listText("Settings", EvaIcons.settings),
//                 // _listText("Favorite", EvaIcons.heart),
//               ],
//             ),
//             Spacer(),
//             InkWell(
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   //   do{
//                   //   Navigator.of(context).pop();
//                   // }
//                   // while (Navigator.canPop(context));
//                 },
//                 child: _listText("Exit", Icons.exit_to_app)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _listText(String _text, IconData _iconData) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 30.0),
//       child: Row(
//         children: <Widget>[
//           Container(
//             height: 45.0,
//             width: 45.0,
//             decoration: BoxDecoration(),
//             child: Center(
//               child: Icon(
//                 _iconData,
//                 color: Colors.white70,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 20.0,
//           ),
//           Text(
//             _text,
//             style: TextStyle(
//                 fontFamily: "Sofia",
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white.withOpacity(0.9),
//                 fontSize: 16.0),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _mylistText(
//       String _text, IconData _iconData, BuildContext context, String route) {
//     return GestureDetector(
//       onTap: () {
//         Provider.of<MenuController>(context, listen: false).toggle();
//         Navigator.pushNamed(context, route);
//       },
//       child: Padding(
//         padding: EdgeInsets.only(bottom: 30.0),
//         child: Row(
//           children: <Widget>[
//             Container(
//               height: 45.0,
//               width: 45.0,
//               decoration: BoxDecoration(),
//               child: Center(
//                 child: Icon(
//                   _iconData,
//                   color: Colors.white70,
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 20.0,
//             ),
//             Text(
//               _text,
//               style: TextStyle(
//                   fontFamily: "Sofia",
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white.withOpacity(0.9),
//                   fontSize: 16.0),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MenuItem {
//   String title;
//   IconData icon;

//   MenuItem(this.icon, this.title);
// }
