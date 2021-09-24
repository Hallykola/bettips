import 'package:bettips/blocs/tips_bloc.dart';
import 'package:bettips/blocs/user_bloc.dart';
import 'package:bettips/models/mycategorie.dart';
import 'package:bettips/views/partials/Concept1Drawer/tipsdetails.dart';
import 'package:flutter/material.dart';
import 'package:bettips/views/partials/FadeAnimation.dart';
import 'package:provider/provider.dart';

class CatsList extends StatelessWidget {
  final List<Categorie>? catList;

  const CatsList({Key? key, this.catList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: catList!.length,
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      //   childAspectRatio: 1.5 / 1.8,
      // ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {},
            child: itemCard(
              image: "assets/images/ballbgtile.jpg",
              title: catList![index].name as String,
              cat: catList![index],
            ),
          ),
        );
      },
    );
  }
}

class itemCard extends StatelessWidget {
  String? image, title;
  Categorie? cat;
  TipsBloc? _tipsBloc;
  itemCard({this.image, this.title, this.cat});

  @override
  Widget build(BuildContext context) {
    UserBloc user = Provider.of<UserBloc>(context, listen: false);
    bool admin = user.isAdmin;
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
              color: Colors.black,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TipsDetails(
                                title: cat!.name as String,
                                tag: cat!.tags as String),
                          ),
                        );
                      },
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
                    SizedBox(height: 8),
                    admin
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    AddDialog(context, cat: cat as Categorie);
                                  },
                                  child: Icon(Icons.edit,
                                      color: Colors.blueAccent)),
                              SizedBox(width: 18),
                              GestureDetector(
                                  onTap: () {
                                    simpleDialog(context, cat as Categorie);
                                  },
                                  child: Icon(Icons.delete,
                                      color: Colors.redAccent)),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void simpleDialog(BuildContext context, Categorie cat) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete Category?",
            style: TextStyle(
                fontFamily: "Sofia",
                fontWeight: FontWeight.w700,
                fontSize: 18.0)),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL', style: TextStyle(fontFamily: "Sofia")),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: const Text('OK', style: TextStyle(fontFamily: "Sofia")),
            onPressed: () {
              TipsBloc bloc = new TipsBloc();
              bloc.deleteCat(cat.id as int);
              bloc.fetchCats();
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}

void AddDialog(BuildContext context, {Categorie? cat}) {
  final _formKey = GlobalKey<FormState>();
  bool editing = false;
  TextEditingController catname = new TextEditingController();
  TextEditingController tags = new TextEditingController();
  TextEditingController description = new TextEditingController();

  if (cat != null) {
    catname.text = cat.name as String;
    tags.text = cat.tags as String;
    description.text = cat.description as String;
    editing = true;
    // id.text = cat.id;
  }
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Add Category",
            style: TextStyle(
                fontFamily: "Sofia",
                fontWeight: FontWeight.w700,
                fontSize: 18.0)),
        content: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        autofocus: false,
                        controller: catname,
                        cursorColor: Colors.amber,
                        style: TextStyle(height: 2.0),
                        cursorWidth: 2.5,
                        decoration: InputDecoration(
                          labelText: "Category name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: Colors.amber,
                                  style: BorderStyle.solid)),
                        ),
                        onFieldSubmitted: (text) {
                          print(text);
                        },
                        validator: (value) {
                          if (value!.isEmpty || value == " ") {
                            return "Value cannot  be empty";
                          }
                          //return "";
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Tags",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                color: Colors.amber, style: BorderStyle.solid)),
                      ),
                      // The validator receives the text that the user has entered.
                      controller: tags,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some Categorie name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                color: Colors.amber, style: BorderStyle.solid)),
                      ),
                      // The validator receives the text that the user has entered.
                      controller: description,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some Categorie name';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // Scaffold.of(context).showSnackBar(
                        //     SnackBar(content: Text('Processing Data')));
                        Categorie acat = new Categorie(
                            name: catname.text,
                            tags: tags.text,
                            description: description.text);
                        TipsBloc bloc = new TipsBloc();
                        if (editing) {
                          print('I want to edit');
                          bloc.editcat(cat!.id as int, acat);
                        } else {
                          print('I want to add');
                          bloc.addcat(acat);
                        }
                        bloc.fetchCats();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL', style: TextStyle(fontFamily: "Sofia")),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          // FlatButton(
          //   child: const Text('OK', style: TextStyle(fontFamily: "Sofia")),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          // )
        ],
      );
    },
  );
}
