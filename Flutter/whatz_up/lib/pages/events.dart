import 'package:whatz_up/models/event.dart';
import 'package:whatz_up/utils/globals.dart';

import 'package:add_2_calendar/add_2_calendar.dart' as calendar;

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = 0;
    return BlocBuilder<SearchBloc, String>(builder: (context, search) {
      return FutureBuilder<List<Event>>(
        future: Event.find(),
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.signal_wifi_statusbar_connected_no_internet_4,
                    size: 60,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'You are offline',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'You need an internet connection to find events.',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Please check your WiFi or data connection.',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: const Text('Retry'),
                    onPressed: () {
                      DefaultTabController.of(context).animateTo(1);
                    },
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Event event = snapshot.data![index];

                String search = context.read<SearchBloc>().state;

                if (search.isNotEmpty &&
                    !(event.name.toLowerCase().contains(search.toLowerCase()) ||
                        event.description
                            .toLowerCase()
                            .contains(search.toLowerCase()))) {
                  count++;
                  if (count == snapshot.data!.length) {
                    count = 0;
                    return Padding(
                      padding: const EdgeInsets.all(40),
                      child: Text(
                        'No results found for "$search"',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }
                  return Container();
                }

                count = 0;
                return Container(
                  margin: const EdgeInsets.all(15),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      splashColor: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.12),
                      highlightColor: Colors.transparent,
                      onTap: () {
                        context.push("/event", extra: event);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Hero(
                            tag: 'hero-event${event.id}',
                            child: Image.network(
                              event.image,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              alignment: Alignment.bottomCenter,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return const SizedBox(height: 10);
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  event.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  event.description,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                      ),
                                      child: const Text('Add to calendar'),
                                      onPressed: () {
                                        calendar.Add2Calendar.addEvent2Cal(
                                          calendar.Event(
                                            title: event.name,
                                            description: event.description,
                                            location:
                                                '${event.latitude} , ${event.longitude}',
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
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                      ),
                                      child: const Text('Explore'),
                                      onPressed: () {
                                        context.push("/event/$index",
                                            extra: event);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
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
    });
  }
}
