import 'package:whatz_up/utils/globals.dart';

enum MessageStatus { sent, delivered, read }

class ChatPage extends StatefulWidget {
  final String? userId;

  const ChatPage({Key? key, this.userId}) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
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
              child: CircleAvatar(
                child: Text(widget.userId![0]),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.userId!,
                  style: const TextStyle(fontSize: 18),
                ),
                const Text(
                  'Last seen today at 11:24',
                  style: TextStyle(color: Colors.white54, fontSize: 11),
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
              context.push('/call/${widget.userId}');
            },
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
            visualDensity: const VisualDensity(horizontal: -2.0, vertical: 0.0),
            icon: const Icon(Icons.call),
            tooltip: 'Call',
            onPressed: () {
              context.push('/call/${widget.userId}');
            },
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              opacity: 0.5,
              image: AssetImage(
                  "assets/wallpapers/${profileBox.get('wallpaper', defaultValue: 'doodles')}.jpg"),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: <Widget>[
              DateChip(date: DateTime(now.year, now.month - 1, now.day - 16)),
              const TextMessage(
                text: 'look a this Flutter meme 😂😂',
                status: MessageStatus.read,
              ),
              BubbleNormalImage(
                id: 'id001',
                image: imageMessage(
                    'https://pbs.twimg.com/media/E1nWxAQXMA8RZNY.jpg'),
                color: const Color(0xFF015146),
                tail: false,
                seen: true,
              ),
              const TextMessage(text: 'AHAHAHAHAHAHA \nLove it 🤣'),
              DateChip(date: DateTime(now.year, now.month, now.day - 2)),
              const TextMessage(
                  text:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur dui est, pretium id velit vestibulum, vulputate tristique odio. Aliquam erat volutpat. Pellentesque nec tristique leo. Proin sit amet magna sollicitudin dui vulputate placerat. Sed ut purus massa. Mauris laoreet eros nec hendrerit ullamcorper. Sed et enim ac mauris elementum consectetur.'),
              const TextMessage(text: '???', status: MessageStatus.read),
              const TextMessage(text: "Nevermind, it's just a test 😅"),
              DateChip(date: DateTime(now.year, now.month, now.day - 1)),
              const TextMessage(
                text: 'hey, how are you doing?',
                status: MessageStatus.read,
              ),
              const TextMessage(
                text: 'I hope you are fine',
                status: MessageStatus.read,
              ),
              const TextMessage(text: 'I am fine, thanks for asking!'),
              const TextMessage(text: 'What about you?'),
              const TextMessage(
                text:
                    "i am fine too, thanks!\ni'm just testing our project app ;)",
                status: MessageStatus.read,
              ),
              const TextMessage(
                  text:
                      'So far, it seems to be working \njust fine. LGTM! What do you think?'),
              const TextMessage(
                text: "i think it's finished 😎",
                status: MessageStatus.read,
              ),
              const TextMessage(
                text: "and ready to be delivered 🚀",
                status: MessageStatus.read,
              ),
              const TextMessage(
                text: "Nice nice! Towards an 💯 grade!!",
              ),
              DateChip(date: now),
              BubbleNormalImage(
                id: 'id002',
                image: imageMessage(
                    'https://api-assets.ua.pt/v1/image/resizer?imageUrl=https%3A%2F%2Fapi-assets.ua.pt%2Ffiles%2Fimgs%2F000%2F005%2F602%2Foriginal.jpg&width=1280'),
                color: const Color(0xFF36353a),
                tail: false,
                seen: true,
                isSender: false,
              ),
              const TextMessage(
                  text: "Hey, I'm ready for the presentation! Lets go? 💪"),
              const SizedBox(
                height: 90,
              )
            ],
          ),
        ),
      ),
      bottomSheet: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Text(
                "You can no longer send messages to this chat because you are no longer near each other.",
                style: TextStyle(color: Colors.white54),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageMessage(String url) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 20.0,
        minWidth: 20.0,
      ),
      child: CachedNetworkImage(
        imageUrl: url,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  void scrollToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }
}

class TextMessage extends StatelessWidget {
  final String text;
  final MessageStatus? status;

  const TextMessage({Key? key, required this.text, this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status != null) {
      return BubbleSpecialOne(
        text: text,
        color: const Color(0xFF015146),
        tail: false,
        sent: status == MessageStatus.sent,
        delivered: status == MessageStatus.delivered,
        seen: status == MessageStatus.read,
        textStyle: const TextStyle(color: Colors.white),
      );
    } else {
      return BubbleSpecialOne(
        isSender: false,
        text: text,
        color: const Color(0xFF36353a),
        tail: false,
        textStyle: const TextStyle(color: Colors.white),
      );
    }
  }
}
