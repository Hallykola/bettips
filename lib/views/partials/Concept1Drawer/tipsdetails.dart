import 'package:bettips/api/api_response.dart';
import 'package:bettips/blocs/tips_bloc.dart';
import 'package:bettips/blocs/user_bloc.dart';
import 'package:bettips/models/tip.dart';
import 'package:bettips/utils/constants.dart';
import 'package:bettips/views/partials/Concept1Drawer/Concept1Drawer.dart';
import 'package:bettips/views/partials/Concept1Drawer/tiplist.dart';
import 'package:bettips/views/partials/api_error.dart';
import 'package:bettips/views/partials/loading.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipsDetails extends StatefulWidget {
  final String? tag;
  final String? title;
  TipsDetails({Key? key, this.tag, this.title}) : super(key: key);
  @override
  _TipsDetailsState createState() => _TipsDetailsState();
}

class _TipsDetailsState extends State<TipsDetails> {
  String? tag;
  String? title;
  TipsBloc _tipsBloc = new TipsBloc();

  @override
  void initState() {
    tag = widget.tag;
    title = widget.title;
    super.initState();
  }

  @override
  void dispose() {
    _tipsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserBloc user = Provider.of<UserBloc>(context, listen: false);
    bool admin = user.isAdmin;
    return Container(
      child: Scaffold(
          backgroundColor: Colors.white,

          // backgroundColor: Colors.white,

          // Calling variable appbar
          appBar: AppBar(
            backgroundColor: Color(0x00008B), //Color(0xFFFFFFFF),
            elevation: 0.0,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                title as String,
                style: TextStyle(
                    fontFamily: "Sofia",
                    fontSize: 23.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ),
            leading: new IconButton(
                icon: Icon(
                  EvaIcons.arrowBack,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child:
                    InkWell(onTap: () {}, child: Icon(EvaIcons.personOutline)),
              ),
            ],
          ),
          floatingActionButton: admin
              ? FloatingActionButton(
                  onPressed: () => AddTipDialog(context),
                  tooltip: 'Add Tip',
                  child: Icon(Icons.add),
                )
              : Container(),
          body: Container(
            color: Colors.black,
            padding: EdgeInsets.all(Constants.commonPadding),
            child: RefreshIndicator(
                onRefresh: () => _tipsBloc.fetchTips(),
                child: StreamBuilder<ApiResponse<List<Tip>>>(
                    stream: _tipsBloc.tipsstream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data!.status) {
                          case Status.LOADING:
                            return Loading(
                              loadingMessage: snapshot.data!.message,
                            );

                          case Status.COMPLETED:
                            return TipList(
                                tipList: snapshot.data!.data, tag: tag);
                          // return Loading(
                          //   loadingMessage: 'Done',
                          // );

                          case Status.ERROR:
                            return ApiError(
                              errorMessage: snapshot.data!.message,
                              onRetryPressed: () => _tipsBloc.fetchTips(),
                            );
                        }
                      }
                      return Container();
                    })),
          )),
    );
  }
}

class itemCard extends StatelessWidget {
  String? image, title;
  itemCard({this.image, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
      child: Container(
        height: 140.0,
        width: 400.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Material(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              image: DecorationImage(
                  image: AssetImage(image as String), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFABABAB).withOpacity(0.7),
                  blurRadius: 4.0,
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.black12.withOpacity(0.1),
              ),
              child: Center(
                child: Text(
                  title as String,
                  style: TextStyle(
                    shadows: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 10.0,
                          spreadRadius: 2.0)
                    ],
                    color: Colors.white,
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w800,
                    fontSize: 39.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
