import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_voice_chat/audio_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_voice_chat/audio_recorder.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showPlayer = false;
  String path;
  String recordingURL;

  void initialize() async{
    await Permission.microphone.request();
    await Permission.storage.request();
    await Firebase.initializeApp();
  }


  @override
  void initState() {
    showPlayer = false;
    super.initState();
    initialize();
  }

  Future<void> uploadData(String filePath)async{
    final _firebaseStorage = FirebaseStorage.instance;
    File file = File(filePath);
    var snapshot;
    try {
      snapshot = await _firebaseStorage
          .ref('uploads/record.m4a')
          .putFile(file);
    } on FirebaseException catch (e) {
      print(e.toString());
    }
    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      print(downloadUrl);
      recordingURL = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: FutureBuilder<String>(
            future: getPath(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (showPlayer) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: AudioPlayer(
                          path: snapshot.data,
                          onDelete: () {
                            setState(() => showPlayer = false);
                          },
                          isLocal: true,
                        ),
                      ),
                      Text("Local File Player"),
                      SizedBox(height: 20,),
                      ElevatedButton(onPressed: () async {
                        print("Uploading......");
                        print(snapshot.data);
                        await uploadData(snapshot.data);
                      }, child: Text('Firebase Upload'),),
                      SizedBox(height: 20,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: AudioPlayer(
                          path: recordingURL,
                          onDelete: () {
                            // setState(() => showPlayer = false);
                          }, isLocal: false,
                        ),
                      ),
                      Text("Online Stream Player"),
                    ],
                  );
                } else {
                  return AudioRecorder(
                    path: snapshot.data,
                    onStop: () async{
                      await uploadData(snapshot.data);
                      setState(() => showPlayer = true);
                    },
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Future<String> getPath() async {
    if (path == null) {
      final dir = await getApplicationDocumentsDirectory();
      print(dir);
      path = dir.path +
          '/' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          '.m4a';
    }
    return path;
  }
}