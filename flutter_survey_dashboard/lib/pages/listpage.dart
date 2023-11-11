import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_survey_dashboard/components/mydropdown.dart';
import 'package:flutter_survey_dashboard/components/mytextfield.dart';

import 'package:flutter_survey_dashboard/services/service.dart';
import 'package:flutter_survey_dashboard/models/survey_detail.dart';

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

  final _formKey = GlobalKey<FormState>();

  final reportsController = TextEditingController();
  final ageController = TextEditingController();
  final gpaController = TextEditingController();
  final nationalityController = TextEditingController();
  final genreController = TextEditingController();
  final genderController = TextEditingController();
  final yearController = TextEditingController();

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

  // void showEditForm(SurveyDetails survey) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
  //         child: Form(
  //           key: _formKey,
  //           child: ListView(
  //             children: <Widget>[
  //               MyDropdown(
  //                 items: genres,
  //                 label: 'Genre',
  //                 onChanged: (String? value) {
  //                   genreController.text = value!;
  //                 },
  //                 initialValue: survey.genre,
  //               ),
  //               const SizedBox(height: 10),
  //               MyTextField(
  //                 label: 'Reports',
  //                 keyboardType: TextInputType.text,
  //                 onSaved: (String? value) {
  //                   reportsController.text = value!;
  //                 },
  //                 initialValue: survey.reports,
  //               ),
  //               const SizedBox(height: 10),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: MyTextField(
  //                       label: 'GPA',
  //                       keyboardType: TextInputType.number,
  //                       onSaved: (String? value) {
  //                         gpaController.text = value!;
  //                       },
  //                       initialValue: survey.gpa.toString(),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 10),
  //                   Expanded(
  //                     child: MyTextField(
  //                       label: 'Year',
  //                       keyboardType: TextInputType.number,
  //                       onSaved: (String? value) {
  //                         yearController.text = value!;
  //                       },
  //                       initialValue: survey.year.toString(),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 10),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: MyTextField(
  //                       label: 'Age',
  //                       keyboardType: TextInputType.number,
  //                       onSaved: (String? value) {
  //                         ageController.text = value!;
  //                       },
  //                       initialValue: survey.age.toString(),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 10),
  //                   Expanded(
  //                     child: MyDropdown(
  //                       items: genders,
  //                       label: 'Gender',
  //                       onChanged: (String? value) {
  //                         genderController.text = value!;
  //                       },
  //                       displayText: (String gender) {
  //                         String displayText = gender;
  //                         if (gender == 'M') {
  //                           displayText = 'Male';
  //                         } else if (gender == 'F') {
  //                           displayText = 'Female';
  //                         }
  //                         return displayText;
  //                       },
  //                       initialValue: survey.gender,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 10),
  //               MyDropdown(
  //                 items: nationalities,
  //                 label: 'Nationality',
  //                 onChanged: (String? value) {
  //                   nationalityController.text = value!;
  //                 },
  //                 initialValue: survey.nationality,
  //               ),
  //               const SizedBox(height: 30),
  //               ElevatedButton(
  //                 child: const Text('Cancel'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //               ElevatedButton(
  //                 child: const Text('Save'),
  //                 onPressed: () {
  //                   if (_formKey.currentState!.validate()) {
  //                     _formKey.currentState!.save();

  //                     final localContext = context;
  //                     try {
  //                       service1
  //                           .updateRespondent(
  //                             survey.id,
  //                             {
  //                               'Reports': reportsController.text,
  //                               'Age': ageController.text,
  //                               'Gpa': gpaController.text,
  //                               'Genre': genreController.text,
  //                               'Nationality': nationalityController.text,
  //                               'Gender': genderController.text,
  //                               'Year': yearController.text,
  //                             },
  //                           )
  //                           .then((_) => fetchSurveyDetails(currentPage))
  //                           .then((_) => Navigator.of(localContext).pop())
  //                           .catchError((e) {
  //                             // Handle the error
  //                           });
  //                     } catch (e) {
  //                       // Handle the error
  //                     }
  //                   }
  //                 },
  //               ),
  //               const SizedBox(height: 30),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  //---------------------------------------------------------------------------
  void showEditForm(SurveyDetails survey) {
    OverlayEntry? overlayEntry;

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        double height = MediaQuery.of(context).size.height;
        return SafeArea(
          child: SizedBox(
            height: height * 0.75,
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        MyDropdown(
                          items: genres,
                          label: 'Genre',
                          onChanged: (String? value) {
                            genreController.text = value!;
                          },
                          initialValue: survey.genre,
                        ),
                        const SizedBox(height: 15),
                        MyTextField(
                          label: 'Reports',
                          keyboardType: TextInputType.text,
                          onSaved: (String? value) {
                            reportsController.text = value!;
                          },
                          initialValue: survey.reports,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: MyTextField(
                                label: 'GPA',
                                keyboardType: TextInputType.number,
                                onSaved: (String? value) {
                                  gpaController.text = value!;
                                },
                                initialValue: survey.gpa.toString(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: MyTextField(
                                label: 'Year',
                                keyboardType: TextInputType.number,
                                onSaved: (String? value) {
                                  yearController.text = value!;
                                },
                                initialValue: survey.year.toString(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: MyTextField(
                                label: 'Age',
                                keyboardType: TextInputType.number,
                                onSaved: (String? value) {
                                  ageController.text = value!;
                                },
                                initialValue: survey.age.toString(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: MyDropdown(
                                items: genders,
                                label: 'Gender',
                                onChanged: (String? value) {
                                  genderController.text = value!;
                                },
                                displayText: (String gender) {
                                  String displayText = gender;
                                  if (gender == 'M') {
                                    displayText = 'Male';
                                  } else if (gender == 'F') {
                                    displayText = 'Female';
                                  }
                                  return displayText;
                                },
                                initialValue: survey.gender,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        MyDropdown(
                          items: nationalities,
                          label: 'Nationality',
                          onChanged: (String? value) {
                            nationalityController.text = value!;
                          },
                          initialValue: survey.nationality,
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      overlayEntry?.remove();
      overlayEntry = null;
    });

    Future.delayed(Duration.zero, () {
      overlayEntry = OverlayEntry(
        builder: (context) {
          // var orientation = MediaQuery.of(context).orientation;
          return Positioned(
            right: 10.0,
            // top: orientation == Orientation.portrait ? 130.0 : 30.0,
            top: 130,
            child: Row(
              children: [
                // FloatingActionButton(
                //   backgroundColor: const Color.fromARGB(255, 205, 0, 0),
                //   child: const Icon(Icons.cancel),
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //     overlayEntry?.remove();
                //   },
                // ),
                // const SizedBox(width: 8),
                FloatingActionButton(
                  child: const Icon(Icons.save),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final localContext = context;
                      try {
                        service1
                            .updateRespondent(
                              survey.id,
                              {
                                'Reports': reportsController.text,
                                'Age': ageController.text,
                                'Gpa': gpaController.text,
                                'Genre': genreController.text,
                                'Nationality': nationalityController.text,
                                'Gender': genderController.text,
                                'Year': yearController.text,
                              },
                            )
                            .then((_) => fetchSurveyDetails(currentPage))
                            .then((_) {
                              Navigator.of(localContext).pop();
                              overlayEntry?.remove();
                            })
                            .catchError((e) {
                              // Handle the error
                            });
                      } catch (e) {
                        // Handle the error
                      }
                    }
                  },
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 205, 0, 0),
                  child: const Icon(Icons.cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                    overlayEntry?.remove();
                  },
                ),
              ],
            ),
          );
        },
      );
      Overlay.of(context).insert(overlayEntry!);
    });
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     ElevatedButton(
                  //       onPressed: currentPage > 1
                  //           ? () {
                  //               setState(() {
                  //                 currentPage--;
                  //                 fetchSurveyDetails(currentPage);
                  //                 isLoading = true;
                  //               });
                  //             }
                  //           : null,
                  //       child: const Text("  <<  "),
                  //     ),
                  //     Text("Page $currentPage of $totalPages"),
                  //     ElevatedButton(
                  //       onPressed: currentPage < totalPages
                  //           ? () {
                  //               setState(() {
                  //                 currentPage++;
                  //                 fetchSurveyDetails(currentPage);
                  //                 isLoading = true;
                  //               });
                  //             }
                  //           : null,
                  //       child: const Text("  >> "),
                  //     ),
                  //     InkWell(
                  //       onTap: currentPage > 1
                  //           ? () {
                  //               setState(() {
                  //                 currentPage--;
                  //                 fetchSurveyDetails(currentPage);
                  //                 isLoading = true;
                  //               });
                  //             }
                  //           : null,
                  //       child: const Text("<<", style: TextStyle(fontSize: 24)),
                  //     ),
                  //     Text("Page $currentPage of $totalPages"),
                  //     InkWell(
                  //       onTap: currentPage < totalPages
                  //           ? () {
                  //               setState(() {
                  //                 currentPage++;
                  //                 fetchSurveyDetails(currentPage);
                  //                 isLoading = true;
                  //               });
                  //             }
                  //           : null,
                  //       child: const Text(">>", style: TextStyle(fontSize: 24)),
                  //     ),
                  //   ],
                  // ),
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
                              setState(() {
                                surveyDetails.removeAt(index);
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to delete respondent'),
                                ),
                              );
                            }
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20.0),
                            color: Colors.red,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: Card(
                            color: Colors.white,
                            elevation: 2.0,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey[600],
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                "Respondent ID : ${survey.id}",
                                style: const TextStyle(
                                  fontSize: 18.0,
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        reportsController.text = survey.reports;
                                        ageController.text =
                                            survey.age.toString();
                                        gpaController.text =
                                            survey.gpa.toString();
                                        nationalityController.text =
                                            survey.nationality;
                                        genreController.text = survey.genre;
                                        genderController.text = survey.gender;

                                        showEditForm(survey);
                                      },
                                    ),
                                    // Expanded(
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //       border: Border.all(
                                    //         color: Colors.black,
                                    //         width: 1,
                                    //       ),
                                    //     ),
                                    //     child: CountryFlag.fromCountryCode(
                                    //       getCountryCode(survey.nationality),
                                    //       height: 38,
                                    //       width: 50,
                                    //     ),
                                    //   ),
                                    // ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                      ),
                                      child: CountryFlag.fromCountryCode(
                                        getCountryCode(survey.nationality),
                                        height: 32,
                                        width: 43,
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
                  Container(
                    height: 35,
                    color: Colors.grey[600],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ElevatedButton(
                        //   onPressed: currentPage > 1
                        //       ? () {
                        //           setState(() {
                        //             currentPage--;
                        //             fetchSurveyDetails(currentPage);
                        //             isLoading = true;
                        //           });
                        //         }
                        //       : null,
                        //   child: const Text("  <<  "),
                        // ),
                        // Text("Page $currentPage of $totalPages"),
                        // ElevatedButton(
                        //   onPressed: currentPage < totalPages
                        //       ? () {
                        //           setState(() {
                        //             currentPage++;
                        //             fetchSurveyDetails(currentPage);
                        //             isLoading = true;
                        //           });
                        //         }
                        //       : null,
                        //   child: const Text("  >> "),
                        // ),
                        InkWell(
                          onTap: currentPage > 1
                              ? () {
                                  setState(() {
                                    currentPage--;
                                    fetchSurveyDetails(currentPage);
                                    isLoading = true;
                                  });
                                }
                              : null,
                          child: const Text("<<",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          "Page $currentPage of $totalPages",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        InkWell(
                          onTap: currentPage < totalPages
                              ? () {
                                  setState(() {
                                    currentPage++;
                                    fetchSurveyDetails(currentPage);
                                    isLoading = true;
                                  });
                                }
                              : null,
                          child: const Text(">>",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
