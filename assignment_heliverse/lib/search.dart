import 'package:assignment_heliverse/API_services.dart';
import 'package:assignment_heliverse/Usermodel.dart';
import 'package:flutter/material.dart';

class SearchUser extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
  FetchUser _userList = FetchUser();

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Userlist>>(
          future: _userList.getUserList(query: query),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
              // print(data);
            }
            return ListView.builder(
                itemCount: data?.length,
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
                                  // color: Colors.purple.shade700,
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child:
                                    // Text("ID"),
                                    Image.network("${data?[index].avatar}"),
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
                                    Text(
                                      "Name:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("${data?[index].firstName}"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("${data?[index].lastName}")
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Email:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("${data?[index].email}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Gender:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("${data?[index].gender}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Domain:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("${data?[index].domain}"),
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Search Users"),
    );
  }
}
