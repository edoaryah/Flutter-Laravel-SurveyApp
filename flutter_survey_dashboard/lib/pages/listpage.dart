import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';

import 'package:flutter_survey_dashboard/services/service.dart';
import 'package:flutter_survey_dashboard/models/survey_detail.dart';

class Listpage extends StatefulWidget {
  const Listpage({super.key});

  @override
  State<Listpage> createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  late HttpSurveyDetails service;
  late HttpNationalityRespondents service2;
  late HttpGenreRespondents service3;

  List<SurveyDetails> surveyDetails = [];
  List<String> nationalities = [];
  List<String> genres = [];

  int currentPage = 1;
  int totalPages = 1;
  int surveyDetailsPerPage = 20;

  bool isLoading = true;

  final reportsController = TextEditingController();
  final ageController = TextEditingController();
  final gpaController = TextEditingController();
  final nationalityController = TextEditingController();
  final genreController = TextEditingController();

  @override
  void initState() {
    service = HttpSurveyDetails();
    service2 = HttpNationalityRespondents();
    service3 = HttpGenreRespondents();
    super.initState();
    fetchData();
    fetchNationalities();
    fetchGenres();
  }

  Future<void> fetchData() async {
    try {
      final data =
          await service.getSurveyDetails(currentPage, surveyDetailsPerPage);
      setState(() {
        surveyDetails = data['items'];
        totalPages = data['lastPage'];
        isLoading = false;
      });
    } catch (e) {
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
      setState(() {
        surveyDetails = data['items'];
        totalPages = data['lastPage'];
        currentPage = page;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchNationalities() async {
    try {
      final nationalityRespondents = await service2.getNationalityRespondents();
      setState(() {
        nationalities =
            nationalityRespondents.map((nr) => nr.nationality).toList();
      });
    } catch (e) {
      // Handle the error
    }
  }

  Future<void> fetchGenres() async {
    try {
      final genreRespondents = await service3.getGenreRespondents();
      setState(() {
        genres = genreRespondents.map((gr) => gr.genre).toList();
      });
    } catch (e) {
      // Handle the error
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        child: const Text("  <<  "),
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
                        child: const Text("  >> "),
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
                                Text('Year ${survey.year}'),
                              ],
                            ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: CountryFlag.fromCountryCode(
                                getCountryCode(survey.nationality),
                                height: 38,
                                width: 50,
                              ),
                            ),
                            // onTap: () {
                            //   showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return AlertDialog(
                            //         title: Text('Genre: ${survey.genre}'),
                            //         content: Text('Reports: ${survey.reports}'),
                            //         actions: <Widget>[
                            //           TextButton(
                            //             child: const Text('Close'),
                            //             onPressed: () {
                            //               Navigator.of(context).pop();
                            //             },
                            //           ),
                            //         ],
                            //       );
                            //     },
                            //   );
                            // },
                            onTap: () {
                              reportsController.text = survey.reports;
                              ageController.text = survey.age.toString();
                              gpaController.text = survey.gpa.toString();
                              nationalityController.text =
                                  survey.nationality; // Set the initial value
                              genreController.text = survey.genre;

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Edit Respondent'),
                                    content: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          controller: reportsController,
                                          decoration: const InputDecoration(
                                              labelText: 'Reports'),
                                        ),
                                        TextFormField(
                                          controller: ageController,
                                          decoration: const InputDecoration(
                                              labelText: 'Age'),
                                          keyboardType: TextInputType.number,
                                        ),
                                        TextFormField(
                                          controller: gpaController,
                                          decoration: const InputDecoration(
                                              labelText: 'Gpa'),
                                          keyboardType: TextInputType.number,
                                        ),
                                        GenreDropdown(
                                          genres: genres,
                                          initialValue: survey.genre,
                                          onChanged: (newValue) {
                                            genreController.text = newValue;
                                          },
                                        ),
                                        NationalityDropdown(
                                          nationalities: nationalities,
                                          initialValue: survey.nationality,
                                          onChanged: (newValue) {
                                            nationalityController.text =
                                                newValue;
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Save'),
                                        onPressed: () async {
                                          try {
                                            await service.updateRespondent(
                                              survey.id,
                                              {
                                                'Reports':
                                                    reportsController.text,
                                                'Age': ageController.text,
                                                'Gpa': gpaController.text,
                                                'Genre': genreController.text,
                                                'Nationality':
                                                    nationalityController.text,
                                              },
                                            );
                                            await fetchSurveyDetails(
                                                currentPage);
                                            Navigator.of(context).pop();
                                          } catch (e) {
                                            // Handle the error
                                          }
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

class NationalityDropdown extends StatefulWidget {
  final List<String> nationalities;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const NationalityDropdown({
    super.key,
    required this.nationalities,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<NationalityDropdown> createState() {
    return _NationalityDropdownState();
  }
}

class _NationalityDropdownState extends State<NationalityDropdown> {
  late String currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: currentValue,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            currentValue = newValue;
          });
          widget.onChanged(newValue);
        }
      },
      items: widget.nationalities.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class GenreDropdown extends StatefulWidget {
  final List<String> genres;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const GenreDropdown({
    super.key,
    required this.genres,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<GenreDropdown> createState() {
    return _GenreDropdownState();
  }
}

class _GenreDropdownState extends State<GenreDropdown> {
  late String currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: currentValue,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            currentValue = newValue;
          });
          widget.onChanged(newValue);
        }
      },
      items: widget.genres.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
