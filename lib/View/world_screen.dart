import 'package:api_integeration/Models/WorldStateData.dart';
import 'package:api_integeration/View/country_detail_list.dart';
import 'package:api_integeration/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldScreen extends StatefulWidget {
  const WorldScreen({super.key});

  @override
  State<WorldScreen> createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen>
    with TickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    animationController.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ApiServices apiServices = ApiServices();
    return Scaffold(
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              FutureBuilder(
                future: apiServices.worldStateFutureData(),
                builder: (context, AsyncSnapshot<WorldStateData> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        controller: animationController,
                      ),
                    );
                  }
                  // 2. Check for errors
                  else if (snapshot.hasError) {
                    return Expanded(
                      flex: 1,
                      child: Center(
                        child: Text("Error fetching data: ${snapshot.error}"),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .08,
                        ),
                        PieChart(
                          dataMap: {
                            "Total": double.parse(
                              snapshot.data!.cases.toString(),
                            ),
                            "Recovered": double.parse(
                              snapshot.data!.recovered.toString(),
                            ),
                            "Deaths": double.parse(
                              snapshot.data!.deaths.toString(),
                            ),
                          },
                          colorList: [Colors.blue, Colors.green, Colors.red],
                          animationDuration: Duration(milliseconds: 1000),
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .08,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.white24,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ReusableWidget(
                                    value: snapshot.data!.cases.toString(),
                                    title: "Total Cases",
                                  ),
                                  ReusableWidget(
                                    value: snapshot.data!.deaths.toString(),
                                    title: "Total Deaths",
                                  ),
                                  ReusableWidget(
                                    value: snapshot.data!.recovered.toString(),
                                    title: "Total Recovered",
                                  ),
                                  ReusableWidget(
                                    value: snapshot.data!.active.toString(),
                                    title: "Total Active",
                                  ),
                                  ReusableWidget(
                                    value: snapshot.data!.critical.toString(),
                                    title: "Total Critical",
                                  ),
                                  ReusableWidget(
                                    value: snapshot.data!.todayCases.toString(),
                                    title: "Today Cases",
                                  ),
                                  ReusableWidget(
                                    value: snapshot.data!.todayRecovered
                                        .toString(),
                                    title: "Today Recovered",
                                  ),
                                  ReusableWidget(
                                    value: snapshot.data!.todayDeaths
                                        .toString(),
                                    title: "Today Deaths",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .08,
                        ),
                        GestureDetector(
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green,
                            ),
                            child: Center(child: Text("Track Countries")),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountryDetailList(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title;
  final String value;

  const ReusableWidget({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(color: Colors.white, fontSize: 15)),
              Text(value, style: TextStyle(color: Colors.white, fontSize: 15)),
            ],
          ),
          Divider(color: Colors.white10),
        ],
      ),
    );
  }
}
