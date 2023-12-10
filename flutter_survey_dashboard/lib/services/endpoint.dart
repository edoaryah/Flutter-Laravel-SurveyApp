class Endpoints {
  // static const String urlDomain = 'http://192.168.77.204:8000/';
  static const String urlDomain = 'http://192.168.1.12:8000/'; //punya diki ya

  static const String totalRespondents = 'api/total-respondents';
  static const String respondentsByGender = 'api/respondents-by-gender';
  static const String reportByGender = 'api/report-by-gender';
  static const String averageAge = 'api/average-age';
  static const String averageGpa = 'api/average-gpa';
  static const String respondentsByGenre = 'api/respondents-by-genre';
  static const String reportByRole = 'api/report-by-role';
  static const String reportByType = 'api/report-by-type';
  static const String respondentsByNationality =
      'api/respondents-by-nationality';
  static const String surveyDetails = 'api/survey-details';
  static const String reportDetails = 'api/report-details';
  static const String kelulusanMahasiswa = 'api/kelulusan';

  static String getUrlTotalRespondents() => urlDomain + totalRespondents;
  static String getUrlRespondentsByGender() => urlDomain + respondentsByGender;
  static String getUrlReportsByGender() => urlDomain + reportByGender;
  static String getUrlAverageAge() => urlDomain + averageAge;
  static String getUrlAverageGpa() => urlDomain + averageGpa;
  static String getUrlRespondentsByGenre() => urlDomain + respondentsByGenre;
  static String getUrlReportsByRole() => urlDomain + reportByRole;
  static String getUrlReportsByType() => urlDomain + reportByType;
  static String getUrlRespondentsByNationality() =>
      urlDomain + respondentsByNationality;
  static String getUrlSurveyDetails() => urlDomain + surveyDetails;
  static String getUrlReportDetails() => urlDomain + reportDetails;
  static String getUrlKelulusan() => urlDomain + kelulusanMahasiswa;
}
