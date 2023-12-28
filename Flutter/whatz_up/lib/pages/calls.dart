import 'package:whatz_up/utils/globals.dart';

List<List<String>> callHistory = [
  // Avatar | Phone number | Timestamp | Incoming/outgoing call | Voice/video call]
  ['A', '(+351) 999 888 777', 'January 5, 13:53', 'in', 'voice'],
  ['B', '(+351) 666 555 444', 'January 2, 16:28', 'out', 'video'],
  ['C', '(+351) 333 222 111', 'December 21, 23:49', 'out', 'video'],
  ['D', '(+351) 987 654 321', 'December 18, 19:01', 'in', 'video'],
  ['E', '(+351) 960 000 000', 'October 3, 10:33', 'in', 'voice'],
];

class CallsPage extends StatelessWidget {
  const CallsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: callHistory.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(callHistory[index][0]),
            ),
            title: Text(callHistory[index][1]),
            subtitle: Row(
              children: <Widget>[
                callHistory[index][3] == 'out'
                    ? const Icon(Icons.call_made, color: Colors.green, size: 15)
                    : const Icon(Icons.call_received,
                        color: Colors.red, size: 15),
                const SizedBox(width: 4),
                Text(
                  callHistory[index][2],
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.outline),
                ),
              ],
            ),
            trailing: callHistory[index][4] == 'voice'
                ? const Icon(Icons.call)
                : const Icon(Icons.videocam), // Icon to initiate a call
            onTap: () {
              context.push('/call/${callHistory[index][1]}');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_call),
        onPressed: () {
          // TODO: Navigate to new call screen
        },
      ),
    );
  }
}
