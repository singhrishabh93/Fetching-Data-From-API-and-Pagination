import 'package:assignment_heliverse/API_services.dart';
import 'package:assignment_heliverse/Usermodel.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FetchUser _userList = FetchUser();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: FutureBuilder<List<Userlist>>(
            future: _userList.getUserList(),
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
                // print(data);
              }
              return ListView.builder(
                itemCount: _userList.data.length,
                itemBuilder: (context, index) {
                return Container(
                  child: Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.purple.shade700,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: 
                              // Text("ID"),
                              Image.network(
                                  "${data?[index].avatar}"),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("first Name"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Last Name")
                                ],
                              ),
                              Text("Email"),
                              Row(
                                children: [
                                  Text("Gender"),
                                  SizedBox(
                                    width: 80,
                                  ),
                                  Text("Domain"),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
            }),
      ),
    ));
  }
}
