import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase2/model/video_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app= await Firebase.initializeApp();
  runApp(MyApp(app:app));
}

class MyApp extends StatelessWidget {
 final FirebaseApp app;
  MyApp({required this.app});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(app:app, title: 'bababab',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title,required this.app}) : super(key: key);
  final String title;
  final FirebaseApp app;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   late  DatabaseReference _videoRef;
  @override
  void initState() {
    final database= FirebaseDatabase(app:widget.app);
    _videoRef = database.ref().child('Video');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FirebaseAnimatedList(
      query: _videoRef,
        itemBuilder: (BuildContext context,
        DataSnapshot snapshot,
        Animation<double> animation, int index){
        VideoModel videoModel = VideoModel.fromJson(
            json.decode(json.encode(snapshot.value)));
        return GestureDetector(child: Image.network(videoModel.thumbnail),);
        },
      ),

    );
  }
}
