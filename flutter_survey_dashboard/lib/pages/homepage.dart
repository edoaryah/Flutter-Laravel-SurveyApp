import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';

import 'package:flutter_survey_dashboard/services/service.dart';
import 'package:flutter_survey_dashboard/models/gender.dart';
import 'package:flutter_survey_dashboard/models/genre.dart';
import 'package:flutter_survey_dashboard/models/nationality.dart';
import 'package:flutter_survey_dashboard/charts/bar_chart1/bar_data.dart';
import 'package:flutter_survey_dashboard/charts/bar_chart1/bar_graph.dart';
import 'package:flutter_survey_dashboard/charts/bar_chart2/bar_data.dart';
import 'package:flutter_survey_dashboard/charts/bar_chart2/bar_graph.dart';
import 'package:flutter_survey_dashboard/charts/pie_chart/my_pie_chart.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late HttpTotalRespondents serviceTotalRespondents;
  late HttpGenreRespondents serviceGenreRespondents;
  late HttpNationalityRespondents serviceNationalityRespondents;
  late HttpAverageAgeRespondents serviceAverageAgeRespondents;
  late HttpAverageGpaRespondents serviceAverageGpaRespondents;
  late HttpGenderRespondents serviceGenderRespondents;

  int? total;
  double? age;
  double? gpa;
  List<GenreRespondents>? genreRespondents;
  List<NationalityRespondents>? nationalityRespondents;
  List<GenderRespondents>? genderRespondents;

  bool isLoading = true;
  String? error;

  _HomepageState();
  @override
  void initState() {
    super.initState();
    serviceTotalRespondents = HttpTotalRespondents();
    serviceGenreRespondents = HttpGenreRespondents();
    serviceNationalityRespondents = HttpNationalityRespondents();
    serviceAverageAgeRespondents = HttpAverageAgeRespondents();
    serviceAverageGpaRespondents = HttpAverageGpaRespondents();
    serviceGenderRespondents = HttpGenderRespondents();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final result = await serviceTotalRespondents.getTotalRespondents();
      final genreResult = await serviceGenreRespondents.getGenreRespondents();
      final nationalityResult =
          await serviceNationalityRespondents.getNationalityRespondents();
      final averageAgeResult =
          await serviceAverageAgeRespondents.getAverageAgeRespondents();
      final averageGpaResult =
          await serviceAverageGpaRespondents.getAverageGpaRespondents();
      final genderResult =
          await serviceGenderRespondents.getGenderRespondents();
      setState(() {
        total = result.total;
        genreRespondents = genreResult;
        nationalityRespondents = nationalityResult;
        age = averageAgeResult.age;
        gpa = averageGpaResult.gpa;
        genderRespondents = genderResult;
        isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
            : ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
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
                            Text(
                              'Total Respondents : ${error ?? total}',
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
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Respondent Summary',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (genderRespondents != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: Card(
                        shadowColor: Colors.black,
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: MyPieChart(
                                  genderRespondents: genderRespondents!,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: genderRespondents!
                                      .map((item) => Row(
                                            children: [
                                              Container(
                                                width: 16,
                                                height: 16,
                                                color: item.gender == 'M'
                                                    ? Colors.blueAccent
                                                    : Colors.pinkAccent,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                '${item.count} ${item.gender == 'M' ? 'Male' : 'Female'}',
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Card(
                              shadowColor: Colors.black,
                              elevation: 4.0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Average",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${error ?? age}',
                                      style: const TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      "Years Old",
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
                              shadowColor: Colors.black,
                              elevation: 4.0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Average",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${error ?? gpa}',
                                      style: const TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      "GPA",
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
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Nationalities',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shadowColor: Colors.black,
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: SizedBox(
                          height: 250,
                          child: nationalityRespondents != null && total != null
                              ? MyBarGraph(
                                  countryData: nationalityRespondents!
                                      .map((item) => CountryPopulation(
                                          nationality: item.nationality,
                                          count: item.count.toDouble()))
                                      .toList(),
                                  totalRespondents: total!,
                                )
                              : const CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ...(nationalityRespondents ?? []).map((item) {
                        final countryCode = getCountryCode(item.nationality);
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Card(
                            shadowColor: Colors.black,
                            elevation: 4.0,
                            color: Colors.white,
                            child: ListTile(
                              title: Text(
                                "${item.count.toStringAsFixed(0)} Respondents from ${item.nationality}",
                                style: const TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: CountryFlag.fromCountryCode(
                                  countryCode,
                                  height: 30,
                                  width: 40,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Problem Genres',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shadowColor: Colors.black,
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: SizedBox(
                          height: 250,
                          child: nationalityRespondents != null && total != null
                              ? MyBarGraph2(
                                  genreData: genreRespondents!
                                      .map((item) => GenreTotal(
                                          genre: item.genre,
                                          count: item.count.toDouble()))
                                      .toList(),
                                  totalRespondents: total!,
                                )
                              : const CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                  if (genreRespondents != null)
                    ...genreRespondents!
                        .map((item) => Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Card(
                                shadowColor: Colors.black,
                                elevation: 4.0,
                                color: Colors.white,
                                child: ListTile(
                                  title: Text(
                                    item.genre,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                          '${item.count.toString()} Respondents')
                                    ],
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
