import 'package:flutter/material.dart';
import 'package:flutter_x_mongo/mongohelper/mongodb.data.model.dart';

import '../mongohelper/mogodb.connection.dart';

class Read extends StatefulWidget {
  const Read({super.key});

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: MongoDB.getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasData) {
                  var size = snapshot.data.length;
                  debugPrint("Toal Data: " + size.toString());
                  return ListView.builder(
                      itemCount: size,
                      itemBuilder: ((context, index) {
                        return _displayCard(
                            User.fromJson(snapshot.data[index]));
                      }));
                } else {
                  return const Center(child: Text("No Data available"));
                }
              }
            }),
      ),
    );
  }

  Widget _displayCard(User data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Text('${data.id}'),
          const SizedBox(height: 5),
          Text('${data.name}'),
          const SizedBox(height: 5),
          Text('${data.reg}'),
          const SizedBox(height: 5),
          Text('${data.email}'),
          const SizedBox(height: 5),
        ]),
      ),
    );
  }
}
