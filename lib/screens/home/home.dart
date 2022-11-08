import 'dart:io';
import 'package:brew_for_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  PickedFile? _image;
  bool _loading = false;

  List<dynamic>? _outputs;

  //Load the Tflite model
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  classifyImage(image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
//Declare List _outputs in the class which will be used to show the classified classs name and confidence
      _outputs = output;
    });
  }

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: _loading
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null ? Container() : Image.file(File(_image!.path)),
            SizedBox(
              height: 10,
            ),
            _outputs != null
                ? Text(
              '${_outputs![0]["label"]}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                background: Paint()..color = Colors.white,
              ),
            )
                : Container()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _optiondialogbox,
        backgroundColor: Colors.cyan,
        child: Icon(Icons.image),
      ),
    );
  }

  Future<void> _optiondialogbox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      "Take a Picture",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    onTap: openCamera,
                  ),
                  Padding(padding: EdgeInsets.all(10.0)),
                  GestureDetector(
                    child: Text(
                      "Select image ",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    onTap: openGallery,
                  )
                ],
              ),
            ),
          );
        });
  }

  Future openCamera() async {
    var image = await _picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  //camera method
  Future openGallery() async {
    var piture = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = piture;
    });
    classifyImage(piture);
  }
}
