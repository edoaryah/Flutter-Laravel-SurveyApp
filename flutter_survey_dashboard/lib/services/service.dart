import 'package:flutter_survey_dashboard/models/average_age.dart';
import 'package:flutter_survey_dashboard/models/average_gpa.dart';
import 'package:flutter_survey_dashboard/models/genre.dart';
import 'package:flutter_survey_dashboard/models/nationality.dart';
import 'package:flutter_survey_dashboard/models/total_respondent.dart';
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

class HttpTotalRespondents {
  Future<TotalRespondents> getTotalRespondents() async {
    var response = await http.get(Uri.parse('$urlTotalRespondents'));

    if (response.statusCode == 200) {
      var total = int.parse(response.body);
      return TotalRespondents.fromJson(total);
    } else {
      throw Exception('Failed to load total respondents');
    }
  }
}

class HttpAverageAgeRespondents {
  Future<AverageAgeRespondents> getAverageAgeRespondents() async {
    var response = await http.get(Uri.parse('$urlAverageAge'));

    if (response.statusCode == 200) {
      var age = double.parse(response.body);
      return AverageAgeRespondents.fromJson(age);
    } else {
      throw Exception('Failed to load total respondents');
    }
  }
}

class HttpAverageGpaRespondents {
  Future<AverageGpaRespondents> getAverageGpaRespondents() async {
    var response = await http.get(Uri.parse('$urlAverageGpa'));

    if (response.statusCode == 200) {
      var gpa = double.parse(response.body);
      return AverageGpaRespondents.fromJson(gpa);
    } else {
      throw Exception('Failed to load total respondents');
    }
  }
}

class HttpGenreRespondents {
  Future<List<GenreRespondents>> getGenreRespondents() async {
    var response = await http.get(Uri.parse('$urlRespondentsByGenre'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      return list.map((item) => GenreRespondents.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load genre respondents');
    }
  }
}

class HttpNationalityRespondents {
  Future<List<NationalityRespondents>> getNationalityRespondents() async {
    var response = await http.get(Uri.parse('$urlRespondentsByNationality'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      return list.map((item) => NationalityRespondents.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load genre respondents');
    }
  }
}
