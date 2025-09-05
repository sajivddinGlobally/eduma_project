// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:chewie/chewie.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:video_player/video_player.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// class VideoPage extends StatefulWidget {
//   final String videoId; // ✅ YouTube videoId pass karenge

//   const VideoPage({super.key, required this.videoId});

//   @override
//   State<VideoPage> createState() => _VideoPageState();
// }

// class _VideoPageState extends State<VideoPage> {
//   late VideoPlayerController _videoPlayerController;
//   ChewieController? _chewieController;
//   bool _isLoading = true;
//   final YoutubeExplode _yt = YoutubeExplode();

//   @override
//   void initState() {
//     super.initState();
//     _loadVideo();
//   }

//   Future<void> _loadVideo() async {
//     try {
//       // ✅ YouTube से video stream URL निकालना
//       var manifest = await _yt.videos.streamsClient.getManifest(widget.videoId);
//       var streamInfo = manifest.muxed.withHighestBitrate();

//       // ✅ VideoPlayerController बनाना
//       _videoPlayerController = VideoPlayerController.networkUrl(
//         Uri.parse(streamInfo.url.toString()),
//       );

//       await _videoPlayerController.initialize();

//       _chewieController = ChewieController(
//         videoPlayerController: _videoPlayerController,
//         autoPlay: true,
//         looping: false,
//         allowFullScreen: true,
//         allowMuting: true,
//         aspectRatio: 16 / 9,
//         materialProgressColors: ChewieProgressColors(
//           playedColor: Colors.red,
//           handleColor: Colors.redAccent,
//           backgroundColor: Colors.grey,
//           //bufferedColor: Colors.lightGreen,
//         ),
//       );

//       setState(() {
//         _isLoading = false;
//       });
//     } catch (e) {
//       log("Error loading video: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController?.dispose();
//     _yt.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: _isLoading
//           ? CircularProgressIndicator()
//           : Container(
//               width: MediaQuery.of(context).size.width, // 👈 full width
//               child: AspectRatio(
//                 aspectRatio: 16 / 9, // ✅ YouTube जैसा 16:9
//                 child: Chewie(controller: _chewieController!),
//               ),
//             ),
//     );
//   }
// }

// ///// ye dusra package hai ok

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  final String videoId;

  const VideoPage({super.key, required this.videoId});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
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
