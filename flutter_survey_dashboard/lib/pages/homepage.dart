// import 'package:country_code_picker/country_code_picker.dart';
// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, deprecated_member_use, sort_child_properties_last, prefer_interpolation_to_compose_strings
// import 'package:flutter_survey_dashboard/charts/pie_chart2.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_survey_dashboard/charts/pie_chart.dart';
import 'package:flutter_survey_dashboard/charts/pie_chart2.dart';
import 'package:flutter_survey_dashboard/charts/pie_chart3.dart';

String urlDomain = 'http://192.168.1.18:8000/';
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
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.group,
                      size: 72,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "${error ?? total}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
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
                      margin: EdgeInsets.only(top: 16, left: 16, bottom: 16),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.person,
                              size: 72,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "${error ?? maleCount}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Male",
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
                      margin: EdgeInsets.only(top: 16, left: 16, bottom: 16),
                      child: Padding(
                        padding: EdgeInsets.only(top: 16, left: 8, right: 8),
                        child: Column(
                          children: [
                            Icon(
                              Icons.pie_chart,
                              size: 80,
                              color: Colors.blue,
                            ),
                            SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PieChartPage(
                                      maleCount:
                                          double.tryParse(maleCount) ?? 0.0,
                                      femaleCount:
                                          double.tryParse(femaleCount) ?? 0.0,
                                    ),
                                  ),
                                );
                              },
                              child: Text('Pie Chart'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.only(
                          top: 16, left: 16, bottom: 16, right: 16),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.person_2,
                              size: 72,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "${error ?? femaleCount}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Female",
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
                      margin: EdgeInsets.all(16.0),
                      child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Umur",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${error ?? age}",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
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
                      margin: EdgeInsets.all(16.0),
                      child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nilai",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${error ?? gpa}",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
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
                          style: TextStyle(
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GenrePieChart(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width / 2 - 25,
                              45), // 20 adalah padding kiri dan kanan
                        ),
                      ),
                      child: Text('Genre Pie Chart'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NationalityPieChart(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width / 2 - 25,
                              45), // 20 adalah padding kiri dan kanan
                        ),
                      ),
                      child: Text('Nationality Pie Chart'),
                    ),
                  ],
                )
              ],
            ),
            Padding(
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
            ...?data
                ?.map((item) => Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 2.0,
                        child: ListTile(
                          title: Text(
                            "${item['Genre']}",
                            style: TextStyle(
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
            SizedBox(height: 20),
            Center(
              child: Text(
                "Copyright © 2023 Kelompok3. All Rights Reserved",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
