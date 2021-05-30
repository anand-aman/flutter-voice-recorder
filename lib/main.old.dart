// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path/path.dart' as p;
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   FlutterSoundRecorder _flutterSound = FlutterSoundRecorder();
//   var myRecorder;
//   PermissionStatus status;
//
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   void startFlutterSound() async{
//     status = await Permission.microphone.request();
//     var storageStatus = await Permission.storage.request();
//     // if (await Permission.microphone.isDenied) {
//     //   // The user opted to never again see the permission request dialog for this
//     //   // app. The only way to change the permission's status now is to let the
//     //   // user manually enable it in the system settings.
//     //   openAppSettings();
//     // }
//     print("Print Status:");
//     print(status);
//     print(storageStatus);
//     print('Current path style: ${p.style}');
//     print('Current process path: ${p.current}');
//   }
//
//   @override
//   void initState(){
//     // TODO: implement initState
//     super.initState();
//     startFlutterSound();
//   }
//
//   Future<void> setSubscriptionDuration(Duration duration) async {
//     print('FS:---> setSubscriptionDuration ');
//     // await _waitOpen();
//     // if (_isInited != Initialized.fullyInitialized) {
//     //   throw Exception('Recorder is not open');
//     // }
//     await _flutterSound.setSubscriptionDuration(duration);
//     // await FlutterSoundRecorderPlatform.instance
//     //     .setSubscriptionDuration(this, duration: duration);
//     // print('FS:<--- setSubscriptionDuration ');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Duration duration = Duration(seconds: 0);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               '${duration.toString()}',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//             TextButton(child: Text('Set State'), onPressed: (){setState(() {
//               print(duration.toString());
//             });},),
//           ],
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           FloatingActionButton(
//             onPressed: () async {
//               myRecorder = await _flutterSound.openAudioSession();
//               setSubscriptionDuration(duration);
//               // _flutterSound.setAudioFocus(focus: AudioFocus.requestFocusAndDuckOthers);
//
//               if (status != PermissionStatus.granted)
//                 throw RecordingPermissionException("Microphone permission not granted");
//
//               await _flutterSound.startRecorder(toFile: 'foo',);
//             },
//             tooltip: 'Play',
//             child: Icon(Icons.play_arrow),
//           ),
//           SizedBox(width: 20,),
//           FloatingActionButton(
//             onPressed: ()async {
//               print(_flutterSound.getRecordURL(path: 'foo'));
//               _flutterSound.closeAudioSession();
//
//               String anURL = await _flutterSound.stopRecorder();
//               print(anURL);
//
//               // if (_recorderSubscription != null)
//               // {
//               //   _recorderSubscription.cancel();
//               //   _recorderSubscription = null;
//               // }
//             },
//             tooltip: 'Stop',
//             child: Icon(Icons.stop),
//           ),
//         ],
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }
// }
