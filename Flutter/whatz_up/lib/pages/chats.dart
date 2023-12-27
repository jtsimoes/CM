import 'package:whatz_up/utils/globals.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  ChatsPageState createState() => ChatsPageState();
}

class ChatsPageState extends State<ChatsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isExtended = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.offset >= 50) {
      setState(() {
        _isExtended = false;
      });
    } else {
      setState(() {
        _isExtended = true;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 21, // Replace with actual number of chats
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(
                  'U$index'), // Replace with actual user's initials or profile picture
            ),
            title: Text('User $index'), // Replace with actual user's name
            subtitle: Text(
                'Last message from user $index'), // Replace with actual last message
            trailing:
                const Text('10:00'), // Replace with actual time of last message
            onTap: () => context.push('/chat/$index'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Padding(
          padding: _isExtended
              ? const EdgeInsets.all(0)
              : const EdgeInsets.only(right: 9.0),
          child: const Icon(Icons.message),
        ),
        label: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: _isExtended
                  ? const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text('Chat nearby friends'),
                    )
                  : const Padding(padding: EdgeInsets.all(0))),
        ),
        extendedIconLabelSpacing: 0,
        extendedPadding: const EdgeInsets.only(left: 17.0),
        onPressed: () {
          print('Find nearby friends screen');
        },
      ),
    );
  }
}
