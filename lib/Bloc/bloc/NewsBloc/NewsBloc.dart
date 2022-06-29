import 'package:demo/Bloc/Respository/NewsRepository.dart';
import 'package:demo/Bloc/bloc/NewsBloc/NewsState.dart';
import 'package:demo/Bloc/model/NewsModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'NewsEvent.dart';

class NewsBloc extends Bloc<NewsEvent,NewsState>{
  NewsBloc() : super(NewsInitialState()){
   on<NewsLoadEvent>((event, emit) async{
     final NewsRepository newsRepository=NewsRepository();
     try{
       emit(NewsInitialState());
      List<NewsModel> model=await newsRepository.fetchNewsData();

      emit(NewsLoadState(model));
     }
     catch(e){
       emit(NewsErrorState(e.toString()));
     }
   });
  }
}