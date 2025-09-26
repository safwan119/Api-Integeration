import 'package:api_integeration/View/world_screen.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String image, name;
  final int active,
      totalCases,
      totalRecovered,
      totalDeaths,
      todayCases,
      todayRecovered,
      todayDeath;

  const DetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.active,
    required this.todayCases,
    required this.todayRecovered,
    required this.todayDeath,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            Text(widget.name, style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.white12,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .06),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .06,
                ),
                child: Card(
                  elevation: 4,
                  color: Colors.white12,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      ReusableWidget(
                        value: widget.totalCases.toString(),
                        title: "totalCases",
                      ),
                      ReusableWidget(
                        value: widget.totalRecovered.toString(),
                        title: "totalRecovered",
                      ),
                      ReusableWidget(
                        value: widget.totalDeaths.toString(),
                        title: "totalDeaths",
                      ),
                      ReusableWidget(
                        value: widget.active.toString(),
                        title: "totalActive",
                      ),
                      ReusableWidget(
                        value: widget.todayCases.toString(),
                        title: "todayCases",
                      ),
                      ReusableWidget(
                        value: widget.todayRecovered.toString(),
                        title: "todayRecovered",
                      ),
                      ReusableWidget(
                        value: widget.todayDeath.toString(),
                        title: "todayDeaths",
                      ),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
