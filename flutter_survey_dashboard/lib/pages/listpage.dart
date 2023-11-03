import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_survey_dashboard/pages/homepage.dart';

class Listpage extends StatefulWidget {
  const Listpage({super.key});

  @override
  State<Listpage> createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  late HttpSurveyDetails service;
  bool isLoading = true;
  List<SurveyDetails> surveyDetails = [];
  int currentPage = 1;
  int totalPages = 1;
  int surveyDetailsPerPage = 20;

  @override
  void initState() {
    service = HttpSurveyDetails();
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data =
          await service.getSurveyDetails(currentPage, surveyDetailsPerPage);
      if (data != null) {
        setState(() {
          surveyDetails = data['items'];
          totalPages = data['lastPage'];
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchSurveyDetails(int page) async {
    try {
      setState(() {
        isLoading = true;
      });
      final data = await service.getSurveyDetails(page, surveyDetailsPerPage);
      if (data != null) {
        setState(() {
          surveyDetails = data['items'];
          totalPages = data['lastPage'];
          currentPage = page;
          isLoading = false;
        });
      } else {
        print("Data is null.");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
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
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: currentPage > 1
                            ? () {
                                setState(() {
                                  currentPage--;
                                  fetchSurveyDetails(currentPage);
                                  isLoading = true;
                                });
                              }
                            : null,
                        child: const Text("Previous Page"),
                      ),
                      Text("Page $currentPage of $totalPages"),
                      ElevatedButton(
                        onPressed: currentPage < totalPages
                            ? () {
                                setState(() {
                                  currentPage++;
                                  fetchSurveyDetails(currentPage);
                                  isLoading = true;
                                });
                              }
                            : null,
                        child: const Text("Next Page"),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: surveyDetails.length,
                      itemBuilder: (context, index) {
                        final survey = surveyDetails[index];
                        return Card(
                          color: Colors.white,
                          elevation: 2.0,
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              "Respondent ID : ${survey.id}",
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(survey.gender == 'M' ? 'Male' : 'Female'),
                                const Text(' | '),
                                Text('${survey.age} y.o.'),
                                const Text(' | '),
                                Text('Tingkat ${survey.year}'),
                              ],
                            ),
                            trailing: CountryFlag.fromCountryCode(
                              getCountryCode(survey.nationality),
                              height: 48,
                              width: 40,
                              borderRadius: 8,
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Genre: ${survey.genre}'),
                                    content: Text('Reports: ${survey.reports}'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class SurveyDetails {
  final int id;
  final String genre;
  final String reports;
  final int age;
  final String gpa;
  final int year;
  final String gender;
  final String nationality;

  SurveyDetails({
    required this.id,
    required this.genre,
    required this.reports,
    required this.age,
    required this.gpa,
    required this.year,
    required this.gender,
    required this.nationality,
  });

  factory SurveyDetails.fromJson(Map<String, dynamic> parsedJson) {
    return SurveyDetails(
      id: parsedJson['id'] as int,
      genre: parsedJson['Genre'] as String,
      reports: parsedJson['Reports'] as String,
      age: parsedJson['Age'] as int,
      gpa: parsedJson['Gpa'] as String,
      year: parsedJson['Year'] as int,
      gender: parsedJson['Gender'] as String,
      nationality: parsedJson['Nationality'] as String,
    );
  }
}

class HttpSurveyDetails {
  Future<Map<String, dynamic>> getSurveyDetails(int page, int perPage) async {
    var response = await http
        .get(Uri.parse('$urlSurveyDetails?page=$page&perPage=$perPage'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data['data']
          .map<SurveyDetails>((item) => SurveyDetails.fromJson(item))
          .toList();

      return {
        'items': items,
        'total': data['total'],
        'perPage': data['per_page'],
        'currentPage': data['current_page'],
        'lastPage': data['last_page'],
      };
    } else {
      throw Exception('Failed to load survey details');
    }
  }
}
