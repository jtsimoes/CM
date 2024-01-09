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
  final TextEditingController messageController = TextEditingController();
  List<Message> messages = [];
  SessionState connectionStatus = SessionState.connected;

  void scrollToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
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

    receivedDataSubscription.cancel();

    subscription = nearbyService.stateChangedSubscription(
      callback: (devicesList) {
        Device device = devicesList.firstWhere(
            (element) => element.deviceId == widget.device!.deviceId);
        setState(() {
          connectionStatus = device.state;
        });
        showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
            icon: const Icon(Icons.speaker_notes_off, size: 40),
            title: Text('${device.deviceName} has disconnected'),
            content: Text(
              "The connection to ${device.deviceName}'s device has been closed. \nYou can no longer send nearby messages to this chat.",
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
                onPressed: () => context.go('/'),
                child: const Text('Exit'),
              ),
            ],
          ),
        );
      },
    );

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
                Text(
                  switch (connectionStatus) {
                    SessionState.notConnected => "Disconnected",
                    SessionState.connecting => "Reconnecting...",
                    _ => "Connected",
                  },
                  style: const TextStyle(
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
              child: Column(
                children: <Widget>[
                  DateChip(date: now),
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
                    height: 80,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Insert an emoji',
              icon: const Icon(Icons.emoji_emotions),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                controller: messageController,
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primaryContainer),
                minimumSize: MaterialStateProperty.all(const Size(45, 45)),
              ),
              tooltip: 'Send a message',
              icon: const Icon(Icons.send),
              onPressed: () {
                if (widget.device!.state != SessionState.connected) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      showCloseIcon: true,
                      content: Text(
                          "You can no longer send messages to this chat because you are no longer near each other."),
                    ),
                  );
                }
                if (messageController.text.isEmpty) return;
                String message = messageController.text;
                nearbyService.sendMessage(widget.device!.deviceId, message);
                setState(() {
                  messages.add(Message(message, true));
                });
                scrollToBottom();
                messageController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
