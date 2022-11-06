import 'dart:io';
import 'package:brew_for_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  File? image;

  Future pickImage() async{
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null)
        return;
      setState(() =>
      this.image = File(image.path)
      );
    }
    on PlatformException catch(e){
      print("Something went wrong: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return //StreamProvider<List<Brew>?>.value(
      //   value: DatabaseService().brews,
      //   initialData: null,
      //   catchError: (_, __) => null,
      //   child:
      Scaffold(
        backgroundColor: Colors.grey[300],
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
        drawer: Drawer(
            child: Container(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: CircleAvatar(
                    minRadius: 50,
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    children: [Text('data')],
                  ),
                ),
              ]),
            )),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: image!=null ? Image.file(image!,
                    height: 500,
                    width: 350,
                    fit: BoxFit.contain
                  ): Icon(Icons.image),
                  height: 500,
                  width: 350,
                  // padding: EdgeInsets.only(
                  //     left: 150, right: 150, top: 80, bottom: 80),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    // image: DecorationImage(image: ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: Offset(4, 4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4, -4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                  child: Text('hello'),
                  padding:
                  EdgeInsets.only(left: 120, right: 120, top: 30, bottom: 30),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: Offset(4, 4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4, -4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 280.0,top: 8),
                  child: FloatingActionButton(
                    backgroundColor: Colors.cyan,
                    hoverColor: Colors.brown[300],
                    onPressed: () {
                      // Add your onPressed code here!
                      pickImage();
                    },
                    child: const Icon(Icons.video_call),
                  ),
                )
              ],
            ),
          ),
        ),

      );
  }
}
