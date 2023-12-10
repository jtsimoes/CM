import 'package:cloud_functions/cloud_functions.dart';

class User {
  String phoneNumber;
  String name;
  String biography;
  String avatar;

  User({
    required this.phoneNumber,
    required this.name,
    required this.biography,
    required this.avatar,
  });

  static FirebaseFunctions functions = FirebaseFunctions.instance;

  static Future<User> create(String phoneNumber, String name, String biography, String avatar) async {
    Map<String, dynamic> newUser = {
      'phone_number': phoneNumber,
      'name': name,
      'biography': biography,
      'avatar': avatar
    };
    final response = (await functions.httpsCallable('create_user').call(newUser)).data;

    return User(
      phoneNumber: response['phone_number'],
      name: response['name'],
      biography: response['biography'],
      avatar: response['avatar'],
    );
  }

  static Future<User> fromId(String phoneNumber) async {
    final response = (await functions.httpsCallable('get_user').call({'phone_number': phoneNumber})).data;

    return User(
      phoneNumber: response['phoneNumber'],
      name: response['name'],
      biography: response['biography'],
      avatar: response['avatar'],
    );
  }
}
