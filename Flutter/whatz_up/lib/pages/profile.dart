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

  File? image;

  Future pickAvatar(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.text = profileBox.get('name', defaultValue: 'João Tomás')!;
    bioController.text =
        profileBox.get('bio', defaultValue: 'Hey there! I am using WhatzUp!')!;
    phoneController.text =
        profileBox.get('phone', defaultValue: '+351 960 960 960')!;
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    phoneController.dispose();
    super.dispose();
  }

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
          Center(
            child: Stack(
              children: <Widget>[
                ClipOval(
                  child: image != null
                      ? Image.file(
                          image!,
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          profileBox.get('avatar',
                              defaultValue: 'assets/media/avatar.png')!,
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  right: 0,
                  top: 130,
                  child: IconButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.onPrimary)),
                      icon: const Icon(Icons.camera_alt),
                      iconSize: 18,
                      onPressed: () => showModalBottomSheet(
                            showDragHandle: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 0),
                                height:
                                    MediaQuery.of(context).size.height * 0.28,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Profile avatar',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                    const SizedBox(height: 25),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: IconButton(
                                                onPressed: () {
                                                  pickAvatar(
                                                      ImageSource.camera);
                                                  context.pop();
                                                },
                                                icon: const Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 12.0),
                                            Text(
                                              'Camera',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    color: Colors.grey,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 35),
                                        Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: IconButton(
                                                onPressed: () {
                                                  pickAvatar(
                                                      ImageSource.gallery);
                                                  context.pop();
                                                },
                                                icon: const Icon(
                                                  Icons.insert_photo,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 12.0),
                                            Text(
                                              'Gallery',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    color: Colors.grey,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 35),
                                        Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    image = null;
                                                  });
                                                  context.pop();
                                                },
                                                icon: const Icon(
                                                  Icons.person_off,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 12.0),
                                            Text(
                                              'Default \navatar',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    color: Colors.grey,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
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
                        if (_formKey.currentState!.validate()) {
                          profileBox.put('name', nameController.text);
                          profileBox.put('bio', bioController.text);

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
                      child: const Text('Edit profile'),
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
