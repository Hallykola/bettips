import 'package:bettips/api/api_response.dart';
import 'package:bettips/blocs/tips_bloc.dart';
import 'package:bettips/blocs/user_bloc.dart';
import 'package:bettips/models/mycategorie.dart';
import 'package:bettips/utils/constants.dart';
import 'package:bettips/views/partials/Concept1Drawer/catlist.dart';
import 'package:bettips/views/partials/api_error.dart';
import 'package:bettips/views/partials/drawer.dart';
import 'package:bettips/views/partials/loading.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  TipsBloc _tipsBloc = new TipsBloc();

  @override
  void initState() {
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
            drawer: HomeDrawer(),

            // Calling variable appbar
            appBar: AppBar(
              backgroundColor: Color(0xFFFFFFFF),
              elevation: 0.0,
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text(
                  "Category",
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontSize: 23.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
              leading:  Builder(builder: (BuildContext context) {
      return new GestureDetector(
        onTap: (){
          Scaffold.of(context).openDrawer();
        },
        child:Icon(
                    EvaIcons.menu2Outline,
                    color: Colors.black,
                  ),
      );
    }),
              // leading: new IconButton(
              //     icon: Icon(
              //       EvaIcons.menu2Outline,
              //       color: Colors.black,
              //     ),
              //     onPressed: () => Scaffold.of(context).openDrawer()),
              // actions: <Widget>[
              //   Padding(
              //     padding: const EdgeInsets.only(right: 10.0),
              //     child: InkWell(
              //         onTap: () {}, child: Icon(EvaIcons.personOutline)),
              //   ),
              // ],
            ),
            floatingActionButton: admin
                ? FloatingActionButton(
                    onPressed: () => AddDialog(context),
                    tooltip: 'Add Category',
                    child: Icon(Icons.add),
                  )
                : Container(),
            body: Container(
              color: Colors.black,
              padding: EdgeInsets.all(Constants.commonPadding),
              child: RefreshIndicator(
                  onRefresh: () => _tipsBloc.fetchCats(),
                  child: StreamBuilder<ApiResponse<List<Categorie>>>(
                      stream: _tipsBloc.catsstream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          switch (snapshot.data!.status) {
                            case Status.LOADING:
                              return Loading(
                                loadingMessage: snapshot.data!.message,
                              );

                            case Status.COMPLETED:
                              return CatsList(catList: snapshot.data!.data);
                            // return Loading(
                            //   loadingMessage: 'Done',
                            // );

                            case Status.ERROR:
                              return ApiError(
                                errorMessage: snapshot.data!.message,
                                onRetryPressed: () => _tipsBloc.fetchCats(),
                              );
                          }
                        }
                        return Container();
                      })),
            )));
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
