import 'package:flutter/material.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({Key? key}) : super(key: key); // TODO: Why?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10, // Replace with actual number of calls
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: const CircleAvatar(
              child: Text(
                  'A'), // Replace with actual user's initials or profile picture
            ),
            title: Text('User $index'), // Replace with actual user's name
            subtitle: const Row(
              children: <Widget>[
                Icon(Icons.call_received,
                    color:
                        Colors.red), // Replace with appropriate icon and color
                Text('10:00'), // Replace with actual call time
              ],
            ),
            trailing: const Icon(Icons.call), // Icon to initiate a call
            onTap: () {
              // TODO: Initiate a call
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_call),
        onPressed: () {
          // TODO: Navigate to new call screen
        },
      ),
    );
  }
}
