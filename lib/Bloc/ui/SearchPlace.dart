import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';
class SearchPlace extends StatefulWidget {
  const SearchPlace({Key? key}) : super(key: key);

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace> {

  Completer<GoogleMapController> completer=Completer();
  late LatLng target;
  GoogleMapController? mapController;
  Set<Marker> marker={};
  @override
  void initState() {
    target=const LatLng(18.469481484138594, 73.86397432670049);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //print("Target"+target.toString());
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(

            initialCameraPosition: CameraPosition(target: target),
            compassEnabled: true,

            mapType: MapType.normal,
            rotateGesturesEnabled: true,
            markers: Set.of(marker),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            onMapCreated: (GoogleMapController controller) async{
              completer.complete(controller);

              mapController=await completer.future;


              setState(() {
                print("main data ${target.latitude}");
                controller.animateCamera(CameraUpdate.newCameraPosition(const CameraPosition(
                  target: LatLng(18.469481484138594, 73.86397432670049),
                  zoom: 50,
                )));
              });
            },
          ),
          Positioned(
            top: 40,
            left: 20,
            right:20,
            child: SearchGooglePlacesWidget(
              placeType: PlaceType.address,
              placeholder: "Search Your Destination",
              radius: 3000000,
              language: 'en',
              strictBounds: true,
              hasClearButton: true,
              iconColor: Colors.black,
              location:target,
              clearIcon: Icons.clear,
              icon: Icons.search,
              apiKey: "AIzaSyCFEIrn6AL1cAcPrJQmF5a7pfExyp-7Cvk",
              onSelected: (Place place) async{
                final geolocation = await place.geolocation;
               print("Place Data ${geolocation?.coordinates}");
                target=geolocation!.coordinates;

                setState(() {
                 marker.clear();
                 print("target data $target");
                 marker.add(
                   Marker(markerId: const MarkerId("1"),
                       flat: true,
                       infoWindow: InfoWindow(title: place.description),
                       position: LatLng(target.latitude,target.longitude)),

                 );
               });

              }, onSearch: (Place place) async{
               // Navigator.pop(context);
             /* final geolocation = await place.geolocation;*/
              print("place data${place.description}");

              // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom




            },

            ),
          ),
          Positioned(
              right: 5,
              bottom: 0,
              child: Column(
                children: [
                  Card(
                    color:const Color(0xFF8347b8),
                    shape: const StadiumBorder(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(

                          icon: const Icon(Icons.add_circle,color: Colors.white),
                          onPressed: (){
                            setState(() {
                              mapController?.animateCamera(CameraUpdate.zoomIn());
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle,color: Colors.white),
                          onPressed: (){
                            setState(() {
                              mapController?.animateCamera(CameraUpdate.zoomOut());
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )),

        ]
      ),
    );
  }
}
