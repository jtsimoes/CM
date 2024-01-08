import 'package:whatz_up/utils/globals.dart';

import 'package:url_launcher/url_launcher.dart';

class Call {
  final String userName;
  final String timestamp;
  final String callType;
  final String callMode;

  Call(this.userName, this.timestamp, this.callType, this.callMode);
}

final List<Call> callHistory = [
  Call('Ana Santos', 'January 5, 13:53', 'in', 'voice'),
  Call('Miguel Pereira', 'January 2, 16:28', 'out', 'video'),
  Call('Diogo Oliveira', 'December 21, 23:49', 'out', 'video'),
  Call('Pedro Rodrigues', 'December 18, 19:01', 'in', 'video'),
  Call('Sofia Fernandes', 'October 3, 10:33', 'in', 'voice'),
  Call('Francisco Almeida', 'September 10, 22:22', 'in', 'voice'),
  Call('Maria Sousa', 'July 22, 22:22', 'out', 'video'),
  Call('Inês Costa', 'July 11, 11:11', 'in', 'video'),
  Call('Carolina Martins', 'June 29, 01:29', 'out', 'voice'),
  Call('Guilherme Santos', 'May 02, 23:59', 'out', 'video'),
  Call('João Silva', 'April 01, 12:34', 'in', 'voice'),
  Call('Luís Pereira', 'March 03, 00:01', 'in', 'video'),
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
              child: Text(callHistory[index].userName[0]),
            ),
            title: Text(callHistory[index].userName),
            subtitle: Row(
              children: <Widget>[
                callHistory[index].callType == 'out'
                    ? const Icon(Icons.call_made, color: Colors.green, size: 15)
                    : const Icon(Icons.call_received,
                        color: Colors.red, size: 15),
                const SizedBox(width: 4),
                Text(
                  callHistory[index].timestamp,
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.outline),
                ),
              ],
            ),
            trailing: callHistory[index].callMode == 'voice'
                ? const Icon(Icons.call)
                : const Icon(Icons.videocam),
            onTap: () {
              context.push('/call/${callHistory[index].userName}');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Dial number',
        child: const Icon(Icons.dialpad),
        onPressed: () async {
          final Uri launchUri = Uri(scheme: 'tel');
          if (!await launchUrl(launchUri)) {
            throw Exception('Could not launch phone dialer app');
          }
        },
      ),
    );
  }
}
