import 'package:whatz_up/utils/globals.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  bool darkMode = true;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();
              },
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text("Settings"),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.key),
            title: const Text("Account"),
            subtitle: const Text(
                "Security notifications, two-step verification, change number"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Privacy"),
            subtitle:
                const Text("Last seen, block contacts, disappearing messages"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            subtitle: const Text("English (device's language)"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.wallpaper),
            title: const Text("Wallpaper"),
            onTap: () {},
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            value: notifications,
            onChanged: (bool value) {
              setState(() {
                notifications = value;
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.font_download_outlined),
            title: const Text("Font size"),
            subtitle: const Text("Medium"),
            onTap: () {},
          ),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text("Dark mode"),
            value: darkMode,
            onChanged: (bool value) {
              setState(() {
                darkMode = value;
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text("Chat backup"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("Help"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationVersion: 'v1.0.0',
                applicationIcon:
                    Image.asset('logos/logo.png', width: 90, height: 90),
                applicationLegalese: '© 2023 João Simões (88930)',
                children: const [
                  Text(
                      "\nWhatzUp is a social media app inspired on WhatsApp, but specifically for connecting people at social events."),
                  Text(
                      "\nThis app was developed as a Flutter project for the Mobile Computing course at the University of Aveiro.",
                      style: TextStyle(color: Colors.white60)),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
