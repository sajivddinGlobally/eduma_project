///////// ye video playser se hai pacage
///
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:video_player/video_player.dart';

// class VideoPge extends StatefulWidget {
//   final String videoId; // ✅ Normal video file ka URL ya asset path

//   const VideoPge({super.key, required this.videoId});

//   @override
//   State<VideoPge> createState() => _VideoPgeState();
// }

// class _VideoPgeState extends State<VideoPge> {
//   late VideoPlayerController _controller;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();

//     // ✅ Network video ke liye
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoId))
//       ..initialize().then((_) {
//         setState(() {
//           _isLoading = false;
//         });
//         _controller.play(); // auto play
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFFFFF),
//       body: Stack(
//         children: [
//           // Background decoration
//           Positioned(
//             left: -120,
//             top: -100.h,
//             child: Image.asset(
//               "assets/vect.png",
//               width: 363.w,
//               height: 270.h,
//               fit: BoxFit.fitHeight,
//             ),
//           ),
//           Positioned(
//             bottom: -40.h,
//             left: 0,
//             right: 0,
//             child: Image.asset(
//               "assets/vec.png",
//               width: 470.w,
//               height: 450.h,
//               fit: BoxFit.fill,
//             ),
//           ),

//           // Main content
//           Column(
//             children: [
//               SizedBox(height: 40.h),
//               Expanded(
//                 child: Center(
//                   child: _isLoading
//                       ? const CircularProgressIndicator()
//                       : AspectRatio(
//                           aspectRatio: _controller.value.aspectRatio,
//                           child: Stack(
//                             alignment: Alignment.bottomCenter,
//                             children: [
//                               VideoPlayer(_controller),
//                               VideoProgressIndicator(
//                                 _controller,
//                                 allowScrubbing: true,
//                                 padding: const EdgeInsets.all(8),
//                               ),
//                               IconButton(
//                                 icon: Icon(
//                                   _controller.value.isPlaying
//                                       ? Icons.pause
//                                       : Icons.play_arrow,
//                                   size: 40,
//                                   color: Colors.white,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     _controller.value.isPlaying
//                                         ? _controller.pause()
//                                         : _controller.play();
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// ///// ye dusra package hai ok

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPge extends StatefulWidget {
  final String videoId;

  const VideoPge({super.key, required this.videoId});

  @override
  State<VideoPge> createState() => _VideoPgeState();
}

class _VideoPgeState extends State<VideoPge> {
  late YoutubePlayerController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        controlsVisibleAtStart: true,
      ),
    );

    // simulate loading time for smoother UX
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: _isLoading
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(child: CircularProgressIndicator()),
            )
          : YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.red,
              ),
              builder: (context, player) {
                return AspectRatio(aspectRatio: 16 / 9, child: player);
              },
            ),
    );
  }
}
