import 'package:whatz_up/utils/globals.dart';

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
        padding: const EdgeInsets.all(20),
        children: const [
          Text("TODO: Event details go here"),
        ],
      ),
    );
  }
}
