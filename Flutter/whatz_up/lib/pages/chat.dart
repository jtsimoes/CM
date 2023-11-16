import 'package:whatz_up/utils/globals.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, String? id}) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = const Duration();
  Duration position = const Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;

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
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.go('/');
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              child: const CircleAvatar(
                child: Text(
                    'A'), // Replace with actual user's initials or profile picture
              ),
            ),
          ],
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User A'), // Replace with actual user's name
              Text(
                'Online', // "Last seen today at 10:00" or "Online"
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.videocam),
            tooltip: 'Video call',
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.call),
            tooltip: 'Call',
            onPressed: () {
              // TODO: Implement more options functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'More options',
            onPressed: () {
              // Create a dropdown menu with the following options:
              // New group, New broadcast, WhatsApp Web, Starred messages,
              // Settings, and Log out
            },
          ),
        ],
      ),
      body: Stack(
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
                BubbleNormalAudio(
                  color: const Color(0xFF015146),
                  duration: duration.inSeconds.toDouble(),
                  position: position.inSeconds.toDouble(),
                  isPlaying: isPlaying,
                  isLoading: isLoading,
                  isPause: isPause,
                  onSeekChanged: _changeSeek,
                  onPlayPauseButtonClick: _playAudio,
                  tail: false,
                  seen: true,
                  textStyle: const TextStyle(color: Colors.white, fontSize: 10),
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
    );
  }

  Widget _image() {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 20.0,
        minWidth: 20.0,
      ),
      child: CachedNetworkImage(
        imageUrl:
            'https://i0.wp.com/bhutanio.com/wp-content/uploads/2021/11/IMG-20210826-WA0000-edited.webp?fit=720%2C720&ssl=1',
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  void _changeSeek(double value) {
    setState(() {
      audioPlayer.seek(Duration(seconds: value.toInt()));
    });
  }

  void _playAudio() async {
    const url = 'https://samples-files.com/samples/Audio/mp3/sample-file-4.mp3';
    if (isPause) {
      await audioPlayer.resume();
      setState(() {
        isPlaying = true;
        isPause = false;
      });
    } else if (isPlaying) {
      await audioPlayer.pause();
      setState(() {
        isPlaying = false;
        isPause = true;
      });
    } else {
      setState(() {
        isLoading = true;
      });
      await audioPlayer.play(UrlSource(url));
      setState(() {
        isPlaying = true;
      });
    }

    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
        isLoading = false;
      });
    });
    audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    });
    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        duration = const Duration();
        position = const Duration();
      });
    });
  }

  // Call this method after adding a new message to the chat
  void _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }
}
