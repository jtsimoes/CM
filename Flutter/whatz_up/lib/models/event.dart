import 'package:cloud_functions/cloud_functions.dart';

class Event {
  String id;
  String name;
  String description;
  String image;
  double price;
  double latitude;
  double longitude;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.latitude,
    required this.longitude,
  });

  static FirebaseFunctions functions = FirebaseFunctions.instance;

  static Future<Event> create(String name, String description, String image,
      double price, double latitude, double longitude) async {
    Map<String, dynamic> newEvent = {
      'name': name,
      'description': description,
      'image': image,
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
      image: response['image'],
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
      image: response['image'],
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
              image: event['image'],
              price: (event['price'] as num).toDouble(),
              latitude: (event['latitude'] as num).toDouble(),
              longitude: (event['longitude'] as num).toDouble(),
            ))
        .toList();
  }

  static Event fromMap(Map<String, String> map) {
    return Event(
      id: map['id']!,
      name: map['name']!,
      description: map['description']!,
      image: map['image']!,
      price: double.parse(map['price']!),
      latitude: double.parse(map['latitude']!),
      longitude: double.parse(map['longitude']!),
    );
  }

  Map<String, String> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    };
  }
}
