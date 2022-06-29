import 'package:demo/Bloc/model/PhotoModel.dart';
/*import 'package:dio/dio.dart';*/
import 'package:http/http.dart' as http;
class Repository{
  final String url="https://jsonplaceholder.typicode.com/posts";
   Future<List<PhotoModel>> fetchData() async{
    print("connected");

     final resp=await http.get(Uri.parse(url));


      //print("Response:${resp.data}");

    /*  print("Response Data ${resp.body}");*/
      Iterable<PhotoModel> result=photoModelFromJson(resp.body);
      List<PhotoModel> photoList=result.map((e){
        return PhotoModel(
            userId: e.userId,
            id: e.id,
            title:e.title,
            body: e.body);
      }).toList();
      print("response data");
      for(int i=0;i<photoList.length;i++){
        print("${photoList[i].title}");
      }
      return photoList;



  }
}