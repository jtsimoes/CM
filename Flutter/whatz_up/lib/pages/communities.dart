import 'package:flutter/material.dart';

class CommunitiesPage extends StatelessWidget {
  const CommunitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
      ),
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
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
                    Image.network(
                      "https://picsum.photos/id/158/550/320",
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
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
                          Container(height: 8),
                          // Display the card's text using a font size of 15 and a light grey color
                          const Text(
                            "This is a description of the event.",
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          // Add a row with two buttons spaced apart and aligned to the right side of the card
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text('BUY TICKETS'),
                                onPressed: () {/* ... */},
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                child: const Text('EXPLORE'),
                                onPressed: () {/* ... */},
                              ),
                              const SizedBox(height: 60),
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
    );
  }
}
