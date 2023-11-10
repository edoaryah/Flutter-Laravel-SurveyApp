import 'package:flutter/material.dart';
import 'package:flutter_survey_dashboard/services/service.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late HttpNationalityRespondents service1;
  late HttpGenreRespondents service2;
  late HttpGenderRespondents service3;

  List<String> nationalities = [];
  List<String> genres = [];
  List<String> genders = [];

  final _formKey = GlobalKey<FormState>();
  final HttpSurveyDetails _httpSurveyDetails = HttpSurveyDetails();

  String genre = '';
  String reports = '';
  int age = 0;
  String gpa = '';
  int year = 0;
  String gender = '';
  String nationality = '';

  bool isLoading = false;

  @override
  void initState() {
    service1 = HttpNationalityRespondents();
    service2 = HttpGenreRespondents();
    service3 = HttpGenderRespondents();
    super.initState();
    fetchDropDown();
  }

  Future<void> fetchDropDown() async {
    try {
      setState(() {
        isLoading = true;
      });
      final nationalityRespondents = await service1.getNationalityRespondents();
      final genreRespondents = await service2.getGenreRespondents();
      final genderRespondents = await service3.getGenderRespondents();
      setState(() {
        nationalities =
            nationalityRespondents.map((nr) => nr.nationality).toList();
        isLoading = false;
        genres = genreRespondents.map((gr) => gr.genre).toList();
        genders = genderRespondents.map((gdr) => gdr.gender).toList();
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
            : ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, top: 25, right: 16, bottom: 25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              //form age
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        'Age',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      onSaved: (String? value) {
                                        age = int.parse(value!);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              //form gender
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        'Gender',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 59,
                                      width: 180,
                                      child: DropdownButtonFormField(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                        items: genders.map((gender) {
                                          String displayText = gender;
                                          if (gender == 'M') {
                                            displayText = 'Male';
                                          } else if (gender == 'F') {
                                            displayText = 'Female';
                                          }
                                          return DropdownMenuItem(
                                            value: gender,
                                            child: Text(displayText),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          gender = value!;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          //form nationality
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 3),
                                child: Text(
                                  'Nationality',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 59,
                                child: DropdownButtonFormField(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  items: nationalities.map((nationality) {
                                    return DropdownMenuItem(
                                      value: nationality,
                                      child: Text(nationality),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    nationality = value!;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            'Academic Report',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              //form gpa
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        'GPA',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      onSaved: (String? value) {
                                        gpa = value!;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              //form year
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        'Year',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      onSaved: (String? value) {
                                        year = int.parse(value!);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          //form genre
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 3),
                                child: Text(
                                  'Genre',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 59,
                                child: DropdownButtonFormField(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  items: genres.map((genre) {
                                    return DropdownMenuItem(
                                      value: genre,
                                      child: Text(genre),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    genre = value!;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    'Report',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  onSaved: (String? value) {
                                    reports = value!;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                Map<String, String> respondentData = {
                                  'Genre': genre,
                                  'Reports': reports,
                                  'Age': age.toString(),
                                  'Gpa': gpa,
                                  'Year': year.toString(),
                                  'Count': '1',
                                  'Gender': gender,
                                  'Nationality': nationality,
                                };

                                try {
                                  _httpSurveyDetails
                                      .createRespondent(respondentData);

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Success'),
                                        content: const Text(
                                            'Data has been successfully submitted.'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  _formKey.currentState!.reset();
                                } catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                            'Failed to submit data.'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
