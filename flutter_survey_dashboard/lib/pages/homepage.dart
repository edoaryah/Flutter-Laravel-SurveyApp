import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:country_flags/country_flags.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter_survey_dashboard/charts/bar_chart1/bar_data.dart';
import 'package:flutter_survey_dashboard/charts/bar_chart1/bar_graph.dart';
import 'package:flutter_survey_dashboard/charts/bar_chart2/bar_data.dart';
import 'package:flutter_survey_dashboard/charts/bar_chart2/bar_graph.dart';

String urlDomain = 'http://192.168.1.15:8000/';
String urlTotalRespondents = urlDomain + 'api/total-respondents';
String urlRespondentsByGender = urlDomain + 'api/respondents-by-gender';
String urlAverageAge = urlDomain + 'api/average-age';
String urlAverageGpa = urlDomain + 'api/average-gpa';
String urlRespondentsByGenre = urlDomain + 'api/respondents-by-genre';
String urlRespondentsByNationality =
    urlDomain + 'api/respondents-by-nationality';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<CountryPopulation> countryData = [];
  List<GenreTotal> genreData = [];
  String total = '-';
  String maleCount = '-';
  String femaleCount = '-';
  String age = '0';
  String gpa = '0';

  String? error;
  List? data;
  List? country;

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchData2();
    fetchData3();
    fetchData4();
    fetchData5();
    fetchData6();
    fetchData7().then((data) {
      setState(() {
        countryData = data;
      });
    });
    fetchData8().then((data) {
      setState(() {
        genreData = data;
      });
    });
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(urlTotalRespondents));

      if (response.statusCode == 200) {
        setState(() {
          total = response.body;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  Future<void> fetchData2() async {
    try {
      final response = await http.get(Uri.parse(urlRespondentsByGender));

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');

        var data = json.decode(response.body);
        for (var item in data) {
          if (item['Gender'] == 'M') {
            setState(() {
              maleCount = item['count'].toString();
            });
          } else if (item['Gender'] == 'F') {
            setState(() {
              femaleCount = item['count'].toString();
            });
          }
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  Future<void> fetchData3() async {
    try {
      final response = await http.get(Uri.parse(urlAverageAge));

      if (response.statusCode == 200) {
        setState(() {
          age = response.body;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  Future<void> fetchData4() async {
    try {
      final response = await http.get(Uri.parse(urlAverageGpa));

      if (response.statusCode == 200) {
        setState(() {
          gpa = response.body;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  Future<void> fetchData5() async {
    try {
      final response = await http.get(Uri.parse(urlRespondentsByGenre));

      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData is List) {
          setState(() {
            data = responseData;
          });
        } else {
          throw Exception('Failed to parse response data');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  Future<void> fetchData6() async {
    try {
      final response = await http.get(Uri.parse(urlRespondentsByNationality));

      if (response.statusCode == 200) {
        setState(() {
          country = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  Future<List<CountryPopulation>> fetchData7() async {
    try {
      final response = await http.get(Uri.parse(urlRespondentsByNationality));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        final countryData = data
            .map((item) => CountryPopulation(
                nationality: item['Nationality'],
                count: double.parse(item['count'].toString())))
            .toList();
        return countryData;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<GenreTotal>> fetchData8() async {
    try {
      final response = await http.get(Uri.parse(urlRespondentsByGenre));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        final genreData = data
            .map((item) => GenreTotal(
                nationality: item['Genre'],
                count: double.parse(item['count'].toString())))
            .toList();
        return genreData;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String getCountryCode(String countryName) {
    switch (countryName) {
      case 'Indonesia':
        return 'ID';
      case 'Soudan':
        return 'SD';
      case 'France':
        return 'FR';
      case 'Mexico':
        return 'MX';
      case 'South Africa':
        return 'ZA';
      case 'Yemen':
        return 'YE';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(16.0),
              color: const Color.fromARGB(255, 205, 0, 0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.group,
                      size: 72,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "${error ?? total}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.3,
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                value: double.tryParse(maleCount) ?? 0.0,
                                color: const Color(0xff0293ee),
                                title:
                                    '${((double.tryParse(maleCount) ?? 0.0) / ((double.tryParse(maleCount) ?? 0.0) + (double.tryParse(femaleCount) ?? 0.0)) * 100).toStringAsFixed(2)}%',
                                radius: 75,
                              ),
                              PieChartSectionData(
                                value: double.tryParse(femaleCount) ?? 0.0,
                                color: const Color(0xfff8b250),
                                title:
                                    '${((double.tryParse(femaleCount) ?? 0.0) / ((double.tryParse(maleCount) ?? 0.0) + (double.tryParse(femaleCount) ?? 0.0)) * 100).toStringAsFixed(2)}%',
                                radius: 75,
                              ),
                            ],
                            sectionsSpace: 0,
                            centerSpaceRadius: 0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: const Color(0xff0293ee),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${(double.tryParse(maleCount) ?? 0).round()} Male',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: const Color(0xfff8b250),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${(double.tryParse(femaleCount) ?? 0).round()} Female',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: SizedBox(
                height: 25,
                child: Text(
                  "Rata-Rata Responden",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Umur",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${error ?? age}",
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              "Tahun",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Nilai",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${error ?? gpa}",
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              "IPK / GPA",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 21.0, bottom: 16.0),
              child: SizedBox(
                height: 25,
                child: Text(
                  "Jumlah Responden Tiap Negara",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 220),
            Center(
              child: SizedBox(
                height: 70,
                child: MyBarGraph(
                  countryData: countryData,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ...?country?.map((item) {
                  final countryCode = getCountryCode(item['Nationality']);
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: Text(
                          "${item['count']} Respondents",
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: CountryFlag.fromCountryCode(
                          countryCode,
                          height: 48,
                          width: 40,
                          borderRadius: 8,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 20),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(21.0),
              child: SizedBox(
                height: 20,
                child: Text(
                  "Faktor Permasalahan",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.only(left: 17, right: 17),
              child: Center(
                child: SizedBox(
                  height: 100,
                  child: MyBarGraph2(
                    genreData: genreData,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...?data
                ?.map((item) => Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 2.0,
                        child: ListTile(
                          title: Text(
                            "${item['Genre']}",
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Row(
                            children: [Text('${item['count']} Responden')],
                          ),
                        ),
                      ),
                    ))
                .toList(),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Copyright © 2023 Kelompok3. All Rights Reserved",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
