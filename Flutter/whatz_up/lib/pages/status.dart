import 'package:whatz_up/utils/globals.dart';

class Status {
  final String userName;
  final String lastUpdate;

  Status(this.userName, this.lastUpdate);
}

class StatusPage extends StatelessWidget {
  StatusPage({Key? key}) : super(key: key);

  final List<Status> status = [
    Status("João Tomás", "just now"),
    Status("Pedro Duarte", "5 minutes ago"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Stack(
              children: <Widget>[
                CircleAvatar(
                  child: Image.asset(
                    profileBox.get('avatar',
                        defaultValue: 'assets/media/avatar.png')!,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  width: 15,
                  height: 15,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    style: ButtonStyle(
                        iconColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.primary),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.onPrimary)),
                    icon: const Icon(Icons.add),
                    iconSize: 15,
                    onPressed: null,
                  ),
                ),
              ],
            ),
            title: const Text("My status"),
            subtitle: const Text("Tap to add status update",
                style: TextStyle(color: Colors.grey)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WhatsappStoryEditor()),
              ).then((whatsappStoryEditorResult) {
                if (whatsappStoryEditorResult != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      showCloseIcon: true,
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      content: const Text("Status update published!"),
                    ),
                  );
                }
              });
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
            itemCount: status.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text(status[index].userName[0]),
                ),
                title: Text(status[index].userName),
                subtitle: Text(status[index].lastUpdate),
                onTap: () {
                  context.push("/story/${status[index].userName}");
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
        tooltip: 'Add status update',
        child: const Icon(Icons.camera_alt),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const WhatsappStoryEditor()),
          ).then((whatsappStoryEditorResult) {
            if (whatsappStoryEditorResult != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  showCloseIcon: true,
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  content: const Text("Status update published!"),
                ),
              );
            }
          });
        },
      ),
    );
  }
}
