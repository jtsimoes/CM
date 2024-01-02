import 'package:whatz_up/pages/calls.dart';
import 'package:whatz_up/pages/chats.dart';
import 'package:whatz_up/pages/events.dart';
import 'package:whatz_up/pages/status.dart';

import 'package:whatz_up/utils/globals.dart';

bool isModalBottomSheetOpen = false;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBarWithSearchSwitch(
          onChanged: (value) => context.read<SearchBloc>().updateSearch(value),
          searchInputDecoration: InputDecoration(
            hintText: 'Type to search...',
            filled: false,
            labelStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
            hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
            border: InputBorder.none,
          ),
          closeOnSubmit: false,
          clearOnClose: true,
          toolbarHeight: 100,
          tooltipForCloseButton: 'Clear',
          clearSearchIcon: Icons.close,
          animation: AppBarAnimationSlideLeft.call,
          animationOfSpeechBar: AppBarAnimationSlideLeft.call,
          appBarBuilder: (context) {
            return AppBar(
              title: const Text('WhatzUp'),
              actions: [
                const AppBarSpeechButton(),
                const AppBarSearchButton(
                  toolTipStartText: 'Search',
                  buttonHasTwoStates: false,
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
                  const Tab(text: 'Status'),
                  const Tab(text: 'Calls'),
                ],
              ),
            );
          },
        ),
        body: ShakeGesture(
            onShake: () {
              if (!isModalBottomSheetOpen) {
                isModalBottomSheetOpen = true;
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
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
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
                ).whenComplete(() => isModalBottomSheetOpen = false);
              }
            },
            child: TabBarView(
              children: [
                const EventsPage(),
                const ChatsPage(),
                StatusPage(),
                const CallsPage(),
              ],
            )),
      ),
    );
  }
}
