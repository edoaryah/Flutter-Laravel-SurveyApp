import 'package:flutter/material.dart';
import 'package:flutter_survey_dashboard/components/mydropdown.dart';
import 'package:flutter_survey_dashboard/components/mytextfield.dart';
import 'package:flutter_survey_dashboard/services/service.dart';

class FormReportPage extends StatefulWidget {
  const FormReportPage({super.key});

  @override
  State<FormReportPage> createState() => _FormReportPageState();
}

class _FormReportPageState extends State<FormReportPage> {
  late HttpRoleReport service1;
  late HttpTypeReport service2;
  late HttpGenderReport service3;

  List<String> roles = [];
  List<String> types = [];
  List<String> genders = [];

  final _formKey = GlobalKey<FormState>();
  final HttpReportDetails _httpReportDetails = HttpReportDetails();

  String name = '';
  int age = 0;
  String gender = '';
  String role = '';
  String type = '';
  String reports = '';

  bool isLoading = false;

  @override
  void initState() {
    service1 = HttpRoleReport();
    service2 = HttpTypeReport();
    service3 = HttpGenderReport();
    super.initState();
    fetchDropDown();
  }

  Future<void> fetchDropDown() async {
    try {
      setState(() {
        isLoading = true;
      });
      final roleReports = await service1.getRoleReport();
      final typeReports = await service2.getTypeReport();
      final genderReports = await service3.getGenderReport();
      setState(() {
        roles = roleReports.map((nr) => nr.role).toList();
        types = typeReports.map((gr) => gr.type).toList();
        genders = genderReports.map((gdr) => gdr.gender).toList();
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
                child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 205, 0, 0)),
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
                            'Form Information',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            child: MyTextField(
                              label: 'Name',
                              keyboardType: TextInputType.text,
                              onSaved: (String? value) {
                                name = value!;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              //form age
                              Expanded(
                                child: MyTextField(
                                  label: 'Age',
                                  keyboardType: TextInputType.number,
                                  onSaved: (String? value) {
                                    age = int.parse(value!);
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              //form gender
                              Expanded(
                                child: MyDropdown(
                                  items: genders,
                                  label: 'Gender',
                                  width: 180,
                                  onChanged: (String? value) {
                                    gender = value!;
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
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          MyDropdown(
                            items: roles,
                            label: 'Im a',
                            onChanged: (String? value) {
                              role = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          MyDropdown(
                            items: types,
                            label: 'Type of Violence',
                            onChanged: (String? value) {
                              type = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            child: MyTextField(
                              label: 'Incident Description',
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
                              onSaved: (String? value) {
                                reports = value!;
                              },
                            ),
                          ),
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                Map<String, String> reportData = {
                                  'Name': name,
                                  'Reports': reports,
                                  'Age': age.toString(),
                                  'Role': role,
                                  'Gender': gender,
                                  'Type': type,
                                };

                                try {
                                  _httpReportDetails.createReport(reportData);

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Thanks!'),
                                        content: const Text(
                                            'Your report has been successfully submitted.'),
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
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 205, 0, 0),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Center(
                                child: Text(
                                  'Send Report',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
