import 'package:flutter/material.dart';
import 'package:flutter_x_mongo/mongohelper/mogodb.connection.dart';
import 'package:flutter_x_mongo/screens/insert.page.dart';
import 'package:flutter_x_mongo/screens/read.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDB.connect();
  runApp(const MongoApp());
}

class MongoApp extends StatefulWidget {
  const MongoApp({Key? key}) : super(key: key);

  @override
  State<MongoApp> createState() => _MongoAppState();
}

class _MongoAppState extends State<MongoApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Read(),
      //theme: ThemeData.,
      debugShowCheckedModeBanner: false,
    );
  }
}
