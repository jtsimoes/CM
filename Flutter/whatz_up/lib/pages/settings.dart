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
            leading: const Icon(Icons.language),
            title: const LocaleText('settings_language'),
            subtitle: switch (Locales.currentLocale(context).toString()) {
              'en' => const Text("English (United States)"),
              'pt' => const Text("Português (Portugal)"),
              'es' => const Text("Español (España)"),
              'fr' => const Text("Français (France)"),
              'it' => const Text("Italiano (Italia)"),
              'de' => const Text("Deutsch (Deutschland)"),
              'ru' => const Text("Русский (Россия)"),
              'ja' => const Text("日本語 (日本)"),
              'zh' => const Text("中文 (中国)"),
              _ => null,
            },
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: const Text('Select language'),
                    children: <Widget>[
                      SimpleDialogOption(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        onPressed: () {
                          Locales.change(context, 'en');
                          context.pop();
                        },
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'en',
                              groupValue:
                                  Locales.currentLocale(context).toString(),
                              onChanged: null,
                            ),
                            const Text('English (United States)'),
                          ],
                        ),
                      ),
                      SimpleDialogOption(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        onPressed: () {
                          Locales.change(context, 'pt');
                          context.pop();
                        },
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'pt',
                              groupValue:
                                  Locales.currentLocale(context).toString(),
                              onChanged: null,
                            ),
                            const Text('Português (Portugal)'),
                          ],
                        ),
                      ),
                      SimpleDialogOption(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        onPressed: () {
                          Locales.change(context, 'es');
                          context.pop();
                        },
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'es',
                              groupValue:
                                  Locales.currentLocale(context).toString(),
                              onChanged: null,
                            ),
                            const Text('Español (España)'),
                          ],
                        ),
                      ),
                      SimpleDialogOption(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        onPressed: () {
                          Locales.change(context, 'fr');
                          context.pop();
                        },
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'fr',
                              groupValue:
                                  Locales.currentLocale(context).toString(),
                              onChanged: null,
                            ),
                            const Text('Français (France)'),
                          ],
                        ),
                      ),
                      SimpleDialogOption(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        onPressed: () {
                          Locales.change(context, 'it');
                          context.pop();
                        },
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'it',
                              groupValue:
                                  Locales.currentLocale(context).toString(),
                              onChanged: null,
                            ),
                            const Text('Italiano (Italia)'),
                          ],
                        ),
                      ),
                      SimpleDialogOption(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        onPressed: () {
                          Locales.change(context, 'de');
                          context.pop();
                        },
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'de',
                              groupValue:
                                  Locales.currentLocale(context).toString(),
                              onChanged: null,
                            ),
                            const Text('Deutsch (Deutschland)'),
                          ],
                        ),
                      ),
                      SimpleDialogOption(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        onPressed: () {
                          Locales.change(context, 'ru');
                          context.pop();
                        },
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'ru',
                              groupValue:
                                  Locales.currentLocale(context).toString(),
                              onChanged: null,
                            ),
                            const Text('Русский (Россия)'),
                          ],
                        ),
                      ),
                      SimpleDialogOption(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        onPressed: () {
                          Locales.change(context, 'ja');
                          context.pop();
                        },
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'ja',
                              groupValue:
                                  Locales.currentLocale(context).toString(),
                              onChanged: null,
                            ),
                            const Text('日本語 (日本)'),
                          ],
                        ),
                      ),
                      SimpleDialogOption(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        onPressed: () {
                          Locales.change(context, 'zh');
                          context.pop();
                        },
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'zh',
                              groupValue:
                                  Locales.currentLocale(context).toString(),
                              onChanged: null,
                            ),
                            const Text('中文 (中国)'),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
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
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WallpaperOption(wallpaper: 'none'),
                        WallpaperOption(wallpaper: 'clouds'),
                        WallpaperOption(wallpaper: 'doodles'),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WallpaperOption(wallpaper: 'flutter'),
                        WallpaperOption(wallpaper: 'space'),
                        WallpaperOption(wallpaper: 'water'),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
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
      padding: const EdgeInsets.symmetric(vertical: 5),
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
