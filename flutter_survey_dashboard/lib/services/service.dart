import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_survey_dashboard/models/survey_detail.dart';

String urlDomain = 'http://192.168.1.15:8000/';

String totalRespondents = 'api/total-respondents';
String respondentsByGender = 'api/respondents-by-gender';
String averageAge = 'api/average-age';
String averageGpa = 'api/average-gpa';
String respondentsByGenre = 'api/respondents-by-genre';
String respondentsByNationality = 'api/respondents-by-nationality';
String surveyDetails = 'api/survey-details';

String urlTotalRespondents = urlDomain + totalRespondents;
String urlRespondentsByGender = urlDomain + respondentsByGender;
String urlAverageAge = urlDomain + averageAge;
String urlAverageGpa = urlDomain + averageGpa;
String urlRespondentsByGenre = urlDomain + respondentsByGenre;
String urlRespondentsByNationality = urlDomain + respondentsByNationality;
String urlSurveyDetails = urlDomain + surveyDetails;

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
