import 'package:bettips/blocs/tips_bloc.dart';
import 'package:bettips/blocs/user_bloc.dart';
import 'package:bettips/models/mycategorie.dart';
import 'package:bettips/models/tip.dart';
import 'package:flutter/material.dart';
import 'package:bettips/views/partials/FadeAnimation.dart';
import 'package:provider/provider.dart';

class TipList extends StatelessWidget {
  final List<Tip>? tipList;
  final tag;

  const TipList({
    Key? key,
    this.tipList,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tipList!.length,
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      //   childAspectRatio: 1.5 / 1.8,
      // ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              onTap: () {},
              child: 
                tipList![index].tags!.contains(tag)
                    ? itemCard(
                        image: "assets/images/bgtile.jpg",
                        title:
                            '${tipList![index].teama} vs ${tipList![index].teamb}',
                        tip: tipList![index],
                      )
                    : Container(
                        // child: Center(
                        //   child: Text("No Tips in this category"),
                        // ),
                        ),
              ),
        );
      },
    );
  }
}

class itemCard extends StatelessWidget {
  String? image, title;
  Tip? tip;
  TipsBloc? _tipsBloc;
  itemCard({this.image, this.title, this.tip});

  @override
  Widget build(BuildContext context) {
    UserBloc user = Provider.of<UserBloc>(context, listen: false);
    bool admin = user.isAdmin;
    return Padding(
      padding:
          const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
      child: Container(
        //height: 140.0 * 2,
        width: 400.0,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Material(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              image:
                  DecorationImage(image: AssetImage(image as String), fit: BoxFit.cover),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    detailCard(tip as Tip),
                    SizedBox(height: 8),
                    admin
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    AddTipDialog(context, tip: tip as Tip);
                                  },
                                  child: Icon(Icons.edit,
                                      color: Colors.blueAccent)),
                              SizedBox(width: 18),
                              GestureDetector(
                                  onTap: () {
                                    simpleDialog(context, tip as Tip);
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

void simpleDialog(BuildContext context, Tip tip) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete Tip?",
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
              bloc.deleteTip(tip.id as int);
              bloc.fetchTips();
              //bloc.fetchTagTips(tags);
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}

void AddTipDialog(BuildContext context, {Tip? tip}) {
  final _formKey = GlobalKey<FormState>();
  bool editing = false;
  TextEditingController teama = new TextEditingController();
  TextEditingController teamb = new TextEditingController();
  TextEditingController teamalast = new TextEditingController();
  TextEditingController teamblast = new TextEditingController();
  TextEditingController teamaodd = new TextEditingController();
  TextEditingController teambodd = new TextEditingController();
  TextEditingController drawodd = new TextEditingController();
  TextEditingController tags = new TextEditingController();
  TextEditingController description = new TextEditingController();

  if (tip != null) {
    teama.text = tip.teama as String;
    teamb.text = tip.teamb as String;
    teamalast.text = tip.teamalast as String;
    teamblast.text = tip.teamblast as String;
    teamaodd.text = tip.teamaodd as String;
    teambodd.text = tip.teambodd as String;
    drawodd.text = tip.drawodd as String;
    tags.text = tip.tags as String;
    description.text = tip.description as String;

    editing = true;
    // id.text = cat.id;
  }
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Add Tip",
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
                  inputLine(teama, "Team A", "Enter Team name"),
                  inputLine(teamb, "Team B", "Enter Team name"),
                  inputLine(teamalast, "Team A last games",
                      "Enter Team A last games"),
                  inputLine(teamblast, "Team B last games",
                      "Enter Team B last games"),
                  inputLine(teamaodd, "Team A odds", "Enter Team A odd"),
                  inputLine(teambodd, "Team B odds", "Enter Team B odd"),
                  inputLine(drawodd, "Both teams Draw odds", "Enter Draw odd"),
                  inputLine(tags, "Tip Tags to match category tag",
                      "Enter Tip tags to match category"),
                  inputLine(
                      description, "Description", "Enter Tip description"),
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // Scaffold.of(context).showSnackBar(
                        //     SnackBar(content: Text('Processing Data')));
                        Tip atip = new Tip(
                            teama: teama.text,
                            teamb: teamb.text,
                            teamalast: teamalast.text,
                            teamblast: teamblast.text,
                            teamaodd: teamaodd.text,
                            teambodd: teambodd.text,
                            drawodd: drawodd.text,
                            tags: tags.text,
                            description: description.text);
                        TipsBloc bloc = new TipsBloc();
                        if (editing) {
                          print('I want to edit tip');
                          bloc.edittip(tip!.id as int, atip);
                        } else {
                          print('I want to add tip');
                          bloc.addtip(atip);
                        }
                        //bloc.fetchTips();
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

Widget inputLine(
    TextEditingController controller, String title, String errorMssg) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
        autofocus: false,
        controller: controller,
        cursorColor: Colors.amber,
        style: TextStyle(height: 2.0),
        cursorWidth: 2.5,
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:
                  BorderSide(color: Colors.amber, style: BorderStyle.solid)),
        ),
        onFieldSubmitted: (text) {
          print(text);
        },
        validator: (value) {
          if (value!.isEmpty || value == " ") {
            return errorMssg;
          }
          //return "";
        }),
  );
}

Widget myText(String texty) {
  return Text(
    texty,
    style: TextStyle(
      shadows: [
        BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 10.0,
            spreadRadius: 2.0)
      ],
      color: Colors.white,
      fontFamily: "Sofia",
      fontWeight: FontWeight.w600,
      fontSize: 25.0,
    ),
  );
}

Widget mySmallText(String texty) {
  return Container(
    decoration: BoxDecoration(border: Border.all(color: Colors.white)),
    padding: EdgeInsets.all(3.0),
    child: Text(
      texty,
      style: TextStyle(
        shadows: [
          BoxShadow(
              color: Colors.black.withOpacity(0.7),
              blurRadius: 10.0,
              spreadRadius: 2.0)
        ],
        color: Colors.white,
        fontFamily: "Sofia",
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
      ),
    ),
  );
}

Widget myColumn(String top, String bottom) {
  return Column(
    children: [
      myText(top),
      myText(bottom),
    ],
  );
}

List<Widget> pastgames(String list) {
  List<Widget> mylist = list.split(" ").map((v) {
    mySmallText(v);
  }).toList() as List<Widget>;
  return mylist;
}

Widget detailCard(Tip tippy) {
  return Container(
    child: Column(
      children: [
        myText(tippy.teama as String),
        mySmallText(tippy.teamalast as String),
        SizedBox(height: 18),
        FlatButton(
          onPressed: () {},
          child: myText('VS'),
        ),
        mySmallText(tippy.description as String),
        SizedBox(height: 18),
        myText(tippy.teamb as String),
        mySmallText(tippy.teamblast as String),
        SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            myColumn('1', tippy.teamaodd as String),
            myColumn('X', tippy.drawodd as String),
            myColumn('2', tippy.teambodd as String),
          ],
        )
      ],
    ),
  );
}
