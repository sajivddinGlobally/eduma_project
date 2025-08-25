import 'package:eduma_app/Screen/youtubePlayScreen.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePage extends StatefulWidget {
  const YoutubePage({super.key});

  @override
  State<YoutubePage> createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  final List<String> youtubeUrls = [
    "https://www.youtube.com/watch?v=p8gXqMfF2uU",
    "https://www.youtube.com/watch?v=jNQXAC9IVRw",
    "https://www.youtube.com/watch?v=aqz-KE-bpKQ",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("YouTube List")),
      body: ListView.builder(
        itemCount: youtubeUrls.length,
        itemBuilder: (context, index) {
          final url = youtubeUrls[index];
          final videoId = YoutubePlayerController.convertUrlToId(url);

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: videoId != null
                  ? Image.network(
                      "https://img.youtube.com/vi/$videoId/0.jpg",
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.video_library),
              title: Text("Video ${index + 1}"),
              subtitle: Text(url),
              onTap: () {
                if (videoId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          YoutubePlayerScreen(videoId: videoId),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
