import 'package:flutter/material.dart';
import 'package:flutter_survey_dashboard/components/mydropdown.dart';
import 'package:flutter_survey_dashboard/components/mytextfield.dart';

import 'package:flutter_survey_dashboard/services/service.dart';
import 'package:flutter_survey_dashboard/models/report_detail.dart';

class ListPageReport extends StatefulWidget {
  const ListPageReport({super.key});

  @override
  State<ListPageReport> createState() => _ListPageReportState();
}

class _ListPageReportState extends State<ListPageReport> {
  late HttpRoleReport service1;
  late HttpTypeReport service2;
  late HttpGenderReport service3;
  late HttpReportDetails service4;

  List<String> roles = [];
  List<String> types = [];
  List<String> genders = [];
  List<ReportDetails> reportDetails = [];

  int currentPage = 1;
  int totalPages = 1;
  int reportDetailsPerPage = 20;

  bool isLoading = true;

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final roleController = TextEditingController();
  final typeController = TextEditingController();
  final reportsController = TextEditingController();

  @override
  void initState() {
    service1 = HttpRoleReport();
    service2 = HttpTypeReport();
    service3 = HttpGenderReport();
    service4 = HttpReportDetails();
    super.initState();
    fetchData();
    fetchDropDown();
  }

  Future<void> fetchData() async {
    try {
      final data =
          await service4.getReportDetails(currentPage, reportDetailsPerPage);
      setState(() {
        reportDetails = data['items'];
        totalPages = data['lastPage'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchReportDetails(int page) async {
    try {
      setState(() {
        isLoading = true;
      });
      final data = await service4.getReportDetails(page, reportDetailsPerPage);
      setState(() {
        reportDetails = data['items'];
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

  void showEditForm(ReportDetails report) {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(
                          child: MyTextField(
                            label: 'Name',
                            keyboardType: TextInputType.text,
                            onSaved: (String? value) {
                              nameController.text = value!;
                            },
                            initialValue: report.name,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            //form age
                            Expanded(
                              child: MyTextField(
                                label: 'Age',
                                keyboardType: TextInputType.number,
                                onSaved: (String? value) {
                                  ageController.text = value!;
                                },
                                initialValue: report.age.toString(),
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
                                initialValue: report.gender,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        MyDropdown(
                          items: roles,
                          label: 'Im a',
                          onChanged: (String? value) {
                            roleController.text = value!;
                          },
                          initialValue: report.role,
                        ),
                        const SizedBox(height: 20),
                        MyDropdown(
                          items: types,
                          label: 'Type of Violence',
                          onChanged: (String? value) {
                            typeController.text = value!;
                          },
                          initialValue: report.type,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          child: MyTextField(
                            label: 'Incident Description',
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            onSaved: (String? value) {
                              reportsController.text = value!;
                            },
                            initialValue: report.reports,
                          ),
                        ),
                        const SizedBox(height: 15),
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
                FloatingActionButton(
                  child: const Icon(Icons.save),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final localContext = context;
                      try {
                        service4
                            .updateReport(
                              report.id,
                              {
                                'Reports': reportsController.text,
                                'Age': ageController.text,
                                'Name': nameController.text,
                                'Role': roleController.text,
                                'Type': typeController.text,
                                'Gender': genderController.text,
                              },
                            )
                            .then((_) => fetchReportDetails(currentPage))
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
                child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 205, 0, 0)),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: reportDetails.length + 2, //awalnya 0
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // tambahan
                          return const SizedBox(height: 8);
                        } else if (index == reportDetails.length + 1) {
                          //tambahan
                          return Column(
                            children: [
                              const SizedBox(height: 8),
                              Container(
                                height: 35,
                                color: Colors.grey[800],
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: currentPage > 1
                                          ? () {
                                              setState(() {
                                                currentPage = 1;
                                                fetchReportDetails(currentPage);
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
                                    InkWell(
                                      onTap: currentPage > 1
                                          ? () {
                                              setState(() {
                                                currentPage--;
                                                fetchReportDetails(currentPage);
                                                isLoading = true;
                                              });
                                            }
                                          : null,
                                      child: const Text("<",
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
                                                fetchReportDetails(currentPage);
                                                isLoading = true;
                                              });
                                            }
                                          : null,
                                      child: const Text(">",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    InkWell(
                                      onTap: currentPage < totalPages
                                          ? () {
                                              setState(() {
                                                currentPage == totalPages;
                                                fetchReportDetails(totalPages);
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
                          );
                        } else {
                          final report = reportDetails[index - 1];
                          return Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 4),
                            child: Dismissible(
                              key: Key(report.id.toString()),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                try {
                                  HttpReportDetails().deleteReport(report.id);
                                  setState(() {
                                    reportDetails.removeAt(index - 1);
                                  });
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Failed to delete report'),
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
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Card(
                                  color: Colors.grey[300],
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.grey[800],
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text(
                                      report.name,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Text(report.gender == 'M'
                                            ? 'Male'
                                            : 'Female'),
                                        const Text(' | '),
                                        Text('${report.age} y.o.'),
                                      ],
                                    ),
                                    trailing: SizedBox(
                                      width: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: () {
                                              reportsController.text =
                                                  report.reports;
                                              ageController.text =
                                                  report.age.toString();
                                              typeController.text = report.type;
                                              roleController.text = report.role;
                                              genderController.text =
                                                  report.gender;
                                              nameController.text = report.name;

                                              showEditForm(report);
                                            },
                                          ),
                                          // Container(
                                          //   decoration: BoxDecoration(
                                          //     border: Border.all(
                                          //       color: Colors.black,
                                          //       width: 1,
                                          //     ),
                                          //   ),
                                          //   child: CountryFlag.fromCountryCode(
                                          //     getCountryCode(
                                          //         survey.nationality),
                                          //     height: 32,
                                          //     width: 43,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Type: ${report.type}'),
                                            content: Text(
                                                'Reports: ${report.reports}'),
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
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
