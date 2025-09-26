import 'package:api_integeration/View/detail_screen.dart';
import 'package:api_integeration/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryDetailList extends StatefulWidget {
  const CountryDetailList({super.key});

  @override
  State<CountryDetailList> createState() => _CountryDetailListState();
}

class _CountryDetailListState extends State<CountryDetailList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ApiServices apiServices = ApiServices();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black38,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              TextFormField(
                controller: searchController,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: "Search for country detail",
                  labelStyle: TextStyle(color: Colors.white),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              Expanded(
                child: FutureBuilder(
                  future: apiServices.countryDetail(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: ListTile(
                              title: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              leading: Container(
                                height: 50,
                                width: 50,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]["country"];
                          if (searchController.text.isEmpty) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      name: name,
                                      image: snapshot
                                          .data![index]["countryInfo"]["flag"],
                                      active: snapshot.data![index]["active"],
                                      todayCases:  snapshot.data![index]["todayCases"],
                                      todayRecovered: snapshot.data![index]["todayRecovered"],
                                      todayDeath: snapshot.data![index]["todayDeaths"],
                                      totalCases: snapshot.data![index]["cases"],
                                      totalDeaths: snapshot.data![index]["deaths"],
                                      totalRecovered: snapshot.data![index]["recovered"],
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(
                                  snapshot.data![index]["country"],
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]["updated"].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                leading: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image(
                                    image: NetworkImage(
                                      snapshot
                                          .data![index]["countryInfo"]["flag"],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (name.toLowerCase().contains(
                            searchController.text.toLowerCase(),
                          )) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      name: name,
                                      image: snapshot
                                          .data![index]["countryInfo"]["flag"],
                                      active: snapshot.data![index]["active"],
                                      todayCases:  snapshot.data![index]["todayCases"],
                                      todayRecovered: snapshot.data![index]["todayRecovered"],
                                      todayDeath: snapshot.data![index]["todayDeaths"],
                                      totalCases: snapshot.data![index]["cases"],
                                      totalDeaths: snapshot.data![index]["deaths"],
                                      totalRecovered: snapshot.data![index]["recovered"],
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(
                                  snapshot.data![index]["country"],
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]["updated"].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                leading: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image(
                                    image: NetworkImage(
                                      snapshot
                                          .data![index]["countryInfo"]["flag"],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
