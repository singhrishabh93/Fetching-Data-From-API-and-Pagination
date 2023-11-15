import 'package:assignment_heliverse/API_services.dart';
import 'package:assignment_heliverse/Usermodel.dart';
import 'package:assignment_heliverse/search.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FetchUser _userList = FetchUser();

  final List<String> categories = ['Domain', 'Gender', 'Availability'];
  List<String> selectedCategories = [];
  @override
  Widget build(BuildContext context) {
    final filterProducts = _userList.data.where((product) {
      return selectedCategories.isEmpty ||
          selectedCategories.contains(product.category);
    }).toList();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("User Data Display"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchUser());
            },
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: categories
                .map((category) => FilterChip(
                    label: Text(category),
                    selected: selectedCategories.contains(category),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedCategories.add(category);
                        } else {
                          selectedCategories.remove(category);
                        }
                      });
                    }))
                .toList(),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 670,
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
                      // itemCount: _userList.data.length,
                      itemCount: filterProducts.length,
                      itemBuilder: (context, index) {
                        final product = filterProducts[index];
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
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child:
                                          // Text("ID"),
                                          Image.network(
                                              "${data?[index].avatar}"),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Name:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text("${data?[index].firstName}"),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text("${data?[index].lastName}")
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Email:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text("${data?[index].email}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Gender:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text("${data?[index].gender}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Domain:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          // Text("${data?[index].domain}"),
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
          ),
        ],
      ),
    ));
  }
}
