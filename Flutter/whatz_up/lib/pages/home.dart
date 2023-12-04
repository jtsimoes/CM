import 'package:whatz_up/pages/calls.dart';
import 'package:whatz_up/pages/chats.dart';
import 'package:whatz_up/pages/events.dart';
import 'package:whatz_up/pages/status.dart';

import 'package:whatz_up/utils/globals.dart';

import 'package:whatz_up/utils/saved_image_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WhatzUp'),
          actions: [
            IconButton(
              icon: const Icon(Icons.camera_alt),
              tooltip: 'Camera',
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
                              )),
                    );
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {
                // TODO: Implement search functionality
              },
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: "New group",
                    child: Text("New group"),
                  ),
                  const PopupMenuItem(
                    value: "New broadcast",
                    child: Text("New broadcast"),
                  ),
                  const PopupMenuItem(
                    value: "Linked devices",
                    child: Text("Linked devices"),
                  ),
                  const PopupMenuItem(
                    value: "Starred messages",
                    child: Text("Starred messages"),
                  ),
                  PopupMenuItem(
                    value: "Settings",
                    onTap: () => context.push("/settings"),
                    child: const Text("Settings"),
                  ),
                ];
              },
            )
          ],
          bottom: TabBar.secondary(
            splashBorderRadius: const BorderRadius.vertical(
              top: Radius.circular(2),
            ),
            tabs: [
              const Tab(text: 'Events'),
              Tab(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Chats"),
                      if (true) // TODO: Show/hide according to unread messages count
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9))),
                          alignment: Alignment.center,
                          height: 16,
                          width: 16,
                          child: const Text(
                            "3", // TODO: Update count according to total of unread messages
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                    ]),
              ),
              const Tab(text: 'Updates'),
              const Tab(text: 'Calls'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const EventsPage(),
            const ChatsPage(),
            StatusPage(),
            const CallsPage(),
          ],
        ),
      ),
    );
  }
}
