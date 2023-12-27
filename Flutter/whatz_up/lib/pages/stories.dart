import 'package:whatz_up/utils/globals.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({Key? key, String? userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Story>>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StoryViewDelegate(
              stories: snapshot.data,
            );
          }

          if (snapshot.hasError) {
            return const Text("ERROR");
          }

          return const Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
          );
        },
        future: fetchStories(),
      ),
    );
  }
}

class StoryViewDelegate extends StatefulWidget {
  final List<Story>? stories;

  const StoryViewDelegate({super.key, this.stories});

  @override
  StoryViewDelegateState createState() => StoryViewDelegateState();
}

class StoryViewDelegateState extends State<StoryViewDelegate> {
  // final StoryController controller = StoryController();
  // List<StoryItem> storyItems = [];

  String? when = "";

  @override
  void initState() {
    super.initState();
    for (var story in widget.stories!) {
      if (story.mediaType == MediaType.text) {
        // storyItems.add(
        //   StoryItem.text(
        //     title: story.caption!,
        //     backgroundColor: Colors.purpleAccent,
        //     duration: Duration(
        //       milliseconds: (story.duration! * 1000).toInt(),
        //     ),
        //   ),
        // );
      }

      if (story.mediaType == MediaType.image) {
        // storyItems.add(StoryItem.pageImage(
        //   url: story.media!,
        //   controller: controller,
        //   caption: story.caption,
        //   duration: Duration(
        //     milliseconds: (story.duration! * 1000).toInt(),
        //   ),
        // ));
      }

      if (story.mediaType == MediaType.video) {
        // storyItems.add(
        //   StoryItem.pageVideo(
        //     story.media!,
        //     controller: controller,
        //     duration: Duration(milliseconds: (story.duration! * 1000).toInt()),
        //     caption: story.caption,
        //   ),
        // );
      }
    }

    when = widget.stories![0].when;
  }

  Widget _buildProfileView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
              "https://avatars2.githubusercontent.com/u/5024388?s=460&u=d260850b9267cf89188499695f8bcf71e743f8a7&v=4"),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "User 1",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                when!,
                style: const TextStyle(
                  color: Colors.white38,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // StoryView(
        //   storyItems: storyItems,
        //   controller: controller,
        //   onComplete: () {
        //     context.pop();
        //   },
        //   onVerticalSwipeComplete: (v) {
        //     if (v == Direction.down) {
        //       context.pop();
        //     }
        //   },
        //   onStoryShow: (storyItem) {
        //     int pos = storyItems.indexOf(storyItem);

        //     // the reason for doing setState only after the first
        //     // position is becuase by the first iteration, the layout
        //     // hasn't been laid yet, thus raising some exception
        //     // (each child need to be laid exactly once)
        //     if (pos > 0) {
        //       setState(() {
        //         when = widget.stories![pos].when;
        //       });
        //     }
        //   },
        // ),
        Container(
          padding: const EdgeInsets.only(
            top: 48,
            left: 16,
            right: 16,
          ),
          child: _buildProfileView(),
        )
      ],
    );
  }
}
