import 'package:whatz_up/models/event.dart';
import 'package:whatz_up/utils/globals.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:add_2_calendar/add_2_calendar.dart' as calendar;

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
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const SizedBox(height: 0);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 30),
              const Text(
                "Date",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const Text("10/01/2024 17:00",
                  style:
                      TextStyle(color: Colors.white70)), // TODO: Hardcoded date
              const SizedBox(height: 15),
              const Text(
                "Description",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text(event.description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 15),
              const Text(
                "Price",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text("${event.price.toStringAsFixed(2)} €",
                  style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 15),
              const Text(
                "Location",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 8, 30, 0),
            height: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(event.latitude, event.longitude),
                  zoom: 16,
                  minZoom: 1,
                  maxZoom: 18,
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
                      tooltip: 'My location',
                      onPressed: () {
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
                        point: LatLng(event.latitude, event.longitude),
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: ElevatedButton(
                onPressed: () {
                  calendar.Add2Calendar.addEvent2Cal(
                    calendar.Event(
                      title: event.name,
                      description: event.description,
                      location: '${event.latitude} , ${event.longitude}',
                      startDate: DateTime.now(),
                      endDate: DateTime.now().add(
                        const Duration(
                          days: 1,
                          hours: 2,
                          minutes: 15,
                        ),
                      ),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event),
                    Text('   Add to calendar'),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
