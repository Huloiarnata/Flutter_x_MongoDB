import 'package:flutter/material.dart';
import 'package:flutter_x_mongo/mongohelper/mongodb.data.model.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

import '../mongohelper/mogodb.connection.dart';

class Insert extends StatefulWidget {
  const Insert({Key? key}) : super(key: key);

  @override
  State<Insert> createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  var nameController = TextEditingController();
  String name = '';
  var regController = TextEditingController();
  String reg = '';
  var emailController = TextEditingController();
  String email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Student Details",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
              width: 350,
              child: TextField(
                controller: nameController,
                onChanged: (value) => setState(() {
                  name = value;
                }),
                decoration: const InputDecoration(hintText: "Enter name: "),
              )),
          SizedBox(
              width: 350,
              child: TextField(
                controller: regController,
                onChanged: (value) => setState(() {
                  reg = value;
                }),
                decoration: const InputDecoration(hintText: "Enter RegNo: "),
              )),
          SizedBox(
              width: 350,
              child: TextField(
                controller: emailController,
                onChanged: (value) => setState(() {
                  email = value;
                }),
                decoration: const InputDecoration(hintText: "Enter email: "),
              )),
          ElevatedButton(
              onPressed: () {
                _insertData(name, reg, email);
              },
              child: const Text('Submit'))
        ],
      ),
    ));
  }

  Future<void> _insertData(String name, String reg, String email) async {
    var id = M.ObjectId();
    final data = User(id: id, name: name, reg: reg, email: email);
    var result = await MongoDB.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Inserted id: " + id.$oid)));
    _clearAll();
  }

  void _clearAll() {
    name = '';
    reg = '';
    email = '';
  }
}
