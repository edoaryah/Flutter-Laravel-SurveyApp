import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_survey_dashboard/services/endpoint.dart';
import 'package:flutter_survey_dashboard/models/average_age.dart';
import 'package:flutter_survey_dashboard/models/average_gpa.dart';
import 'package:flutter_survey_dashboard/models/gender.dart';
import 'package:flutter_survey_dashboard/models/genre.dart';
import 'package:flutter_survey_dashboard/models/nationality.dart';
import 'package:flutter_survey_dashboard/models/total_respondent.dart';
import 'package:flutter_survey_dashboard/models/survey_detail.dart';

class HttpSurveyDetails {
  Future<Map<String, dynamic>> getSurveyDetails(int page, int perPage) async {
    var response = await http.get(Uri.parse(
        '${Endpoints.getUrlSurveyDetails()}?page=$page&perPage=$perPage'));

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

class HttpUpdateSurveyDetails {
  Future<bool> updateSurveyDetails(
    int id,
    String genre,
    String reports,
    int age,
    String gpa,
    int year,
    String gender,
    String nationality,
  ) async {
    var response = await http.patch(
      Uri.parse('${Endpoints.getUrlSurveyDetails()}/$id'),
      body: {
        'Genre': genre,
        'Reports': reports,
        'Age': age.toString(),
        'Gpa': gpa,
        'Year': year.toString(),
        'Gender': gender,
        'Nationality': nationality,
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['success'];
    } else {
      throw Exception('Failed to update survey details');
    }
  }
}

class HttpTotalRespondents {
  Future<TotalRespondents> getTotalRespondents() async {
    var response =
        await http.get(Uri.parse(Endpoints.getUrlTotalRespondents()));

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
    var response = await http.get(Uri.parse(Endpoints.getUrlAverageAge()));

    if (response.statusCode == 200) {
      var age = double.parse(response.body);
      return AverageAgeRespondents.fromJson(age);
    } else {
      throw Exception('Failed to load average age respondents');
    }
  }
}

class HttpAverageGpaRespondents {
  Future<AverageGpaRespondents> getAverageGpaRespondents() async {
    var response = await http.get(Uri.parse(Endpoints.getUrlAverageGpa()));

    if (response.statusCode == 200) {
      var gpa = double.parse(response.body);
      return AverageGpaRespondents.fromJson(gpa);
    } else {
      throw Exception('Failed to load average gpa respondents');
    }
  }
}

class HttpGenderRespondents {
  Future<List<GenderRespondents>> getGenderRespondents() async {
    var response =
        await http.get(Uri.parse(Endpoints.getUrlRespondentsByGender()));

    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      return list.map((item) => GenderRespondents.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load gender respondents');
    }
  }
}

class HttpGenreRespondents {
  Future<List<GenreRespondents>> getGenreRespondents() async {
    var response =
        await http.get(Uri.parse(Endpoints.getUrlRespondentsByGenre()));

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
    var response =
        await http.get(Uri.parse(Endpoints.getUrlRespondentsByNationality()));

    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      return list.map((item) => NationalityRespondents.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load nationality respondents');
    }
  }
}

String getCountryCode(String countryName) {
  switch (countryName) {
    case 'Indonesia':
      return 'ID';
    case 'Soudan':
      return 'SD';
    case 'France':
      return 'FR';
    case 'Mexico':
      return 'MX';
    case 'South Africa':
      return 'ZA';
    case 'Yemen':
      return 'YE';
    default:
      return '';
  }
}
