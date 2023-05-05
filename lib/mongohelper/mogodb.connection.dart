import 'dart:developer';
import 'package:flutter_x_mongo/mongohelper/mongodb.constants.dart';
import 'package:mongo_dart/mongo_dart.dart';


class MongoDB{
  static var client, db, userCollection;
  static connect()async{
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollection = db.collection(USER_COLLECTION);
    if (db.isConnected) {
      log('Connected to MongoDB!');
    } else {
      log('Failed to connect to MongoDB!');
    }
  }
}