import 'dart:convert';
import 'package:api_integeration/Models/JsonModels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<JsonModels> postList = [];

  Future<List<JsonModels>> getApi() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map i in data) {
        postList.add(JsonModels.fromJson(i as Map<String, dynamic>));
      }
      return postList;
    } else {
      print("Error in this..${response.statusCode}");
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Api Screen"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Expanded(
            child: FutureBuilder(
              future: getApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading");
                } else {
                  return ListView.separated(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(postList[index].title.toString()),
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                  },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
