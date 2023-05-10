import 'package:flutter/material.dart';
import 'package:flutter_x_mongo/mongohelper/mogodb.connection.dart';
import 'package:flutter_x_mongo/screens/insert.page.dart';

import '../mongohelper/mongodb.data.model.dart';

class Update extends StatefulWidget {
  const Update({Key? key}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: MongoDB.getData(),
            builder: (context, AsyncSnapshot snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasData) {
                  var size = snapshot.data.length;
                  debugPrint("Toal Data: " + size.toString());
                  return ListView.builder(
                      itemCount: size,
                      itemBuilder: ((context, index) {
                        return cardData(
                            User.fromJson(snapshot.data[index]));
                      }));
                } else {
                  return const Center(child: Text("No Data available"));
                }
              }
            })
      ),
    );
  }

  Widget cardData(User data){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Text('${data.id}'),
              const SizedBox(height: 5),
              Text('${data.name}'),
              const SizedBox(height: 5),
              Text('${data.reg}'),
              const SizedBox(height: 5),
              Text('${data.email}'),
              const SizedBox(height: 5),
            ]),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return Insert();
              }, settings: RouteSettings(arguments: data)));
            }, icon: const Icon(Icons.edit))
          ],
        ),
      ),
    );
  }
}