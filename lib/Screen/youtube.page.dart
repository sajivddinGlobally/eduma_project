import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeBottom extends StatefulWidget {
  const YoutubeBottom({super.key});

  @override
  State<YoutubeBottom> createState() => _YoutubeBottomState();
}

class _YoutubeBottomState extends State<YoutubeBottom> {
  bool _isLoading = false;

  Future<void> _openYoutubeChannel() async {
    const String channelId = "UCmFHSJGwYAsrtjF8xcVZOFw";

    // Universal link (app install hai to YouTube app me open hoga, warna browser)
    final Uri youtubeUrl = Uri.parse(
      "https://www.youtube.com/channel/$channelId",
    );

    if (!await launchUrl(youtubeUrl, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $youtubeUrl");
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _openYoutubeChannel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _openYoutubeChannel,
        child: Stack(
          children: [
            ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(
                  height: 500,
                  child: Center(
                    child: Text(
                      'Opening YouTube Channel...\nPull down to refresh',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class YoutubeChannelOpener extends StatefulWidget {
//   const YoutubeChannelOpener({super.key});

//   @override
//   State<YoutubeChannelOpener> createState() => _YoutubeChannelOpenerState();
// }

// class _YoutubeChannelOpenerState extends State<YoutubeChannelOpener> {
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();

//     // Example: ek video ID (aap channel ke kisi bhi video ka ID de sakte ho)
//     const String videoId = "dQw4w9WgXcQ"; // 👈 replace with your videoId

//     _controller = YoutubePlayerController(
//       initialVideoId: videoId,
//       flags: const YoutubePlayerFlags(
//         autoPlay: false,
//         mute: false,
//         controlsVisibleAtStart: true,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("YouTube Player"),
//         backgroundColor: Colors.red,
//       ),
//       body: Column(
//         children: [
//           YoutubePlayer(
//             controller: _controller,
//             showVideoProgressIndicator: true,
//             progressIndicatorColor: Colors.red,
//             onReady: () {
//               debugPrint("Player is ready.");
//             },
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             "Custom YouTube Player inside app",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }

