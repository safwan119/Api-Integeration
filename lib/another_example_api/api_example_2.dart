import 'dart:convert';

import 'package:api_integeration/Models/product_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiExample2 extends StatefulWidget {
  const ApiExample2({super.key});

  @override
  State<ApiExample2> createState() => _ApiExample2State();
}

class _ApiExample2State extends State<ApiExample2> {
  Future<ProductModels> getProductApi() async {
    final response = await http.get(
      Uri.parse(
        "https://b7acee01-43b1-4865-8af6-d91b988f7a0b.mock.pstmn.io/example",
      ),
    );
    var data = jsonDecode(response.body.toString());
    print("data in this is:$data");
    if (response.statusCode == 200) {
      print(
        "Data gaining success and the status code is ${response.statusCode}",
      );

      return ProductModels.fromJson(data);
    } else {
      print(
        "Data gaining failed and the status code is ${response.statusCode}",
      );
      return ProductModels.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Example 2"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductModels>(
              future: getProductApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            ListTile(
                               
                              leading: CircleAvatar(
                                backgroundImage:NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                              ),
                              title: Text(snapshot.data!.data![index].shop!.name.toString()),
                              subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),

                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * .3,

                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    snapshot.data!.data![index].images!.length,
                                itemBuilder: (context, position) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            snapshot
                                                .data!
                                                .data![index]
                                                .images![position]
                                                .url
                                                .toString(),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      width:
                                          MediaQuery.of(context).size.width *
                                          .5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                          .25,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Align( alignment:Alignment.centerLeft,
                                child: Icon(snapshot.data!.data![index].inWishlist==true?Icons.favorite:Icons.favorite_border)

                            )
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("Loading..."));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
