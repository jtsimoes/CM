import 'package:whatz_up/utils/globals.dart';

import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

class Message {
  final String text;
  final bool isSender;

  Message(this.text, this.isSender);
}

class NearbyChatPage extends StatefulWidget {
  final Device? device;

  const NearbyChatPage({Key? key, this.device}) : super(key: key);

  @override
  NearbyChatPageState createState() => NearbyChatPageState();
}

class NearbyChatPageState extends State<NearbyChatPage> {
  final ScrollController scrollController = ScrollController();
  List<Message> messages = [];

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 50,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
  }

  @override
  void dispose() {
    subscription.cancel();
    receivedDataSubscription.cancel();
    nearbyService.stopBrowsingForPeers();
    nearbyService.stopAdvertisingPeer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    receivedDataSubscription = nearbyService.dataReceivedSubscription(
      callback: (data) {
        if (settingsBox.get('notifications', defaultValue: true) == true) {
          NotificationService.showNewMessageNotification(
            title: widget.device!.deviceName,
            body: data['message'],
            fln: flutterLocalNotificationsPlugin,
          );
        }
        setState(() {
          messages.add(Message(data['message'], false));
        });
        scrollToBottom();
      },
    );

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
                child: Text(widget.device!.deviceName[0]),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.device!.deviceName,
                  style: const TextStyle(fontSize: 18),
                ),
                const Text(
                  "Online",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
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
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.only(bottom: 60),
              child: Column(
                children: <Widget>[
                  DateChip(
                    date: now,
                  ),
                  ...messages
                      .map((message) => BubbleSpecialOne(
                            text: message.text,
                            isSender: message.isSender,
                            tail: false,
                            color: message.isSender
                                ? const Color(0xFF015146)
                                : const Color(0xFF36353a),
                            sent: message.isSender,
                            delivered: message.isSender,
                            seen: message.isSender,
                            textStyle: const TextStyle(color: Colors.white),
                          ))
                      .toList(),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
            MessageBar(
              messageBarColor: Colors.black,
              sendButtonColor: const Color(0xFF015146),
              messageBarHintStyle: const TextStyle(color: Colors.grey),
              messageBarHitText: ' Message',
              onSend: (message) {
                nearbyService.sendMessage(widget.device!.deviceId, message);
                setState(() {
                  messages.add(Message(message, true));
                });
                scrollToBottom();
              },
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
}
