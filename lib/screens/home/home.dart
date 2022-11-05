import 'package:brew_for_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'dumb_home.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return //StreamProvider<List<Brew>?>.value(
        //   value: DatabaseService().brews,
        //   initialData: null,
        //   catchError: (_, __) => null,
        //   child:
        Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
          title: Text('Dumb Talk'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.brown[800],
              ),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text('logout', style: TextStyle(color: Colors.brown[800])),
            )
          ]),
      body: Container(
          child: ListView(children: [
        TextButton(
          onPressed: () {},
          child: Text("Open Camera"),
        ),
      ])),
    );
  }
}
