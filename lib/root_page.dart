import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/auth.dart';
import 'package:flutter_firebase_auth/home_page.dart';
import 'package:flutter_firebase_auth/login_page.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key, this.auth}): super(key: key);

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
         _authStatus = userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return new HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
  }

  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }
}
