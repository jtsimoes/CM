import 'package:http/http.dart' as http;
import 'dart:convert';

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

MediaType _translateType(String? type) {
  if (type == "image") {
    return MediaType.image;
  }

  if (type == "video") {
    return MediaType.video;
  }

  return MediaType.text;
}

Future<List<Story>> fetchStories() async {
  const uri =
      "https://raw.githubusercontent.com/blackmann/storyexample/master/lib/data/whatsapp.json";
  final response = await http.get(Uri.parse(uri));

  final data = jsonDecode(utf8.decode(response.bodyBytes))['data'];

  final res = data.map<Story>((it) {
    return Story(
        caption: it['caption'],
        media: it['media'],
        duration: double.parse(it['duration']),
        when: it['when'],
        mediaType: _translateType(it['mediaType']),
        color: it['color']);
  }).toList();

  return res;
}
