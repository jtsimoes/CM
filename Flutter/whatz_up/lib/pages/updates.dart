import 'package:whatz_up/utils/globals.dart';

class Status {
  final String userInitials;
  final String userName;

  Status(this.userInitials, this.userName);
}

class StatusPage extends StatelessWidget {
  StatusPage({Key? key}) : super(key: key);

  final List<Status> statusUpdates = [
    Status('1', 'User 1'),
    Status('B', 'User 2'),
    // Add more status updates here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Add this line
        children: [
          const Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text('Status', style: TextStyle(fontSize: 24)),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: statusUpdates.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(statusUpdates[index].userInitials),
                  ),
                  title: Text(statusUpdates[index].userName),
                  onTap: () {
                    context.push('/story');
                  },
                );
              },
            ),
          ),
          const Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text('Channels', style: TextStyle(fontSize: 24)),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(
                'Channels content goes here'), // Replace this with your channels widget
          ),
        ],
      ),
    );
  }
}
