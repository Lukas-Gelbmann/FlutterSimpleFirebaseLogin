import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  HomePage({this.auth, this.onSignedOut});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Welcome'),
        actions: <Widget>[
          new FlatButton(
              onPressed: _signOut,
              child: new Text('Log out',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)))
        ],
      ),
      body: new Container(
          child: new Center(
        child: new Text(
          'Welcome',
          style: new TextStyle(fontSize: 32.0),
        ),
      )),
    );
  }

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
      Fluttertoast.showToast(
          msg: "Logged out",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1);
    } catch (e) {
      print(e);
    }
  }
}
