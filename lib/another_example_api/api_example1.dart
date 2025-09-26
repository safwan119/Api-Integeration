import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/JsonUserModel.dart';

class ApiExample1 extends StatefulWidget {
  const ApiExample1({super.key});

  @override
  _ApiExample1State createState() => _ApiExample1State();
}

class _ApiExample1State extends State<ApiExample1> {
  List<JsonUserModel> userList=[];
  Future<List<JsonUserModel>> getApiData()async{
    final response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
    for(Map i in data){
      userList.add(JsonUserModel.fromJson(i));
    }
      return userList;
    }
    else{
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Api'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(child: FutureBuilder(future: getApiData(), builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState){
          return CircularProgressIndicator(color: Colors.black,strokeWidth: 4,);
        }
              if(!snapshot.hasData){
          return Center(child: Text("Loading..."));
        }
        else {
          return ListView.builder(itemCount: userList.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ReusableRow(name: "Id", detail: snapshot.data![index].id.toString()),
                      ReusableRow(name: "Name", detail: snapshot.data![index].name.toString()),
                      ReusableRow(name: "UserName", detail: snapshot.data![index].username.toString()),
                      ReusableRow(name: "Email", detail: snapshot.data![index].email.toString()),
                      ReusableRow(name: "PhoneNumber", detail: snapshot.data![index].phone.toString()),
                      ReusableRow(name: "Address", detail: snapshot.data![index].address!.geo!.lat.toString()),
                      ReusableRow(name: "Company Name", detail: snapshot.data![index].company.toString()),
                    ],
                  ),
                ),
              );
            },
          );
        }
            }))
          ],
        ),
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  final String name;
  final String detail;
  const ReusableRow({super.key, required this.name,required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(detail),
        ],
      ),
    );
  }
}
