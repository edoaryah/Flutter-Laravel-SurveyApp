import 'package:flutter/material.dart';
import 'package:flutter_survey_dashboard/pages/homepage.dart';
import 'package:country_flags/country_flags.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String urlSurveyDetails = urlDomain + 'api/survey-details';

class Listpage extends StatefulWidget {
  const Listpage({super.key});

  @override
  State<Listpage> createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  late Future<List<Map<String, dynamic>>?> data;

  @override
  void initState() {
    super.initState();
    data = fetchData();
  }

  Future<List<Map<String, dynamic>>?> fetchData() async {
    final response = await http.get(
      Uri.parse(urlSurveyDetails),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
      },
    );

    // print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      try {
        final jsonBody = json.decode(response.body);
        if (jsonBody is List) {
          final List<Map<String, dynamic>> surveyDetails =
              jsonBody.cast<Map<String, dynamic>>();

          for (var survey in surveyDetails) {
            if (survey['Reports'] != null) {
              survey['Reports'] = cleanReportsText(survey['Reports']);
            }
          }

          return surveyDetails;
        } else {
          throw Exception('Invalid JSON format');
        }
      } catch (e) {
        // print('Error decoding JSON: $e');
        throw Exception('Failed to load data');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  String cleanReportsText(String text) {
    String cleanedText = text.replaceAll('"', '\"');
    cleanedText = cleanedText.replaceAll("'", "\'");
    return cleanedText;
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
        body: FutureBuilder<List<Map<String, dynamic>>?>(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${snapshot.error}'),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          data = fetchData();
                        });
                      },
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              final surveyDetails = snapshot.data!;
              return ListView.builder(
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
                        "Respondent ID : ${survey['id'] ?? ''}",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Text(survey['Gender'] == 'M' ? 'Male' : 'Female'),
                          const Text(' | '),
                          Text('${survey['Age'] ?? ''} y.o.'),
                          const Text(' | '),
                          Text('Tingkat ${survey['Year'] ?? ''}'),
                        ],
                      ),
                      trailing: CountryFlag.fromCountryCode(
                        getCountryCode(survey['Nationality'] ?? ''),
                        height: 48,
                        width: 40,
                        borderRadius: 8,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Genre: ${survey['Genre'] ?? ''}'),
                              content:
                                  Text('Reports: ${survey['Reports'] ?? ''}'),
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
              );
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }
}
