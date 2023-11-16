import 'package:whatz_up/pages/calls.dart';
import 'package:whatz_up/pages/chats.dart';
import 'package:whatz_up/pages/communities.dart';
import 'package:whatz_up/pages/updates.dart';

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
                // TODO: Implement search functionality
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
                // TODO: Implement more options functionality
              },
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext contesxt) {
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
                  const PopupMenuItem(
                    value: "Settings",
                    child: Text("Settings"),
                  ),
                ];
              },
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.people)),
              Tab(text: 'Chats'),
              Tab(text: 'Updates'),
              Tab(text: 'Calls'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const CommunitiesPage(),
            const ChatsPage(),
            StatusPage(),
            const CallsPage(),
          ],
        ),
      ),
    );
  }
}
