
 // ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names
 
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_app/logintest/my_home_page.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

PrettyPrinter() {
}

Logger({required printer}) {
}
 
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
 
 
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  _MyAppState createState() => _MyAppState();
}
 
class _MyAppState extends State<MyApp> {
 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '로그인 앱',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
 
  @override
  void initState() {
    super.initState();
 
  }
 
  @override
  dispose() async {
    super.dispose();
 
  }
 
}

