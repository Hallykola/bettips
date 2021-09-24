// import 'package:bettips/api/api_response.dart';
// import 'package:bettips/blocs/tips_bloc.dart';
// import 'package:bettips/blocs/user_bloc.dart';
// import 'package:bettips/models/mycategorie.dart';
// import 'package:bettips/utils/constants.dart';
// import 'package:bettips/views/partials/Concept1Drawer/catlist.dart';
// import 'package:bettips/views/partials/api_error.dart';
// import 'package:bettips/views/partials/loading.dart';
// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// import 'DrawerScreen.dart';

// class Concept1Drawer extends StatefulWidget {
//   Concept1Drawer({Key? key}) : super(key: key);

//   @override
//   _Concept1DrawerState createState() => _Concept1DrawerState();
// }

// class _Concept1DrawerState extends State<Concept1Drawer>
//     with TickerProviderStateMixin {
//   MenuController menuController;

//   @override
//   void initState() {
//     super.initState();

//     menuController = new MenuController(
//       vsync: this,
//     )..addListener(() => setState(() {}));
//   }

//   @override
//   void dispose() {
//     menuController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => menuController,
//       child: ScreenHomePage(
//         menuScreen: MenuScreen(),
//         contentScreen: Layout(
//             contentBuilder: (cc) => Container(
//                   color: Colors.grey[200],
//                   child: Container(
//                     color: Colors.grey[200],
//                   ),
//                 )),
//       ),
//     );
//   }
// }

// class Layout {
//   final WidgetBuilder contentBuilder;

//   Layout({
//     this.contentBuilder,
//   });
// }

// class ScreenHomePage extends StatefulWidget {
//   final Widget menuScreen;
//   final Layout contentScreen;

//   ScreenHomePage({
//     this.menuScreen,
//     this.contentScreen,
//   });

//   @override
//   _ScreenHomePageState createState() => _ScreenHomePageState();
// }

// class _ScreenHomePageState extends State<ScreenHomePage> {
//   Curve scaleDownCurve = new Interval(0.0, 0.3, curve: Curves.easeOut);
//   Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
//   Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
//   Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

//   TipsBloc _tipsBloc;

//   @override
//   void initState() {
//     _tipsBloc = new TipsBloc();
//     super.initState();
//   }

//   void dispose() {
//     _tipsBloc.dispose();
//     super.dispose();
//   }

//   createContentDisplay() {
//     UserBloc user = Provider.of<UserBloc>(context, listen: false);
//     bool admin = user.isAdmin;
//     return zoomAndSlideContent(new Container(
//       child: new Scaffold(
//           backgroundColor: Colors.white,

//           // backgroundColor: Colors.white,

//           // Calling variable appbar
//           appBar: AppBar(
//             backgroundColor: Color(0xFFFFFFFF),
//             elevation: 0.0,
//             centerTitle: true,
//             title: Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//               child: Text(
//                 "Category",
//                 style: TextStyle(
//                     fontFamily: "Sofia",
//                     fontSize: 23.0,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w700),
//               ),
//             ),
//             leading: new IconButton(
//                 icon: Icon(
//                   EvaIcons.menu2Outline,
//                   color: Colors.black,
//                 ),
//                 onPressed: () {
//                   Provider.of<MenuController>(context, listen: false).toggle();
//                 }),
//             actions: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(right: 10.0),
//                 child:
//                     InkWell(onTap: () {}, child: Icon(EvaIcons.personOutline)),
//               ),
//             ],
//           ),
//           floatingActionButton: admin
//               ? FloatingActionButton(
//                   onPressed: () => AddDialog(context),
//                   tooltip: 'Add Category',
//                   child: Icon(Icons.add),
//                 )
//               : Container(),
//           body: Container(
//             color: Colors.black,
//             padding: EdgeInsets.all(Constants.commonPadding),
//             child: RefreshIndicator(
//                 onRefresh: () => _tipsBloc.fetchCats(),
//                 child: StreamBuilder<ApiResponse<List<Categorie>>>(
//                     stream: _tipsBloc.catsstream,
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         switch (snapshot.data.status) {
//                           case Status.LOADING:
//                             return Loading(
//                               loadingMessage: snapshot.data.message,
//                             );
//                             break;
//                           case Status.COMPLETED:
//                             return CatsList(catList: snapshot.data.data);
//                             // return Loading(
//                             //   loadingMessage: 'Done',
//                             // );
//                             break;

//                           case Status.ERROR:
//                             return ApiError(
//                               errorMessage: snapshot.data.message,
//                               onRetryPressed: () => _tipsBloc.fetchCats(),
//                             );
//                             break;
//                         }
//                       }
//                       return Container();
//                     })),
//           )),
//     ));
//   }

//   zoomAndSlideContent(Widget content) {
//     var slidePercent, scalePercent;

//     switch (Provider.of<MenuController>(context, listen: false).state) {
//       case MenuState.closed:
//         slidePercent = 0.0;
//         scalePercent = 0.0;
//         break;
//       case MenuState.open:
//         slidePercent = 1.0;
//         scalePercent = 1.0;
//         break;
//       case MenuState.opening:
//         slidePercent = slideOutCurve.transform(
//             Provider.of<MenuController>(context, listen: false).percentOpen);
//         scalePercent = scaleDownCurve.transform(
//             Provider.of<MenuController>(context, listen: false).percentOpen);
//         break;
//       case MenuState.closing:
//         slidePercent = slideInCurve.transform(
//             Provider.of<MenuController>(context, listen: false).percentOpen);
//         scalePercent = scaleUpCurve.transform(
//             Provider.of<MenuController>(context, listen: false).percentOpen);
//         break;
//     }

//     final slideAmount = 275.0 * slidePercent;
//     final contentScale = 1.0 - (0.2 * scalePercent);
//     final cornerRadius =
//         16.0 * Provider.of<MenuController>(context, listen: false).percentOpen;

//     return new Transform(
//       transform: new Matrix4.translationValues(slideAmount, 0.0, 0.0)
//         ..scale(contentScale, contentScale),
//       alignment: Alignment.centerLeft,
//       child: new Container(
//         decoration: new BoxDecoration(
//           boxShadow: [
//             new BoxShadow(
//               color: Colors.black12,
//               offset: const Offset(0.0, 5.0),
//               blurRadius: 15.0,
//               spreadRadius: 10.0,
//             ),
//           ],
//         ),
//         child: new ClipRRect(
//             borderRadius: new BorderRadius.circular(cornerRadius),
//             child: content),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           child: Scaffold(
//             body: widget.menuScreen,
//           ),
//         ),
//         createContentDisplay()
//       ],
//     );
//   }
// }

// class MenuController extends ChangeNotifier {
//   final TickerProvider vsync;
//   final AnimationController _animationController;
//   MenuState state = MenuState.closed;

//   MenuController({
//     this.vsync,
//   }) : _animationController = new AnimationController(vsync: vsync) {
//     _animationController
//       ..duration = const Duration(milliseconds: 250)
//       ..addListener(() {
//         notifyListeners();
//       })
//       ..addStatusListener((AnimationStatus status) {
//         switch (status) {
//           case AnimationStatus.forward:
//             state = MenuState.opening;
//             break;
//           case AnimationStatus.reverse:
//             state = MenuState.closing;
//             break;
//           case AnimationStatus.completed:
//             state = MenuState.open;
//             break;
//           case AnimationStatus.dismissed:
//             state = MenuState.closed;
//             break;
//         }
//         notifyListeners();
//       });
//   }

//   @override
//   dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   get percentOpen {
//     return _animationController.value;
//   }

//   open() {
//     _animationController.forward();
//   }

//   close() {
//     _animationController.reverse();
//   }

//   toggle() {
//     if (state == MenuState.open) {
//       close();
//     } else if (state == MenuState.closed) {
//       open();
//     }
//   }
// }

// enum MenuState {
//   closed,
//   opening,
//   open,
//   closing,
// }

// //
// // Create item card
// //

// class itemCard extends StatelessWidget {
//   String image, title;
//   itemCard({this.image, this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//           const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
//       child: Container(
//         height: 140.0,
//         width: 400.0,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(15.0))),
//         child: Material(
//           child: DecoratedBox(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(15.0)),
//               image:
//                   DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
//               boxShadow: [
//                 BoxShadow(
//                   color: Color(0xFFABABAB).withOpacity(0.7),
//                   blurRadius: 4.0,
//                   spreadRadius: 3.0,
//                 ),
//               ],
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                 color: Colors.black12.withOpacity(0.1),
//               ),
//               child: Center(
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     shadows: [
//                       BoxShadow(
//                           color: Colors.black.withOpacity(0.7),
//                           blurRadius: 10.0,
//                           spreadRadius: 2.0)
//                     ],
//                     color: Colors.white,
//                     fontFamily: "Sofia",
//                     fontWeight: FontWeight.w800,
//                     fontSize: 39.0,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
