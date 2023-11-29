import 'package:whatz_up/utils/globals.dart';

class Status {
  final String userInitials;
  final String userName;

  Status(this.userInitials, this.userName);
}

class StatusPage extends StatelessWidget {
  StatusPage({Key? key}) : super(key: key);

  final List<Status> statusUpdates = [
    Status("1", "User 1"),
    Status("B", "User B"),
    // TODO: Add more status updates here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Status", style: TextStyle(fontSize: 24)),
            Container(height: 10),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 5, right: 5),
              leading: const CircleAvatar(
                child: Text("ME"),
              ),
              title: const Text("My status"),
              subtitle: const Text("Tap to add status update",
                  style: TextStyle(color: Colors.grey)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WhatsappStoryEditor()),
                );
              },
            ),
            Container(height: 5),
            ListView.builder(
              shrinkWrap: true,
              itemCount: statusUpdates.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(5),
                  leading: CircleAvatar(
                    child: Text(statusUpdates[index].userInitials),
                  ),
                  title: Text(statusUpdates[index].userName),
                  onTap: () {
                    context.push("/story");
                  },
                );
              },
            ),
            Container(height: 20),
            const Text("Channels", style: TextStyle(fontSize: 24)),
            Container(height: 20),
            const Text(
                "Stay updated on topics that matter to you. Tap on \"explore more\" to find channels for you.",
                style: TextStyle(fontSize: 13, color: Colors.grey)),
            Container(height: 20),
            ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Explore more",
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () {
          // TODO: Finish camera functionality
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const WhatsappStoryEditor()),
          );
        },
      ),
    );
  }
}
