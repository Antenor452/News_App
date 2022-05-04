import 'package:news_app/helpers/Api.dart';

class UrlComposer {
  static defaultUrl(int page) {
    return 'https://newsapi.org/v2/everything?page=$page&key=';
  }

  static defaulUrlWithKeyword(String keyword,int page) {
    return 'https://newsapi.org/v2/everything?q=$keyword&page=$page&apiKey=';
  }

  static urlWithCountryOfChoice(String countryCode,int page) {
    return 'https://newsapi.org/v2/top-headlines?country=$countryCode&category=business&page=$page&apiKey=';
  }
 
}