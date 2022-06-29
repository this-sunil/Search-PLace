import 'package:demo/Bloc/Respository/respository.dart';
import 'package:demo/Bloc/bloc/PhotoEvent.dart';
import 'package:demo/Bloc/bloc/PhotoState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class PhotoBloc extends Bloc<PhotoEvent,PhotoState>{

  PhotoBloc() : super(PhotoInitialState()){

  on<LoadPhotoEvent>((event,emit) async{
    final Repository repository=Repository();

    try{

      emit(PhotoInitialState());
      final model=await repository.fetchData();
      print("Photo Model length ${model.length}");
      emit(PhotoLoadedState(model));
    }
    catch(e){

      emit(PhotoErrorState(e.toString()));
      //throw e.toString();
    }
  });
  }
}