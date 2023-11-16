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
            IconButton(
              icon: const Icon(Icons.more_vert),
              tooltip: 'Menu',
              onPressed: () {
                // Create a dropdown menu with the following options:
                // New group, New broadcast, WhatsApp Web, Starred messages,
                // Settings, and Log out
              },
            ),
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
