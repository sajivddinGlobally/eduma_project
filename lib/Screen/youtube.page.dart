// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class YoutubePage extends StatefulWidget {
//   const YoutubePage({super.key});

//   @override
//   State<YoutubePage> createState() => _YoutubePageState();
// }

// class _YoutubePageState extends State<YoutubePage> {
//   bool _isLoading = false;

//   Future<void> _openYoutubeChannel() async {
//     const String channelId = "UCmFHSJGwYAsrtjF8xcVZOFw";

//     // Universal link (app install hai to YouTube app me open hoga, warna browser)
//     final Uri youtubeUrl = Uri.parse(
//       "https://www.youtube.com/channel/$channelId",
//     );

//     if (!await launchUrl(youtubeUrl, mode: LaunchMode.externalApplication)) {
//       throw Exception("Could not launch $youtubeUrl");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         _openYoutubeChannel();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RefreshIndicator(
//         onRefresh: _openYoutubeChannel,
//         child: Stack(
//           children: [
//             ListView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               children: const [
//                 SizedBox(
//                   height: 500,
//                   child: Center(
//                     child: Text(
//                       'Opening YouTube Channel...\nPull down to refresh',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             if (_isLoading) const Center(child: CircularProgressIndicator()),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class YoutubePage extends StatefulWidget {
//   const YoutubePage({super.key});

//   @override
//   State<YoutubePage> createState() => _YoutubePageState();
// }

// class _YoutubePageState extends State<YoutubePage> {
//   late final WebViewController _controller;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();

//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (String url) {
//             setState(() {
//               _isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               _isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             setState(() {
//               _isLoading = false;
//             });
//           },
//         ),
//       )
//       ..loadRequest(
//         Uri.parse('https://www.youtube.com/channel/UCmFHSJGwYAsrtjF8xcVZOFw'),
//       );
//   }

//   Future<void> _refreshPage() async {
//     await _controller.reload();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RefreshIndicator(
//         onRefresh: _refreshPage,
//         child: Stack(
//           children: [
//             WebViewWidget(controller: _controller),
//             if (_isLoading) const Center(child: CircularProgressIndicator()),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class YoutubePage extends StatefulWidget {
//   const YoutubePage({super.key});

//   @override
//   State<YoutubePage> createState() => _YoutubePageState();
// }

// class _YoutubePageState extends State<YoutubePage> {
//   late final WebViewController _controller;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();

//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (_) => setState(() => _isLoading = true),
//           onPageFinished: (_) => setState(() => _isLoading = false),
//         ),
//       )
//       ..loadRequest(
//         Uri.parse("https://www.youtube.com/channel/UCmFHSJGwYAsrtjF8xcVZOFw"),
//       );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("YouTube Channel"),
//         backgroundColor: Colors.red,
//       ),
//       body: Stack(
//         children: [
//           WebViewWidget(controller: _controller),
//           if (_isLoading) const Center(child: CircularProgressIndicator()),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubePage extends StatefulWidget {
  const YoutubePage({super.key});

  @override
  State<YoutubePage> createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  final String playlistId = "UUmFHSJGwYAsrtjF8xcVZOFw"; // ✅ uploads playlist id

  @override
  void initState() {
    super.initState();

    final String embedUrl =
        "https://www.youtube.com/embed/videoseries?list=$playlistId";

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
        ),
      )
      ..loadRequest(Uri.parse(embedUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Channel Playlist"),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
