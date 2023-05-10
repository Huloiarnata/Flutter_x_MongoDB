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
  String _checkInsertData = "Insert";

  @override
  Widget build(BuildContext context) {
    User data = ModalRoute.of(context)!.settings.arguments as User;
    if(data!=null){
      nameController.text = data.name;
      regController.text = data.reg;
      emailController.text = data.email;
      _checkInsertData = 'Update';
    }
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Student Details",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
              width: 350,
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "Enter name: "),
              )),
          SizedBox(
              width: 350,
              child: TextField(
                controller: regController,
                decoration: const InputDecoration(hintText: "Enter RegNo: "),
              )),
          SizedBox(
              width: 350,
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: "Enter email: "),
              )),
          ElevatedButton(
              onPressed: () {
                if(_checkInsertData =='Update'){
                  print(data.name);
                  _valueChange();
                  print(data.name);
                   _updateData(data.id, nameController.text, regController.text, emailController.text );
                }else {
                  //for inserting new data
                  _valueChange();
                  _insertData(name, reg, email);
                }
              },
              child: Text(_checkInsertData))
        ],
      ),
    ));
  }
  Future<void> _updateData(var id, String name, String reg, String email)async {
    final upData = User(id: id, name: name, reg: reg, email: email);
    var res = await MongoDB.updateData(upData).whenComplete(() => Navigator.pop(context));
  }
  Future<void> _insertData(String name, String reg, String email) async {
    var id = M.ObjectId();
    final data = User(id: id, name: name, reg: reg, email: email);
    var result = await MongoDB.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Inserted id: " + id.$oid)));
    _clearAll();
  }
  void _valueChange(){
    setState(() {
      name = nameController.text;
      reg = regController.text;
      email = emailController.text;
    });

  }
  void _clearAll() {
    name = '';
    reg = '';
    email = '';
  }
}
