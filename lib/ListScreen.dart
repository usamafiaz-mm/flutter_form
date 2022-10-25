import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form/DataModel.dart';
import 'package:flutter_form/DbHandler.dart';
import 'package:flutter_form/FormScreen.dart';
import 'package:flutter_form/form_instance.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: DBHandler.getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                final temp = DataModel.fromJson(
                    jsonDecode(snapshot.data?[index]["formValue"]));

                return ExpansionTile(
                  title: Text(temp.name.toString()),
                  leading: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormScreen(
                                  form: FormInstance().getFormInstance(
                                      value: jsonDecode(snapshot.data?[index]
                                              ["formValue"])
                                          as Map<String, Object?>?),
                                  id: snapshot.data?[index]["id"],
                                )),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                  ),
                  children: [
                    ListTile(
                      title: Text("Email: ${temp.email.toString()}"),
                    ),
                    ListTile(
                      title: Text("Designation: ${temp.dsn.toString()}"),
                    ),
                    ListTile(
                      title: Text("CNIC: ${temp.cnic.toString()}"),
                    ),
                  ],
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FormScreen(
                      form: FormInstance().getFormInstance(),
                    )),
          ).then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
