import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeChannelOpener extends StatefulWidget {
  const YoutubeChannelOpener({super.key});

  @override
  State<YoutubeChannelOpener> createState() => _YoutubeChannelOpenerState();
}

class _YoutubeChannelOpenerState extends State<YoutubeChannelOpener> {
  bool _isLoading = false;

  Future<void> _openYoutubeChannel() async {
    const String channelId = "UCmFHSJGwYAsrtjF8xcVZOFw";

    // Universal link (app install hai to YouTube app me open hoga, warna browser)
    final Uri youtubeUrl = Uri.parse(
      "https://www.youtube.com/channel/$channelId",
    );

    if (!await launchUrl(
      youtubeUrl,
      //mode: LaunchMode.externalApplication,  // ye line app close na ho back karne par ok 
    )) {
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
// import 'package:url_launcher/url_launcher.dart';

// class YoutubePage extends StatelessWidget {
//   const YoutubePage({super.key});

//   Future<void> _openYoutubeChannel() async {
//     const String channelId = "UCmFHSJGwYAsrtjF8xcVZOFw";

//     // Universal link (app install hai to YouTube app me open hoga, warna browser)
//     final Uri youtubeUrl = Uri.parse("https://www.youtube.com/channel/$channelId");

//     if (!await launchUrl(
//       youtubeUrl,
//      // mode: LaunchMode.externalApplication, // ✅ force external app/browser
//     )) {
//       throw Exception("Could not launch $youtubeUrl");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("YouTube Channel Opener")),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _openYoutubeChannel,
//           child: const Text("Open YouTube Channel"),
//         ),
//       ),
//     );
//   }
// }
