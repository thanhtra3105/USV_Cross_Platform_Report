import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:usv_project/widgets/historyChart.dart';
import 'package:usv_project/widgets/dashboardCard.dart';
import 'package:usv_project/widgets/speedCard.dart';
import 'package:usv_project/widgets/batteryCard.dart';
import 'dart:async';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<FlSpot> phHistory = [];
  List<FlSpot> doHistory = [];
  List<FlSpot> codHistory = [];
  List<FlSpot> tssHistory = [];

  int timeIndex = 0;
  @override
  void reassemble() {
    super.reassemble();
  }

  Future<Map<String, String>> fetchUSVData() async {
    await Future.delayed(Duration(seconds: 4));
    if (Random().nextBool()) throw Exception("Only error for all data");
    return {
      "Battery": Random().nextInt(100).toString(),
      "Heading": (Random().nextDouble() * 7 + 5).toStringAsFixed(2),
      "pH": (Random().nextDouble() * 7 + 5).toStringAsFixed(2),
      "DO": (Random().nextDouble() * 7 + 5).toStringAsFixed(2),
      "COD": (Random().nextDouble() * 7 + 5).toStringAsFixed(2),
      "TSS": (Random().nextDouble() * 7 + 5).toStringAsFixed(2),
    };
  }

  Future<double> fetchBattery() async {
    await Future.delayed(Duration(seconds: 2));
    return Random().nextInt(20) + 80;
  }

  Future<double> fetchSpeed() async {
    await Future.delayed(Duration(seconds: 2));
    return double.parse((Random().nextDouble() * 6 + 5).toStringAsFixed(2));
  }

  Future<double> fetchPH() async {
    await Future.delayed(Duration(seconds: 2));
    return double.parse((Random().nextDouble() * 5 + 5).toStringAsFixed(2));
  }

  Future<double> fetchDO() async {
    await Future.delayed(Duration(seconds: 3));
    if (Random().nextBool()) throw Exception("fetch DO data failed");
    return double.parse((Random().nextDouble() * 5 + 5).toStringAsFixed(2));
  }

  Future<double> fetchCOD() async {
    await Future.delayed(Duration(seconds: 1));
    return double.parse((Random().nextDouble() * 5 + 5).toStringAsFixed(2));
  }

  Future<double> fetchTSS() async {
    await Future.delayed(Duration(seconds: 4));
    return double.parse((Random().nextDouble() * 5 + 5).toStringAsFixed(2));
  }

  Future<Map<String, double>> fetchAll() async {
    try {
      final results = await Future.wait([
        fetchBattery(),
        fetchSpeed(),
        fetchPH(),
        fetchDO(),
        fetchCOD(),
        fetchTSS().timeout(
          Duration(seconds: Random().nextInt(3) + 3),
          onTimeout: () => throw Exception("TSS Timeout"),
        ),
      ]);
      return {
        "Battery": results[0],
        "Speed": results[1],
        "pH": results[2],
        "DO": results[3],
        "COD": results[4],
        "TSS": results[5],
      };
    } catch (e) {
      throw e;
    }
  }

  late Future<Map<String, double>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchAll(); // fetch 1 time
    Timer.periodic(Duration(seconds: 3), (timer) async {
      try {
        final data = await fetchAll(); // lay gia tri moi de cao nhat chart
        final now = DateTime.now().millisecondsSinceEpoch;
        setState(() {
          phHistory.add(FlSpot(timeIndex.toDouble(), data["pH"]!));
          doHistory.add(FlSpot(timeIndex.toDouble(), data["DO"]!));
          codHistory.add(FlSpot(timeIndex.toDouble(), data["COD"]!));
          tssHistory.add(FlSpot(timeIndex.toDouble(), data["TSS"]!));
          timeIndex++;
          futureData = Future.value(data);
        });
      } catch (e) {
        setState(() {
          futureData = Future.error(e);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "USV Status & Water Quality",
              style: TextStyle(
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 20),

            /* dung future.wait()*/
            Container(
              height: 420,
              width: 500,
              child: FutureBuilder(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text("Loading..."),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(snapshot.error.toString()),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => setState(() {
                              // reassemble();
                              futureData = fetchAll();
                            }),
                            child: Text("Retry"),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!;

                    return Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1.0,
                            children: [
                              Batterycard(value: data["Battery"] ?? 0),
                              SpeedGauge(speed: data["Speed"] ?? 0),
                            ],
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 4,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                            childAspectRatio: 0.8,
                            children: [
                              buildDashboardCard(
                                "pH",
                                "${data["pH"]}",
                                "mol/L",
                                Icons.science,
                              ),
                              buildDashboardCard(
                                "DO",
                                "${data["DO"]}",
                                "mg/L",
                                Icons.opacity,
                              ),
                              buildDashboardCard(
                                "COD",
                                "${data["COD"]}",
                                "mg/L",
                                Icons.waves,
                              ),
                              buildDashboardCard(
                                "TSS",
                                "${data["TSS"]}",
                                "mg/L",
                                Icons.analytics,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Text("Khong co data");
                  }
                },
              ),
            ),

            // SizedBox(height: 20),
            Container(
              height: 350,
              width: 500,
              child: HistoryChart(
                title: "Water Quality History",
                dataSets: {
                  "pH": phHistory,
                  "COD": codHistory,
                  "DO": doHistory,
                  "TSS": tssHistory,
                },
                colors: {
                  "pH": Colors.green,
                  "COD": Colors.orange,
                  "DO": Colors.red,
                  "TSS": Colors.purple,
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
