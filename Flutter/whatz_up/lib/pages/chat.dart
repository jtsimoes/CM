import 'package:whatz_up/utils/globals.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, String? userId}) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();
              },
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: const CircleAvatar(
                child: Text(
                    'A'), // Replace with actual user's initials or profile picture
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'User A', // Replace with actual user's name
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Last seen today at 12:46', // "Last seen today at 12:46" or "Online"
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            visualDensity: const VisualDensity(horizontal: -4.0, vertical: 0.0),
            icon: const Icon(Icons.videocam),
            tooltip: 'Video call',
            onPressed: () {
              // TODO: Implement video call functionality
            },
          ),
          IconButton(
            visualDensity: const VisualDensity(horizontal: -2.0, vertical: 0.0),
            icon: const Icon(Icons.call),
            tooltip: 'Call',
            onPressed: () {
              // TODO: Implement voice call functionality
            },
          ),
          PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: "View contact",
                  child: Text("View contact"),
                ),
                const PopupMenuItem(
                  value: "Media, links, and docs",
                  child: Text("Media, links, and docs"),
                ),
                const PopupMenuItem(
                  value: "Search",
                  child: Text("Search"),
                ),
                const PopupMenuItem(
                  value: "Mute notifications",
                  child: Text("Mute notifications"),
                ),
                const PopupMenuItem(
                  value: "Disapearing messages",
                  child: Text("Disapearing messages"),
                ),
                const PopupMenuItem(
                  value: "Wallpaper",
                  child: Text("Wallpaper"),
                ),
              ];
            },
          )
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                opacity: 0.5,
                image: AssetImage(
                    "assets/wallpapers/${profileBox.get('wallpaper', defaultValue: 'doodles')}.jpg"),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: <Widget>[
                  DateChip(
                    date: DateTime(now.year, now.month, now.day - 2),
                  ),
                  BubbleNormalImage(
                    id: 'id001',
                    image: _image(),
                    color: const Color(0xFF015146),
                    tail: false,
                    seen: true,
                  ),
                  DateChip(
                    date: DateTime(now.year, now.month, now.day - 1),
                  ),
                  const BubbleSpecialTwo(
                    text: 'bubble special one with tail',
                    color: Color(0xFF015146),
                    tail: false,
                    sent: true,
                    delivered: true,
                    seen: true,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  const BubbleSpecialOne(
                    text: 'bubble special one without tail',
                    isSender: false,
                    tail: false,
                    color: Color(0xFF36353a),
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const BubbleSpecialOne(
                    text: 'Message seen',
                    tail: false,
                    color: Color(0xFF015146),
                    sent: true,
                    delivered: true,
                    seen: true,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  const BubbleSpecialOne(
                    text: 'Message delivered',
                    tail: false,
                    color: Color(0xFF015146),
                    sent: true,
                    delivered: true,
                    seen: false,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  const BubbleSpecialOne(
                    text: 'Message sent',
                    tail: false,
                    color: Color(0xFF015146),
                    sent: true,
                    delivered: false,
                    seen: false,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  DateChip(
                    date: now,
                  ),
                  const BubbleSpecialOne(
                    text: 'Another one',
                    tail: false,
                    color: Color(0xFF015146),
                    sent: true,
                    delivered: false,
                    seen: false,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  const BubbleSpecialOne(
                    text: 'And another one',
                    tail: false,
                    color: Color(0xFF015146),
                    sent: true,
                    delivered: false,
                    seen: false,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  const BubbleSpecialOne(
                    text: 'DJ Khaled',
                    tail: false,
                    color: Color(0xFF36353a),
                    isSender: false,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
            MessageBar(
              messageBarColor: Colors.black,
              sendButtonColor: Colors.greenAccent,
              messageBarHintStyle: const TextStyle(color: Colors.grey),
              messageBarHitText: ' Message',
              onSend: (_) => {print(_), _scrollToBottom()},
              actions: [
                InkWell(
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                  onTap: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    child: const Icon(
                      Icons.emoji_emotions,
                      color: Colors.white,
                      size: 24,
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _image() {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 20.0,
        minWidth: 20.0,
      ),
      child: CachedNetworkImage(
        imageUrl: 'https://pbs.twimg.com/media/E1nWxAQXMA8RZNY.jpg',
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  // Call this method after adding a new message to the chat
  void _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }
}
