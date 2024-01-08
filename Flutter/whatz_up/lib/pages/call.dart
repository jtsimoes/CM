import 'dart:async';
import 'dart:math';

import 'package:whatz_up/utils/globals.dart';

class CallPage extends StatefulWidget {
  final String? userId;

  const CallPage({Key? key, this.userId}) : super(key: key);

  @override
  CallPageState createState() => CallPageState();
}

class CallPageState extends State<CallPage> {
  String duration = 'Calling...';
  Stopwatch stopwatch = Stopwatch();
  Timer? timer;

  String part1 = Random().nextInt(1000).toString().padLeft(3, '0');
  String part2 = Random().nextInt(1000).toString().padLeft(3, '0');

  void showCallDuration() {
    if (stopwatch.isRunning) {
      setState(() {
        duration = stopwatch.elapsed.toString().split('.')[0];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    stopwatch.start();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => showCallDuration(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (settingsBox.get('notifications', defaultValue: true) == true) {
      NotificationService.showOngoingCallNotification(
        title: widget.userId!,
        body: 'Ongoing call',
        fln: flutterLocalNotificationsPlugin,
      );
    }
    String phoneNumber = "(+351) 967 $part1 $part2";
    return WillPopScope(
      onWillPop: () async {
        flutterLocalNotificationsPlugin.cancel(69);
        return true;
      },
      child: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  opacity: 0.5,
                  image: AssetImage(
                      "assets/wallpapers/${profileBox.get('wallpaper', defaultValue: 'doodles')}.jpg"),
                  fit: BoxFit.cover)),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock, color: Colors.grey, size: 16),
                    Text("  End-to-end encrypted call",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/media/avatar.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                        child: Text(
                          widget.userId!,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          phoneNumber,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Text(
                        duration,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: BottomSheet(
          onClosing: () {},
          enableDrag: false,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.2,
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  tooltip: 'Enable speaker',
                  onPressed: () {},
                  icon: const Icon(
                    Icons.volume_up,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  tooltip: 'Enable video',
                  onPressed: () {},
                  icon: const Icon(
                    Icons.videocam,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                IconButton(
                  tooltip: 'Disable microphone',
                  onPressed: () {},
                  icon: const Icon(
                    Icons.mic_off,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(255, 0, 0, 1)),
                    shape: MaterialStateProperty.all(
                      const CircleBorder(),
                    ),
                    minimumSize: MaterialStateProperty.all(const Size(50, 50)),
                  ),
                  tooltip: 'End call',
                  onPressed: () {
                    flutterLocalNotificationsPlugin.cancel(69);
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.call_end,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
