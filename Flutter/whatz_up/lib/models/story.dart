enum MediaType { image, video, text }

class Story {
  final MediaType? mediaType;
  final String? media;
  final double? duration;
  final String? caption;
  final String? when;
  final String? color;

  Story({
    this.mediaType,
    this.media,
    this.duration,
    this.caption,
    this.when,
    this.color,
  });
}

List<Map<String, dynamic>> data = [
  {
    "mediaType": "image",
    "media":
        "https://i2.wp.com/metro.co.uk/wp-content/uploads/2019/10/PRI_908365231.jpg?quality=90&strip=all&zoom=1&resize=644%2C360&ssl=1",
    "duration": "5.0",
    "caption": "Aww geez Rick. aww naaawwww",
    "when": "10 minutes ago",
    "color": ""
  },
  {
    "mediaType": "text",
    "media": "",
    "duration": "4.0",
    "caption": "Jesse pink man is totally underrated. This guy!! 😁😁😂😂",
    "when": "7 minutes ago",
    "color": "#d32f2f"
  },
  {
    "mediaType": "image",
    "media": "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
    "duration": "5.0",
    "caption": "I'm so happy. Today turned out to be the best. Woohhh!!🤣🤣",
    "when": "6 minutes ago",
    "color": ""
  },
  {
    "mediaType": "text",
    "media": "",
    "duration": "4.0",
    "caption":
        "I hope you enjoyed the stories. Now go ahead and add stories to your app with the story_view library.",
    "when": "just now",
    "color": "#ff8f00"
  }
];

List<Story> stories = data.map<Story>((item) {
  MediaType? type;
  switch (item['mediaType']) {
    case 'image':
      type = MediaType.image;
      break;
    case 'video':
      type = MediaType.video;
      break;
    case 'text':
      type = MediaType.text;
      break;
  }
  return Story(
    mediaType: type,
    media: item['media'],
    duration: double.parse(item['duration']),
    caption: item['caption'],
    when: item['when'],
    color: item['color'],
  );
}).toList();
