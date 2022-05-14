import 'package:news_app/helpers/Api.dart';
import 'package:news_app/helpers/urlComposer.dart';

class Functions{


  static getApi({ required countryCode, required page}){
    return fetchResponse(UrlComposer.urlWithCountryOfChoice(countryCode, page));
  }
}