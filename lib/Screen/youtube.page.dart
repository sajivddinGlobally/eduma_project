// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class YoutubeChannelOpener extends StatefulWidget {
//   const YoutubeChannelOpener({super.key});

//   @override
//   State<YoutubeChannelOpener> createState() => _YoutubeChannelOpenerState();
// }

// class _YoutubeChannelOpenerState extends State<YoutubeChannelOpener> {
//   Future<void> _openYoutubeChannel() async {
//     final Uri youtubeAppUrl = Uri.parse(
//       "https://www.youtube.com/channel/UCmFHSJGwYAsrtjF8xcVZOFw",
//     );

//     // Web fallback (opens in browser if app not installed)
//     final Uri youtubeWebUrl = Uri.parse(
//       "https://www.youtube.com/channel/UCmFHSJGwYAsrtjF8xcVZOFw",
//     );

//     try {
//       if (await canLaunchUrl(youtubeAppUrl)) {
//         await launchUrl(youtubeAppUrl, mode: LaunchMode.externalApplication);
//       } else if (await canLaunchUrl(youtubeWebUrl)) {
//         await launchUrl(youtubeWebUrl, mode: LaunchMode.externalApplication);
//       } else {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Could not open YouTube channel")),
//           );
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text("Error: $e")));
//       }
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Automatically open channel when widget loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _openYoutubeChannel();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RefreshIndicator(
//         onRefresh: _openYoutubeChannel, // ✅ Refresh पर फिर से open होगा
//         child: ListView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           children: const [
//             SizedBox(
//               height: 500,
//               child: Center(
//                 child: Text(
//                   "Opening YouTube Channel...\nPull down to retry",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
    if (_isLoading) return;
    setState(() => _isLoading = true);

    // YouTube app URL scheme
    const String channelId = 'UCmFHSJGwYAsrtjF8xcVZOFw';
    final Uri youtubeAppUrl = Uri.parse(
      'https://www.youtube.com/channel/$channelId',
    );
    final Uri youtubeWebUrl = Uri.parse(
      'https://www.youtube.com/channel/$channelId',
    );

    try {
      // Try opening in YouTube app
      if (await canLaunchUrl(youtubeAppUrl)) {
        await launchUrl(youtubeAppUrl, mode: LaunchMode.inAppWebView);
      } else {
        // Fallback to web URL
        if (await canLaunchUrl(youtubeWebUrl)) {
          await launchUrl(youtubeWebUrl, mode: LaunchMode.inAppBrowserView);
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not open YouTube channel')),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening YouTube channel: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Delay opening until widget is fully built
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
