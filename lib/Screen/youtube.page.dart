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

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) {
            setState(() => _isLoading = false);
            // Hide YouTube bottom navigation bar
            _controller.runJavaScript("""
              document.querySelector('ytm-cwc-bottom-nav').style.display = 'none';
            """);
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          //"https://www.youtube.com/channel/UCmFHSJGwYAsrtjF8xcVZOFw",
          "https://www.youtube.com/@anilkumarsingh_surat",
        ),
      );
  }

  Future<void> _refreshPage() async {
    await _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshPage,
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}



// channel video

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
//         Uri.parse(
//           "https://www.youtube.com/embed/videoseries?list=UUmFHSJGwYAsrtjF8xcVZOFw",
//         ),
//       );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My YouTube Uploads"),
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
