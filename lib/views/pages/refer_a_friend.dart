import 'package:bettips/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:bettips/utils/constants.dart';
import 'package:bettips/views/partials/custom_form_fields.dart';
// import 'package:bettips/views/partials/fake_bottom_buttons.dart';

class ReferAFriendPage extends StatefulWidget {
  @override
  _ReferAFriendPageState createState() => _ReferAFriendPageState();
}

class _ReferAFriendPageState extends State<ReferAFriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refer A Friend"),
      ),
      body: Container(
        padding: EdgeInsets.all(Constants.commonPadding),
        child: ListView(
          children: <Widget>[
            Text(
              "Tell a friend to tell a friend to tell a friend.",
              style: Styles.h1.copyWith(
                height: 2,
              ),
            ),
            Container(
              height: 300,
              child: Image.asset('assets/images/collaboration.png'),
            ),
            MySubmitIconedButton(
                "Share App With Friends", Icon(Icons.share), false, () {
              Share.share(Constants.shareMessage,
                  subject: Constants.shareSubject);
            }),
            //FakeBottom(),
          ],
        ),
      ),
    );
  }

  Widget MySubmitIconedButton(
      String text, Icon icon, bool isFilled, Function() action) {
    return MaterialButton(
      onPressed: action,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          icon,
          Expanded(
            child: Text(
              text,
              style: Styles.p_button.copyWith(
                fontWeight: FontWeight.bold,
                color: isFilled ? Colors.white : Color(Styles.redColor),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      color: isFilled ? Color(Styles.redColor) : Colors.transparent,
      textColor: isFilled ? Colors.white : Color(Styles.redColor),
      elevation: 0,
      minWidth: 350,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(color: Color(Styles.redColor)),
      ),
    );
  }
}
