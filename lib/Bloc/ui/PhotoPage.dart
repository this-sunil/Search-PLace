import 'package:demo/Bloc/Respository/NewsRepository.dart';
import 'package:demo/Bloc/Respository/respository.dart';
import 'package:demo/Bloc/bloc/NewsBloc/NewsBloc.dart';
import 'package:demo/Bloc/bloc/NewsBloc/NewsEvent.dart';
import 'package:demo/Bloc/bloc/PhotoBloc.dart';
import 'package:demo/Bloc/bloc/PhotoEvent.dart';
import 'package:demo/Bloc/bloc/PhotoState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/NewsBloc/NewsState.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  //final PhotoBloc _photoBloc =PhotoBloc();
  final NewsBloc newsBloc=NewsBloc();
  @override
  void initState() {

    /*_photoBloc.add(LoadPhotoEvent());*/
    newsBloc.add(NewsLoadEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Test Demo"),
        ),
        body: RefreshIndicator(
          onRefresh: ()=>NewsRepository().fetchNewsData(),
          child: BlocProvider(
            create: (_)=>newsBloc,
            child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                 if(state is NewsInitialState){
                   return const Center(child: CircularProgressIndicator());
                 }
                  else if (state is NewsLoadState) {
                    return ListView.builder(
                        itemCount: state.newsList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(state.newsList[index].countryInfo.flag),
                              ),
                              title: Text(state.newsList[index].country),
                              subtitle: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text("Active:"),
                                      Text(state.newsList[index].active.toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("Population:"),
                                      Text(state.newsList[index].population.toString()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return const Center(child: Text("Data not Found"));

                },
              ),

          ),
        ));
  }
}
