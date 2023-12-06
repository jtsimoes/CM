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
                  "Bacon ipsum dolor amet bacon t-bone chicken chuck hamburger frankfurter pork loin tongue venison filet mignon. Filet mignon swine kevin spare ribs fatback shank sausage cow biltong pork loin meatball picanha leberkas ground round.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.white70)),
              SizedBox(height: 15),
              Text(
                "Price",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text("69 €", style: TextStyle(color: Colors.white70)),
              SizedBox(height: 15),
              Text(
                "Idk",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text("Value goes here...",
                  style: TextStyle(color: Colors.white70)),
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
