import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';

import 'package:flutter_survey_dashboard/services/service.dart';
import 'package:flutter_survey_dashboard/models/survey_detail.dart';

import 'package:flutter_survey_dashboard/components/nationality_dropdown.dart';
import 'package:flutter_survey_dashboard/components/genre_dropdown.dart';
import 'package:flutter_survey_dashboard/components/gender_dropdown.dart';

class Listpage extends StatefulWidget {
  const Listpage({super.key});

  @override
  State<Listpage> createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  late HttpSurveyDetails service1;
  late HttpNationalityRespondents service2;
  late HttpGenreRespondents service3;
  late HttpGenderRespondents service4;

  List<SurveyDetails> surveyDetails = [];
  List<String> nationalities = [];
  List<String> genres = [];
  List<String> genders = [];

  int currentPage = 1;
  int totalPages = 1;
  int surveyDetailsPerPage = 20;

  bool isLoading = true;

  final reportsController = TextEditingController();
  final ageController = TextEditingController();
  final gpaController = TextEditingController();
  final nationalityController = TextEditingController();
  final genreController = TextEditingController();
  final genderController = TextEditingController();

  @override
  void initState() {
    service1 = HttpSurveyDetails();
    service2 = HttpNationalityRespondents();
    service3 = HttpGenreRespondents();
    service4 = HttpGenderRespondents();
    super.initState();
    fetchData();
    fetchDropDown();
  }

  Future<void> fetchData() async {
    try {
      final data =
          await service1.getSurveyDetails(currentPage, surveyDetailsPerPage);
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
      final data = await service1.getSurveyDetails(page, surveyDetailsPerPage);
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

  Future<void> fetchDropDown() async {
    try {
      setState(() {
        isLoading = true;
      });
      final genreRespondents = await service3.getGenreRespondents();
      final genderRespondents = await service4.getGenderRespondents();
      final nationalityRespondents = await service2.getNationalityRespondents();
      setState(() {
        genres = genreRespondents.map((gr) => gr.genre).toList();
        genders = genderRespondents.map((gdr) => gdr.gender).toList();
        nationalities =
            nationalityRespondents.map((nr) => nr.nationality).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
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
                        return Dismissible(
                          key: Key(survey.id.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            try {
                              HttpSurveyDetails().deleteRespondent(survey.id);
                              // Hapus item dari daftar Anda
                              setState(() {
                                surveyDetails.removeAt(index);
                              });
                            } catch (e) {
                              // Tampilkan pesan kesalahan jika gagal menghapus responden
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Failed to delete respondent')),
                              );
                            }
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20.0),
                            color: Colors.red,
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          child: Card(
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
                                  Text(
                                      survey.gender == 'M' ? 'Male' : 'Female'),
                                  const Text(' | '),
                                  Text('${survey.age} y.o.'),
                                  const Text(' | '),
                                  Text('Year ${survey.year}'),
                                ],
                              ),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          reportsController.text =
                                              survey.reports;
                                          ageController.text =
                                              survey.age.toString();
                                          gpaController.text =
                                              survey.gpa.toString();
                                          nationalityController.text =
                                              survey.nationality;
                                          genreController.text = survey.genre;
                                          genderController.text = survey.gender;

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Edit Respondent'),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      TextFormField(
                                                        controller:
                                                            reportsController,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: 'Reports',
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            ageController,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: 'Age',
                                                        ),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            gpaController,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: 'Gpa',
                                                        ),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                      ),
                                                      GenreDropdown(
                                                        genres: genres,
                                                        initialValue:
                                                            survey.genre,
                                                        onChanged: (newValue) {
                                                          genreController.text =
                                                              newValue;
                                                        },
                                                      ),
                                                      NationalityDropdown(
                                                        nationalities:
                                                            nationalities,
                                                        initialValue:
                                                            survey.nationality,
                                                        onChanged: (newValue) {
                                                          nationalityController
                                                              .text = newValue;
                                                        },
                                                      ),
                                                      GenderDropdown(
                                                        genders: genders,
                                                        initialValue:
                                                            survey.gender,
                                                        onChanged: (newValue) {
                                                          genderController
                                                              .text = newValue;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text('Save'),
                                                    onPressed: () {
                                                      final localContext =
                                                          context;
                                                      try {
                                                        service1
                                                            .updateRespondent(
                                                              survey.id,
                                                              {
                                                                'Reports':
                                                                    reportsController
                                                                        .text,
                                                                'Age':
                                                                    ageController
                                                                        .text,
                                                                'Gpa':
                                                                    gpaController
                                                                        .text,
                                                                'Genre':
                                                                    genreController
                                                                        .text,
                                                                'Nationality':
                                                                    nationalityController
                                                                        .text,
                                                                'Gender':
                                                                    genderController
                                                                        .text,
                                                              },
                                                            )
                                                            .then((_) =>
                                                                fetchSurveyDetails(
                                                                    currentPage))
                                                            .then((_) =>
                                                                Navigator.of(
                                                                        localContext)
                                                                    .pop())
                                                            .catchError((e) {
                                                              // Handle the error
                                                            });
                                                      } catch (e) {
                                                        // Handle the error
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }),
                                    Expanded(
                                      child: Container(
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
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Genre: ${survey.genre}'),
                                      content:
                                          Text('Reports: ${survey.reports}'),
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
