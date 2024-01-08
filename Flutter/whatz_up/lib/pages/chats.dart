import 'package:whatz_up/utils/globals.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

enum DeviceType { advertiser, browser }

enum MessageStatus { sent, delivered, read }

class Chat {
  final String userName;
  final String lastMessage;
  final String timestamp;
  final bool isUnread;
  final MessageStatus? status;

  Chat(this.userName, this.lastMessage, this.timestamp, this.isUnread,
      [this.status]);
}

final List<Chat> chatHistory = [
  Chat('Pedro Duarte', "Hey, I'm ready for the presentation! Lets go? 💪",
      '11:24', false),
  Chat('Nuno Oliveira', "We really need to go again 🔙", 'Yesterday', true),
  Chat('António Mendes', "bye see ya", 'Yesterday', false, MessageStatus.sent),
  Chat('Amélia Costa', "this concert is really amazing, im loving it",
      '06/01/2024', false),
  Chat('Margarida Veloso', "Thanks for the help!! ❤️", '04/01/2024', false),
  Chat('Carolina Patrocínio', "HAPPY NEW YEAR 🎉🎊", '01/01/2024', false,
      MessageStatus.delivered),
  Chat('Martim Silva', "u too", '30/12/2023', false, MessageStatus.read),
  Chat('Alexandre Teixeira', "Merry Xmas :)", '25/12/2023', false),
  Chat('Ana Lopes', "happy christmas 🎅🏻🎄", '23/12/2023', false,
      MessageStatus.read),
  Chat('Miguel Oliveira', "yo yo, whats up? all good dude?", '03/12/2023',
      false),
  Chat('Alice Pereira', "i'm starving, lets eat after this?", '01/12/2023',
      false),
  Chat('Afonso Silva', "Any recommendations for the nextt one?", '15/11/2023',
      false),
  Chat('Leonor Rodrigues', "Ok", '22/10/2023', false, MessageStatus.read),
  Chat('Mariana Coito', "we'll be back next year, no worries", '10/10/2023',
      false, MessageStatus.read),
];

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  ChatsPageState createState() => ChatsPageState();
}

class ChatsPageState extends State<ChatsPage> {
  final ScrollController scrollController = ScrollController();
  bool _isExtended = true;
  List<Device> devices = [];
  List<Device> connectedDevices = [];

  DeviceType deviceType = DeviceType.advertiser;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    init();
  }

  @override
  void dispose() {
    /*subscription.cancel();
    receivedDataSubscription.cancel();
    nearbyService.stopBrowsingForPeers();
    nearbyService.stopAdvertisingPeer();*/
    scrollController.dispose();
    super.dispose();
  }

  scrollListener() {
    if (scrollController.offset >= 50) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Nearby chats',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Visibility(
            visible: getItemCount() == 0 && deviceType == DeviceType.browser,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                      width: 25,
                      child: Center(
                          child: CircularProgressIndicator(strokeWidth: 3)),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Looking for nearby friends to chat with...',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: getItemCount() == 0 && deviceType == DeviceType.advertiser,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Text(
                  'You are not connected to any nearby friends yet.',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
            ),
          ),
          SizedBox(
            child: ListView.builder(
              itemCount: getItemCount(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final device = deviceType == DeviceType.advertiser
                    ? connectedDevices[index]
                    : devices[index];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text(device.deviceName[0]),
                      ),
                      title: Text(device.deviceName),
                      subtitle: Text(
                        getStateName(device.state),
                        style: TextStyle(color: getStateColor(device.state)),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () => _onButtonClicked(device),
                        style: ElevatedButton.styleFrom(
                          //backgroundColor: Theme.of(context).colorScheme.errorContainer,
                          backgroundColor: getButtonColor(device
                              .state), //Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: Text(getButtonStateName(device.state)),
                      ),
                      onTap: () => context.push('/nearby', extra: device),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              'Chat history',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: chatHistory.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(chatHistory[index].userName[0]),
                  ),
                  title: Text(
                    chatHistory[index].userName,
                    style: TextStyle(
                      fontWeight: chatHistory[index].isUnread
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      switch (chatHistory[index].status) {
                        MessageStatus.sent => const Padding(
                            padding: EdgeInsets.only(right: 3),
                            child: Icon(Icons.done, size: 15)),
                        MessageStatus.delivered => const Padding(
                            padding: EdgeInsets.only(right: 3),
                            child: Icon(Icons.done_all, size: 15)),
                        MessageStatus.read => const Padding(
                            padding: EdgeInsets.only(right: 3),
                            child: Icon(Icons.done_all,
                                size: 15, color: Colors.lightBlueAccent)),
                        _ => const SizedBox(),
                      },
                      Expanded(
                        child: Text(
                          chatHistory[index].lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: chatHistory[index].isUnread
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(chatHistory[index].timestamp),
                      if (chatHistory[index].isUnread)
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100))),
                          alignment: Alignment.center,
                          height: 18,
                          width: 18,
                          child: const Text(
                            '1',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onTap: () =>
                      context.push('/chat/${chatHistory[index].userName}'),
                  onLongPress: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          icon: const Icon(Icons.delete, size: 40),
                          title: const Text('Delete this chat?'),
                          content: const SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                    'Are you sure you want to delete this chat?'),
                                SizedBox(height: 2),
                                Text('This action cannot be undone.'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: const Text('Cancel'),
                              onPressed: () {
                                context.pop();
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.onError,
                              ),
                              child: const Text('Delete'),
                              onPressed: () {
                                setState(() {
                                  chatHistory.removeAt(index);
                                });
                                context.pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: deviceType == DeviceType.advertiser,
        child: FloatingActionButton.extended(
          tooltip: 'Find nearby friends',
          icon: Padding(
            padding: _isExtended
                ? const EdgeInsets.all(0)
                : const EdgeInsets.only(right: 9.0),
            child: const Icon(Icons.person_search),
          ),
          label: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                child: _isExtended
                    ? const Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Text('Find nearby friends'),
                      )
                    : const Padding(padding: EdgeInsets.all(0))),
          ),
          extendedIconLabelSpacing: 0,
          extendedPadding: const EdgeInsets.only(left: 17.0),
          onPressed: () {
            subscription.cancel();
            receivedDataSubscription.cancel();
            nearbyService.stopBrowsingForPeers();
            nearbyService.stopAdvertisingPeer();
            setState(() {
              deviceType = DeviceType.browser;
            });
            init();
          },
        ),
      ),
    );
  }

  String getStateName(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
        return "disconnected";
      case SessionState.connecting:
        return "waiting";
      default:
        return "connected";
    }
  }

  String getButtonStateName(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
        return "Connect";
      case SessionState.connecting:
        return "Connecting";
      default:
        return "Disconnect";
    }
  }

  Color getStateColor(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
        return Colors.black;
      case SessionState.connecting:
        return Colors.grey;
      default:
        return Colors.green;
    }
  }

  Color getButtonColor(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
      case SessionState.connecting:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  int getItemCount() {
    if (deviceType == DeviceType.advertiser) {
      return connectedDevices.length;
    } else {
      return devices.length;
    }
  }

  _onButtonClicked(Device device) {
    switch (device.state) {
      case SessionState.notConnected:
        nearbyService.invitePeer(
          deviceID: device.deviceId,
          deviceName: device.deviceName,
        );
        break;
      case SessionState.connected:
        nearbyService.disconnectPeer(deviceID: device.deviceId);
        break;
      case SessionState.connecting:
        break;
    }
  }

  void init() async {
    nearbyService = NearbyService();
    String devInfo = profileBox.get('name', defaultValue: 'João Tomás')!;
    await nearbyService.init(
        serviceType: 'mpconn',
        deviceName: devInfo,
        strategy: Strategy.P2P_CLUSTER,
        callback: (isRunning) async {
          if (isRunning) {
            if (deviceType == DeviceType.browser) {
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(const Duration(microseconds: 200));
              await nearbyService.startBrowsingForPeers();
            } else {
              await nearbyService.stopAdvertisingPeer();
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(const Duration(microseconds: 200));
              await nearbyService.startAdvertisingPeer();
              await nearbyService.startBrowsingForPeers();
            }
          }
        });
    subscription =
        nearbyService.stateChangedSubscription(callback: (devicesList) {
      for (var element in devicesList) {
        if (element.state == SessionState.connected) {
          nearbyService.stopBrowsingForPeers();
        } else {
          nearbyService.startBrowsingForPeers();
        }
      }

      setState(() {
        devices.clear();
        devices.addAll(devicesList);
        connectedDevices.clear();
        connectedDevices.addAll(devicesList
            .where((d) => d.state == SessionState.connected)
            .toList());
      });
    });

    receivedDataSubscription =
        nearbyService.dataReceivedSubscription(callback: (data) {
      null;
    });
  }
}
