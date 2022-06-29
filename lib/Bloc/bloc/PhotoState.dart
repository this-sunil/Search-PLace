import 'package:demo/Bloc/model/PhotoModel.dart';

abstract class PhotoState{}
class PhotoInitialState extends PhotoState{}
class PhotoLoadedState extends PhotoState{
  final List<PhotoModel> photoModel;
  PhotoLoadedState(this.photoModel);
}
class PhotoErrorState extends PhotoState{
  final String message;
  PhotoErrorState(this.message);

}