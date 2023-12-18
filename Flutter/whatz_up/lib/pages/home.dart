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
              offset: const Offset(0, 50),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    onTap: () => context.push("/profile"),
                    child: const Text("Profile"),
                  ),
                  PopupMenuItem(
                    onTap: () => context.push("/settings"),
                    child: const Text("Settings"),
                  ),
                  PopupMenuItem(
                    onTap: () => print("TODO: Logout"),
                    child: const Text("Logout"),
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
        body: ShakeGesture(
          onShake: () {
            showModalBottomSheet(
              showDragHandle: true,
              context: context,
              builder: (context) => SizedBox(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Report a technical problem",
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "You are seeing this because you shook your phone three times. This is a shortcut to open the dialog box for reporting problems on the app.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "If something isn't working correctly, you can give feedback to help us make WhatzUp better.",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            foregroundColor:
                                Theme.of(context).colorScheme.onError,
                            minimumSize: const Size(900, 50),
                          ),
                          onPressed: () {
                            context.pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  showCloseIcon: true,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  content: const Text(
                                      "The problem was reported, thank you for your feedback!")),
                            );
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.bug_report),
                              SizedBox(width: 5),
                              Text("Report problem")
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiary,
                            foregroundColor:
                                Theme.of(context).colorScheme.onTertiary,
                            minimumSize: const Size(1000, 50),
                          ),
                          onPressed: () => context.pop(),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.exit_to_app),
                              SizedBox(width: 5),
                              Text("Cancel")
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          child: TabBarView(
            children: [
              const EventsPage(),
              const ChatsPage(),
              StatusPage(),
              const CallsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
