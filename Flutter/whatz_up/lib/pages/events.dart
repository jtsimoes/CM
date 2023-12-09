import 'package:firebase_core/firebase_core.dart';
import 'package:whatz_up/utils/globals.dart';
import 'package:cloud_functions/cloud_functions.dart';

class Event {
  String id;
  String name;
  String description;
  double price;
  double latitude;
  double longitude;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.latitude,
    required this.longitude,
  });
}

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  Future<List<Event>> getEvents() async {
    await Firebase.initializeApp();
    FirebaseFunctions functions = FirebaseFunctions.instance;
    HttpsCallable callable = functions.httpsCallable('get_events');
    final results = await callable.call();
    return results.data;
  }

  Widget build2(BuildContext context) {
    return FutureBuilder<List<Event>>(
      future: getEvents(),
      builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while waiting
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show error message if something went wrong
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              Event event = snapshot.data![index];
              // Use event data to build your widgets
              // ...
              return Container(
                margin: const EdgeInsets.all(20),
                child: Card(
                  // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // Set the clip behavior of the card
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  // Define the child widgets of the card
                  child: InkWell(
                    splashColor: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.12),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      context.push("/event/$index");
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
                        Hero(
                          tag: 'hero-event$index',
                          child: Image.network(
                            "https://picsum.photos/id/158/550/320",
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                        // Add a container with padding that contains the card's title, text, and buttons
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Display the card's title using a font size of 24 and a dark grey color
                              Text(
                                event.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              // Add a space between the title and the text
                              const SizedBox(height: 8),
                              // Display the card's text using a font size of 15 and a light grey color
                              Text(
                                event.description,
                                style: const TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                              // Add a row with two buttons spaced apart and aligned to the right side of the card
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  ElevatedButton(
                                    child: const Text('Buy tickets'),
                                    onPressed: () {/* ... */},
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    child: const Text('Explore'),
                                    onPressed: () {
                                      context.push("/event/$index");
                                    },
                                  ),
                                  const SizedBox(height: 70),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 6, // Replace with actual number of events
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(20),
            child: Card(
              // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              // Set the clip behavior of the card
              clipBehavior: Clip.antiAliasWithSaveLayer,
              // Define the child widgets of the card
              child: InkWell(
                splashColor:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                highlightColor: Colors.transparent,
                onTap: () {
                  context.push("/event/$index");
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
                    Hero(
                      tag: 'hero-event$index',
                      child: Image.network(
                        "https://picsum.photos/id/158/550/320",
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                    // Add a container with padding that contains the card's title, text, and buttons
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Display the card's title using a font size of 24 and a dark grey color
                          Text(
                            "Event #$index",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          // Add a space between the title and the text
                          const SizedBox(height: 8),
                          // Display the card's text using a font size of 15 and a light grey color
                          Text(
                            "This is a description of the event #$index.",
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          // Add a row with two buttons spaced apart and aligned to the right side of the card
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ElevatedButton(
                                child: const Text('Buy tickets'),
                                onPressed: () {/* ... */},
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                child: const Text('Explore'),
                                onPressed: () {
                                  context.push("/event/$index");
                                },
                              ),
                              const SizedBox(height: 70),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // TODO: Navigate to add new event screen
            },
            tooltip: 'Add new event',
            mini: true,
            heroTag: null,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            onPressed: () {
              // TODO: Navigate to favorite events screen
            },
            tooltip: 'Favorite events',
            heroTag: null,
            child: const Icon(Icons.star),
          )
        ],
      ),
    );
  }
}
