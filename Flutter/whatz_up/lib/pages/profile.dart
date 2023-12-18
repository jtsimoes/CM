import 'package:whatz_up/utils/globals.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = boxProfile.get('name', defaultValue: 'João Tomás')!;
    bioController.text =
        boxProfile.get('bio', defaultValue: 'Hey there! I am using WhatzUp!')!;
    phoneController.text =
        boxProfile.get('phone', defaultValue: '+351 960 960 960')!;
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    nameController.dispose();
    bioController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

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
              child: Text("Profile"),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              const CircleAvatar(radius: 100, child: Text('JT')),
              Positioned(
                left: (MediaQuery.of(context).size.width / 2) + 45,
                bottom: 25,
                child: IconButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.onPrimary)),
                  icon: const Icon(Icons.camera_alt),
                  iconSize: 18,
                  onPressed: () {
                    // Handle your button tap here
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Name',
                    helperText:
                        'This is not your username or pin. This name will be visible to your WhatzUp contacts.',
                    helperMaxLines: 10,
                    icon: Icon(Icons.person),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter some text. Name cannot be empty.'
                        : null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: bioController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Bio',
                    icon: Icon(Icons.text_snippet),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter some text. Bio cannot be empty.'
                        : null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: phoneController,
                  enabled: false,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Phone number',
                      icon: Icon(Icons.phone),
                      helperText: 'You cannot change your phone number',
                      helperMaxLines: 10),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          print('Name: ${nameController.text}');
                          print('Bio: ${bioController.text}');
                          print('Phone: ${phoneController.text}');

                          boxProfile.put('name', nameController.text);
                          boxProfile.put('bio', bioController.text);

                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              showCloseIcon: true,
                              backgroundColor:
                                  Theme.of(context).colorScheme.tertiary,
                              content:
                                  const Text('Profile edited successfully!'),
                            ),
                          );
                        }
                      },
                      child: const Text('Edit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
