class Endpoints {
  static const String urlDomain = 'http://192.168.77.204:8000/';

  static const String totalRespondents = 'api/total-respondents';
  static const String respondentsByGender = 'api/respondents-by-gender';
  static const String averageAge = 'api/average-age';
  static const String averageGpa = 'api/average-gpa';
  static const String respondentsByGenre = 'api/respondents-by-genre';
  static const String respondentsByNationality =
      'api/respondents-by-nationality';
  static const String surveyDetails = 'api/survey-details';

  static String getUrlTotalRespondents() => urlDomain + totalRespondents;
  static String getUrlRespondentsByGender() => urlDomain + respondentsByGender;
  static String getUrlAverageAge() => urlDomain + averageAge;
  static String getUrlAverageGpa() => urlDomain + averageGpa;
  static String getUrlRespondentsByGenre() => urlDomain + respondentsByGenre;
  static String getUrlRespondentsByNationality() =>
      urlDomain + respondentsByNationality;
  static String getUrlSurveyDetails() => urlDomain + surveyDetails;
}
