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
  //tambahan
  late HttpUpdateSurveyDetails updateService;
  //
  List<SurveyDetails> surveyDetails = [];

  //tambahan
  final _genreController = TextEditingController();
  final _reportsController = TextEditingController();
  final _ageController = TextEditingController();
  final _gpaController = TextEditingController();
  final _yearController = TextEditingController();
  final _genderController = TextEditingController();
  final _nationalityController = TextEditingController();
  //
  int currentPage = 1;
  int totalPages = 1;
  int surveyDetailsPerPage = 20;

  bool isLoading = true;

  @override
  void initState() {
    service = HttpSurveyDetails();
    //tambahan
    updateService = HttpUpdateSurveyDetails();
    //
    super.initState();
    fetchData();
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
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: surveyDetails.length,
                  //     itemBuilder: (context, index) {
                  //       final survey = surveyDetails[index];
                  //       return Card(
                  //         color: Colors.white,
                  //         elevation: 2.0,
                  //         child: ListTile(
                  //           leading: const CircleAvatar(
                  //             backgroundColor: Colors.blue,
                  //             child: Icon(
                  //               Icons.person,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           title: Text(
                  //             "Respondent ID : ${survey.id}",
                  //             style: const TextStyle(
                  //               fontSize: 20.0,
                  //               fontWeight: FontWeight.w600,
                  //             ),
                  //           ),
                  //           subtitle: Row(
                  //             children: [
                  //               Text(survey.gender == 'M' ? 'Male' : 'Female'),
                  //               const Text(' | '),
                  //               Text('${survey.age} y.o.'),
                  //               const Text(' | '),
                  //               Text('Year ${survey.year}'),
                  //             ],
                  //           ),
                  //           trailing: Container(
                  //             decoration: BoxDecoration(
                  //               border: Border.all(
                  //                 color: Colors.black,
                  //                 width: 1,
                  //               ),
                  //             ),
                  //             child: CountryFlag.fromCountryCode(
                  //               getCountryCode(survey.nationality),
                  //               height: 38,
                  //               width: 50,
                  //             ),
                  //           ),
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
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  //
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: surveyDetails.length,
                  //     itemBuilder: (context, index) {
                  //       final survey = surveyDetails[index];
                  //       return Card(
                  //         color: Colors.white,
                  //         elevation: 2.0,
                  //         child: ListTile(
                  //           leading: const CircleAvatar(
                  //             backgroundColor: Colors.blue,
                  //             child: Icon(
                  //               Icons.person,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           title: Text(
                  //             "Respondent ID : ${survey.id}",
                  //             style: const TextStyle(
                  //               fontSize: 20.0,
                  //               fontWeight: FontWeight.w600,
                  //             ),
                  //           ),
                  //           subtitle: Row(
                  //             children: [
                  //               Text(survey.gender == 'M' ? 'Male' : 'Female'),
                  //               const Text(' | '),
                  //               Text('${survey.age} y.o.'),
                  //               const Text(' | '),
                  //               Text('Year ${survey.year}'),
                  //             ],
                  //           ),
                  //           trailing: Row(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               IconButton(
                  //                 icon: Icon(Icons.edit),
                  // onPressed: () {
                  //   _genreController.text = survey.genre;
                  //   _reportsController.text = survey.reports;
                  //   _ageController.text = survey.age.toString();
                  //   _gpaController.text = survey.gpa;
                  //   _yearController.text =
                  //       survey.year.toString();
                  //   _genderController.text = survey.gender;
                  //   _nationalityController.text =
                  //       survey.nationality;
                  //   showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //         title: Text('Edit Survey Details'),
                  //         content: SingleChildScrollView(
                  //           child: ListBody(
                  //             children: <Widget>[
                  //               TextField(
                  //                 controller: _genreController,
                  //                 decoration:
                  //                     const InputDecoration(
                  //                         labelText: 'Genre'),
                  //               ),
                  //               TextField(
                  //                 controller:
                  //                     _reportsController,
                  //                 decoration:
                  //                     const InputDecoration(
                  //                         labelText: 'Reports'),
                  //               ),
                  //               TextField(
                  //                 controller: _ageController,
                  //                 decoration:
                  //                     const InputDecoration(
                  //                         labelText: 'Age'),
                  //               ),
                  //               TextField(
                  //                 controller: _gpaController,
                  //                 decoration:
                  //                     const InputDecoration(
                  //                         labelText: 'GPA'),
                  //               ),
                  //               TextField(
                  //                 controller: _yearController,
                  //                 decoration:
                  //                     const InputDecoration(
                  //                         labelText: 'Year'),
                  //               ),
                  //               TextField(
                  //                 controller: _genderController,
                  //                 decoration:
                  //                     const InputDecoration(
                  //                         labelText: 'Gender'),
                  //               ),
                  //               TextField(
                  //                 controller:
                  //                     _nationalityController,
                  //                 decoration:
                  //                     const InputDecoration(
                  //                         labelText:
                  //                             'Nationality'),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         actions: <Widget>[
                  //           TextButton(
                  //             child: const Text('Save'),
                  //             onPressed: () async {
                  //               bool success =
                  //                   await updateService
                  //                       .updateSurveyDetails(
                  //                 survey.id,
                  //                 _genreController.text,
                  //                 _reportsController.text,
                  //                 int.parse(
                  //                     _ageController.text),
                  //                 _gpaController.text,
                  //                 int.parse(
                  //                     _yearController.text),
                  //                 _genderController.text,
                  //                 _nationalityController.text,
                  //               );
                  //               if (success) {
                  //                 setState(() {
                  //                   int index = surveyDetails
                  //                       .indexOf(survey);
                  //                   surveyDetails[index] =
                  //                       survey.copyWith(
                  //                     genre:
                  //                         _genreController.text,
                  //                     reports:
                  //                         _reportsController
                  //                             .text,
                  //                     age: int.parse(
                  //                         _ageController.text),
                  //                     gpa: _gpaController.text,
                  //                     year: int.parse(
                  //                         _yearController.text),
                  //                     gender: _genderController
                  //                         .text,
                  //                     nationality:
                  //                         _nationalityController
                  //                             .text,
                  //                   );
                  //                 });
                  //               }
                  //               Navigator.of(context).pop();
                  //             },
                  //           ),
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
                  //               ),
                  //               Container(
                  //                 decoration: BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.black,
                  //                     width: 1,
                  //                   ),
                  //                 ),
                  //                 child: CountryFlag.fromCountryCode(
                  //                   getCountryCode(survey.nationality),
                  //                   height: 38,
                  //                   width: 50,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  //
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
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _genreController.text = survey.genre;
                                    _reportsController.text = survey.reports;
                                    _ageController.text = survey.age.toString();
                                    _gpaController.text = survey.gpa;
                                    _yearController.text =
                                        survey.year.toString();
                                    _genderController.text = survey.gender;
                                    _nationalityController.text =
                                        survey.nationality;
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:
                                              const Text('Edit Survey Details'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                TextField(
                                                  controller: _genreController,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText: 'Genre'),
                                                ),
                                                TextField(
                                                  controller:
                                                      _reportsController,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText: 'Reports'),
                                                ),
                                                TextField(
                                                  controller: _ageController,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText: 'Age'),
                                                ),
                                                TextField(
                                                  controller: _gpaController,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText: 'GPA'),
                                                ),
                                                TextField(
                                                  controller: _yearController,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText: 'Year'),
                                                ),
                                                TextField(
                                                  controller: _genderController,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText: 'Gender'),
                                                ),
                                                TextField(
                                                  controller:
                                                      _nationalityController,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText:
                                                              'Nationality'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Save'),
                                              onPressed: () async {
                                                bool success =
                                                    await updateService
                                                        .updateSurveyDetails(
                                                  survey.id,
                                                  _genreController.text,
                                                  _reportsController.text,
                                                  int.parse(
                                                      _ageController.text),
                                                  _gpaController.text,
                                                  int.parse(
                                                      _yearController.text),
                                                  _genderController.text,
                                                  _nationalityController.text,
                                                );
                                                if (success) {
                                                  setState(() {
                                                    int index = surveyDetails
                                                        .indexOf(survey);
                                                    surveyDetails[index] =
                                                        survey.copyWith(
                                                      genre:
                                                          _genreController.text,
                                                      reports:
                                                          _reportsController
                                                              .text,
                                                      age: int.parse(
                                                          _ageController.text),
                                                      gpa: _gpaController.text,
                                                      year: int.parse(
                                                          _yearController.text),
                                                      gender: _genderController
                                                          .text,
                                                      nationality:
                                                          _nationalityController
                                                              .text,
                                                    );
                                                  });
                                                }
                                                Navigator.of(context).pop();
                                              },
                                            ),
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
                                Container(
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
                              ],
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
