import 'dart:collection';

import 'package:whatz_up/models/event.dart';
import 'package:whatz_up/utils/globals.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class EventPage extends StatefulWidget {
  final Event? event;

  const EventPage({Key? key, this.event}) : super(key: key);

  @override
  EventPageState createState() => EventPageState();
}

class EventPageState extends State<EventPage> {
  FollowOnLocationUpdate _followOnLocationUpdate = FollowOnLocationUpdate.never;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Event event = widget.event!;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(event.name),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Hero(
            tag: 'hero-event${event.id}',
            child: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.transparent,
                    Theme.of(context).colorScheme.background,
                  ],
                ),
              ),
              child: Image.network(
                widget.event!.image,
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 30),
              Text(
                "Date",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text("10/01/2024 17:00", style: TextStyle(color: Colors.white70)),
              SizedBox(height: 15),
              Text(
                "Description",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text(
                  event.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.white70)),
              SizedBox(height: 15),
              Text(
                "Price",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text(event.price.toStringAsFixed(2) + " €", style: TextStyle(color: Colors.white70)),
              SizedBox(height: 15),
              Text(
                "Location",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 8, 30, 30),
            height: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FlutterMap(
                options: MapOptions(
                  bounds: LatLngBounds.fromPoints([
                    LatLng(40.6331718829789, -8.659493989183968),
                    LatLng(40.62755301996205, -8.64809465870283)
                  ]),
                  boundsOptions:
                      const FitBoundsOptions(padding: EdgeInsets.all(50)),
                  center: LatLng(40.6331718829789, -8.659493989183968),
                  zoom: 16,
                  minZoom: 1,
                  maxZoom: 18,
                  // Stop following the location marker on the map if user interacted with the map.
                  onPositionChanged: (MapPosition position, bool hasGesture) {
                    if (hasGesture &&
                        _followOnLocationUpdate !=
                            FollowOnLocationUpdate.never) {
                      setState(
                        () => _followOnLocationUpdate =
                            FollowOnLocationUpdate.never,
                      );
                    }
                  },
                ),
                nonRotatedChildren: [
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Follow the location marker on the map when location updated until user interact with the map.
                        setState(
                          () => _followOnLocationUpdate =
                              FollowOnLocationUpdate.always,
                        );
                      },
                      mini: true,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.7),
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v12/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoiYWdvcmFhdmVpcm8iLCJhIjoiY2trbmNoeXd5MXN2cTJudGRodzhjbjR6bSJ9.dvGHDz58mhv1i46hWJvEtQ',
                    tileSize: 512,
                    zoomOffset: -1,
                  ),
                  CurrentLocationLayer(
                    followOnLocationUpdate: _followOnLocationUpdate,
                    turnOnHeadingUpdate: TurnOnHeadingUpdate.always,
                    style: const LocationMarkerStyle(
                      marker: DefaultLocationMarker(
                        child: Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      markerSize: Size(30, 30),
                      markerDirection: MarkerDirection.heading,
                      headingSectorRadius: 150,
                    ),
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 50,
                        height: 50,
                        point: LatLng(40.6331718829789, -8.659493989183968),
                        builder: (ctx) => const Icon(
                          Icons.location_on,
                          shadows: <Shadow>[
                            Shadow(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              blurRadius: 30.0,
                            )
                          ],
                          color: Color.fromRGBO(175, 255, 56, 1),
                          size: 50,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
