import 'package:whatz_up/utils/globals.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key); // TODO: Why?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10, // Replace with actual number of chats
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: const CircleAvatar(
              child: Text(
                  'A'), // Replace with actual user's initials or profile picture
            ),
            title: Text('User $index'), // Replace with actual user's name
            subtitle: Text(
                'Last message from user $index'), // Replace with actual last message
            trailing:
                const Text('10:00'), // Replace with actual time of last message
            onTap: () => context.go('/chat/$index'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: () {
          // TODO: Navigate to new chat screen
        },
      ),
    );
  }
}
