import 'dart:convert';

import 'package:demo/Bloc/model/NewsModel.dart';
import 'package:http/http.dart' as http;
class NewsRepository{
  Future<List<NewsModel>> fetchNewsData() async{
    final resp=await http.get(Uri.parse("https://corona.lmao.ninja/v2/countries"));
    Iterable newsData=newsModelFromJson(resp.body);
    print("Response ${resp.body}");
    List<NewsModel> newsList=newsData.map((e){
        return NewsModel(updated: e.updated,
            country: e.country,
            countryInfo: e.countryInfo,
            cases: e.cases,
            todayCases: e.todayCases,
            deaths: e.deaths,
            todayDeaths: e.todayDeaths,
            recovered: e.recovered,
            active: e.active,
            critical: e.critical,
            casesPerOneMillion: e.casesPerOneMillion,
            deathsPerOneMillion: e.deathsPerOneMillion,
            tests: e.tests,
            testsPerOneMillion: e.testsPerOneMillion,
            oneTestPerPeople: e.oneTestPerPeople,
            oneCasePerPeople: e.oneCasePerPeople,
            activePerOneMillion: e.activePerOneMillion,
            recoveredPerOneMillion: e.recoveredPerOneMillion,
            criticalPerOneMillion: e.criticalPerOneMillion,
            population: e.population,
            oneDeathPerPeople: e.oneDeathPerPeople,
            todayRecovered: e.todayRecovered);
      }).toList();


    return newsList;
  }
}