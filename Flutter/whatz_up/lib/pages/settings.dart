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
              child: LocaleText('settings_title'),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.key),
            title: const LocaleText('settings_account'),
            subtitle: const LocaleText(
              'settings_account_description',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const LocaleText('settings_privacy'),
            subtitle: const LocaleText(
              'settings_privacy_description',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const LocaleText('settings_language'),
            subtitle: (Locales.currentLocale(context).toString() == 'en')
                ? const Text("English (United States)")
                : const Text("Português (Portugal)"),
            onTap: () {
              (Locales.currentLocale(context).toString() == 'en')
                  ? Locales.change(context, 'pt')
                  : Locales.change(context, 'en');
            },
          ),
          ListTile(
            leading: const Icon(Icons.wallpaper),
            title: const LocaleText('settings_wallpaper'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => Dialog.fullscreen(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Select wallpaper',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WallpaperOption(wallpaper: 'none'),
                        WallpaperOption(wallpaper: 'clouds'),
                        WallpaperOption(wallpaper: 'doodles'),
                        WallpaperOption(wallpaper: 'flutter'),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WallpaperOption(wallpaper: 'love'),
                        WallpaperOption(wallpaper: 'space'),
                        WallpaperOption(wallpaper: 'water'),
                        WallpaperOption(wallpaper: 'wood'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text('Back'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const LocaleText('settings_notifications'),
            value: settingsBox.get('notifications', defaultValue: false)!,
            onChanged: (bool value) {
              setState(() {
                settingsBox.put('notifications', value);
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.font_download_outlined),
            title: const LocaleText('settings_font_size'),
            subtitle: const LocaleText('settings_font_size_medium'),
            onTap: () {},
          ),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const LocaleText('settings_dark_mode'),
            value: settingsBox.get('darkMode', defaultValue: true)!,
            onChanged: (bool value) {
              setState(() {
                settingsBox.put('darkMode', value);
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const LocaleText(
              'settings_chat_backup',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const LocaleText('settings_help'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const LocaleText('settings_about'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationVersion: 'v1.0.0',
                applicationIcon: Image.asset(
                  'assets/logos/logo.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                applicationLegalese:
                    'João Simões (88930) \nPedro Duarte (97673) \n© 2023',
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

class WallpaperOption extends StatelessWidget {
  final String wallpaper;

  const WallpaperOption({
    Key? key,
    required this.wallpaper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool current =
        profileBox.get('wallpaper', defaultValue: 'doodles') == wallpaper;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            elevation: 10,
            shape: (current)
                ? RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary,
                        width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  )
                : null,
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                profileBox.put('wallpaper', wallpaper);
                context.pop();
              },
              child: Ink.image(
                width: 100,
                height: 200,
                image: AssetImage('assets/wallpapers/$wallpaper.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          if (current)
            Text(
              '${wallpaper[0].toUpperCase()}${wallpaper.substring(1)} \n(current)',
              textAlign: TextAlign.center,
            )
          else
            Text(
              '${wallpaper[0].toUpperCase()}${wallpaper.substring(1)}',
            ),
        ],
      ),
    );
  }
}
