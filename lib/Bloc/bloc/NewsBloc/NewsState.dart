import 'package:demo/Bloc/model/NewsModel.dart';

abstract class NewsState{}
class NewsInitialState extends NewsState{}
class NewsLoadState extends NewsState{
  final List<NewsModel> newsList;
  NewsLoadState(this.newsList);
}
class NewsErrorState extends NewsState{
  final String message;
  NewsErrorState(this.message);
}