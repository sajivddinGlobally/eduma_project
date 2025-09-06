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
import 'package:hive/hive.dart';
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
  bool _isVideoCompleted = false;

  @override
  void initState() {
    super.initState();

    _controller =
        YoutubePlayerController(
          initialVideoId: widget.videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: true,
            controlsVisibleAtStart: true,
          ),
        )..addListener(() {
          // वीडियो की स्थिति ट्रैक करें
          if (_controller.value.isReady && !_controller.value.isPlaying) {
            // अगर वीडियो खत्म हो गया है (duration के बराबर position)
            if (_controller.value.position >= _controller.metadata.duration) {
              setState(() {
                _isVideoCompleted = true;
              });
              // प्रोग्रेस को अपडेट करें (API या लोकल स्टोरेज)
              _updateLessonProgress(widget.videoId);
            }
          }
        });

    // simulate loading time for smoother UX
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _updateLessonProgress(String videoId) async {
    final box = await Hive.openBox('userBox');
    await box.put('lesson_$videoId', true);
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

//////////////////// without cheiwe se only video player se
///

// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// class VideoPage extends StatefulWidget {
//   final String videoId;

//   const VideoPage({super.key, required this.videoId});

//   @override
//   State<VideoPage> createState() => _VideoPageState();
// }

// class _VideoPageState extends State<VideoPage> {
//   late VideoPlayerController _videoPlayerController;
//   bool _isLoading = true;
//   final YoutubeExplode _yt = YoutubeExplode();

//   @override
//   void initState() {
//     super.initState();
//     _loadVideo();
//   }

//   Future<void> _loadVideo() async {
//     try {
//       var manifest = await _yt.videos.streamsClient.getManifest(widget.videoId);

//       var muxedStreams = manifest.muxed.toList();

//       if (muxedStreams.isEmpty) {
//         // fallback to audio-only
//         var audioStream = manifest.audioOnly.isNotEmpty
//             ? manifest.audioOnly.first
//             : null;
//         if (audioStream == null) throw Exception("No playable streams found!");
//         _videoPlayerController = VideoPlayerController.networkUrl(
//           Uri.parse(audioStream.url.toString()),
//         );
//       } else {
//         // 720p try kare, nahi to last element (highest resolution)
//         MuxedStreamInfo streamInfo = muxedStreams.firstWhere(
//           (s) => s.videoResolution.height == 720,
//           orElse: () => muxedStreams.last, // highest resolution stream
//         );

//         _videoPlayerController = VideoPlayerController.networkUrl(
//           Uri.parse(streamInfo.url.toString()),
//         );
//       }

//       await _videoPlayerController.initialize();
//       _videoPlayerController.play();

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
//     _yt.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           _isLoading
//               ? const CircularProgressIndicator()
//               : AspectRatio(
//                   aspectRatio: _videoPlayerController.value.aspectRatio,
//                   child: Stack(
//                     alignment: Alignment.bottomCenter,
//                     children: [
//                       VideoPlayer(_videoPlayerController),

//                       // Play/Pause Button
//                       Align(
//                         alignment: Alignment.center,
//                         child: IconButton(
//                           iconSize: 60,
//                           color: Colors.white,
//                           icon: Icon(
//                             _videoPlayerController.value.isPlaying
//                                 ? Icons.pause_circle
//                                 : Icons.play_circle,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               if (_videoPlayerController.value.isPlaying) {
//                                 _videoPlayerController.pause();
//                               } else {
//                                 _videoPlayerController.play();
//                               }
//                             });
//                           },
//                         ),
//                       ),

//                       // Progress Bar
//                       VideoProgressIndicator(
//                         _videoPlayerController,
//                         allowScrubbing: true,
//                         padding: const EdgeInsets.all(8),
//                         colors: VideoProgressColors(
//                           playedColor: Colors.red,
//                           bufferedColor: Colors.grey,
//                           backgroundColor: Colors.black26,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }
