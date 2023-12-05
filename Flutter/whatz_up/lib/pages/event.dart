import 'package:whatz_up/utils/globals.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class EventPage extends StatefulWidget {
  final String? eventId;

  const EventPage({Key? key, this.eventId}) : super(key: key);

  @override
  EventPageState createState() => EventPageState();
}

class EventPageState extends State<EventPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Text("Event #${widget.eventId}"),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Hero(
            tag: 'hero-event${widget.eventId}',
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
                "https://picsum.photos/id/158/550/320",
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Value here!"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Value here!"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Description:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Value here!"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Value here!"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "IDK:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Value here!"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Location:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ]),
          ),
          Container(
            padding: const EdgeInsets.all(30),
            height: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(51.509364, -0.128928),
                  zoom: 5,
                  maxZoom: 18,
                ),
                nonRotatedChildren: const [],
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 50,
                        height: 50,
                        point: LatLng(51.5, -0.09),
                        builder: (ctx) => const FlutterLogo(),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
