import 'package:whatz_up/utils/globals.dart';

import 'package:whatz_up/utils/saved_image_view.dart';

class Status {
  final String userInitials;
  final String userName;

  Status(this.userInitials, this.userName);
}

class StatusPage extends StatelessWidget {
  StatusPage({Key? key}) : super(key: key);

  final List<Status> statusUpdates = [
    Status("J", "John Doe"),
    Status("E", "Example User"),
    // TODO: Add more status updates here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
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
          const Divider(
            height: 8,
            indent: 15,
            endIndent: 15,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: statusUpdates.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text(statusUpdates[index].userInitials),
                ),
                title: Text(statusUpdates[index].userName),
                subtitle: const Text('36 minutes ago'),
                onTap: () {
                  context.push("/story/$index");
                },
              );
            },
          ),
          Container(height: 20),
          ////////////////////////////////////////////////////////////////////
          /// TODO: Demo only for demonstration on how to get search value ///
          ////////////////////////////////////////////////////////////////////
          BlocBuilder<SearchBloc, String>(
            builder: (context, value) {
              if (value.isEmpty || value == "" || value == " ") {
                return const Column(
                  children: [
                    Text(
                      "Search mode disabled, showing all elements",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    Text(
                      "(click on search icon and type something to begin searching)",
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Text(
                      "Search mode enabled, showing only elements containing '$value'",
                      style: const TextStyle(fontSize: 20, color: Colors.green),
                    ),
                    const Text(
                      "(clear by pressing X button or delete the search text to exit search mode)",
                    ),
                  ],
                );
              }
            },
          ),
          ////////////////////////////////////////////////////////////////////
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () {
          // TODO: Finish camera functionality
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const WhatsappStoryEditor()),
          ).then((whatsappStoryEditorResult) {
            if (whatsappStoryEditorResult != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavedImageView(
                    image: whatsappStoryEditorResult.image,
                    caption: whatsappStoryEditorResult.caption,
                  ),
                ),
              );
            }
          });
        },
      ),
    );
  }
}
