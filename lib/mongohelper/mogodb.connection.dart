// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';
import 'package:flutter_x_mongo/mongohelper/mongodb.constants.dart';
import 'package:flutter_x_mongo/mongohelper/mongodb.data.model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDB {
  static var db, userCollection;
  // for connection to database
  static connect() async {
    // creating client
    db = await Db.create(MONGO_CONN_URL);
    // opeing connection to database
    await db.open();
    // establishing collection name
    userCollection = db.collection(USER_COLLECTION);
    // checking if connection was established with server or not
    if (db.isConnected) {
      log('Connected to MongoDB!');
    } else {
      log('Failed to connect to MongoDB!');
    }
  }
  static Future<void> deleteData(User data)async {
    var res = await userCollection.remove(where.id(data.id));
  }
  static Future<void> updateData(User data)async{
    var res = await userCollection.findOne({'_id': data.id});
    res['name'] = data.name;
    res['reg'] = data.reg;
    res['email'] = data.email;
    var response = await userCollection.save(res);
    inspect(response);
  }
  // for reading data from the database // same for querying in find(where.)
  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  // for inserting data into the database
  static Future<String> insert(User data) async {
    try {
      var res = userCollection.insertOne(data.toJson());
      if (res.isSuccess) {
        return "Data Inserted Succesfully";
      } else {
        return "Something went wrong...";
      }
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }
}
