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

  static FirebaseFunctions functions = FirebaseFunctions.instance;

  static Future<Event> create(String name, String description, double price,
      double latitude, double longitude) async {
    Map<String, dynamic> newEvent = {
      'name': name,
      'description': description,
      'price': price,
      'latitude': latitude,
      'longitude': longitude
    };
    final response =
        (await functions.httpsCallable('create_event').call(newEvent)).data;

    return Event(
      id: response['id'],
      name: response['name'],
      description: response['description'],
      price: response['price'],
      latitude: response['latitude'],
      longitude: response['longitude'],
    );
  }

  static Future<Event> fromId(String id) async {
    final response =
        (await functions.httpsCallable('get_event').call({'id': id})).data;

    return Event(
      id: response['id'],
      name: response['name'],
      description: response['description'],
      price: response['price'],
      latitude: response['latitude'],
      longitude: response['longitude'],
    );
  }

  static Future<List<Event>> find() async {
    final List<dynamic> response =
        (await functions.httpsCallable('get_events').call()).data;

    return response
        .map((event) => Event(
              id: event['id'],
              name: event['name'],
              description: event['description'],
              price: (event['price'] as int)
                  .toDouble(), // TODO: Temporary fix, should be fixed in the database
              latitude: (event['latitude'] as int)
                  .toDouble(), // TODO: Temporary fix, should be fixed in the database
              longitude: (event['longitude'] as int)
                  .toDouble(), // TODO: Temporary fix, should be fixed in the database
            ))
        .toList();
  }
}
