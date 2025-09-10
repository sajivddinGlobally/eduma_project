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

// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class VideoPage extends StatefulWidget {
//   final String videoId;

//   const VideoPage({super.key, required this.videoId});

//   @override
//   State<VideoPage> createState() => _VideoPageState();
// }

// class _VideoPageState extends State<VideoPage> {
//   late YoutubePlayerController _controller;
//   bool _isLoading = true;
//   bool _isVideoCompleted = false;

//   @override
//   void initState() {
//     super.initState();

//     _controller =
//         YoutubePlayerController(
//           initialVideoId: widget.videoId,
//           flags: const YoutubePlayerFlags(
//             autoPlay: true,
//             mute: false,
//             controlsVisibleAtStart: true,
//           ),
//         )..addListener(() {
//           // वीडियो की स्थिति ट्रैक करें
//           if (_controller.value.isReady && !_controller.value.isPlaying) {
//             // अगर वीडियो खत्म हो गया है (duration के बराबर position)
//             if (_controller.value.position >= _controller.metadata.duration) {
//               setState(() {
//                 _isVideoCompleted = true;
//               });
//               // प्रोग्रेस को अपडेट करें (API या लोकल स्टोरेज)
//               _updateLessonProgress(widget.videoId);
//             }
//           }
//         });

//     // simulate loading time for smoother UX
//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     });
//   }

//   Future<void> _updateLessonProgress(String videoId) async {
//     final box = await Hive.openBox('userBox');
//     await box.put('lesson_$videoId', true);
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
//       body: _isLoading
//           ? SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               child: Center(child: CircularProgressIndicator()),
//             )
//           : YoutubePlayerBuilder(
//               player: YoutubePlayer(
//                 controller: _controller,
//                 showVideoProgressIndicator: true,
//                 progressIndicatorColor: Colors.red,
//               ),
//               builder: (context, player) {
//                 return AspectRatio(aspectRatio: 16 / 9, child: player);
//               },
//             ),
//     );
//   }
// }

////////////////////////////////////////////////////////// ye comment ke liye

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final TextEditingController _commentController = TextEditingController();
  List<String> _comments = [];

  @override
  void initState() {
    super.initState();
    _controller =
        YoutubePlayerController(
          initialVideoId: widget.videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            controlsVisibleAtStart: true,
          ),
        )..addListener(() {
          if (_controller.value.isReady && !_controller.value.isPlaying) {
            if (_controller.value.position >= _controller.metadata.duration) {
              setState(() {
                _isVideoCompleted = true;
              });
              _updateLessonProgress(widget.videoId);
            }
          }
        });

    // Simulate loading time for smoother UX
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });

    // Load existing comments
    _loadComments();
  }

  Future<void> _updateLessonProgress(String videoId) async {
    final box = await Hive.openBox('userBox');
    await box.put('lesson_$videoId', true);
  }

  Future<void> _loadComments() async {
    final box = await Hive.openBox('commentsBox');
    setState(() {
      _comments = List<String>.from(
        box.get('comments_${widget.videoId}', defaultValue: []) as List,
      );
    });
  }

  Future<void> _addComment(String comment) async {
    if (comment.trim().isNotEmpty) {
      final box = await Hive.openBox('commentsBox');
      final updatedComments = List<String>.from(
        box.get('comments_${widget.videoId}', defaultValue: []) as List,
      )..add(comment);
      await box.put('comments_${widget.videoId}', updatedComments);
      setState(() {
        _comments = updatedComments;
        _commentController.clear();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _commentController.dispose();
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
              child: const Center(child: CircularProgressIndicator()),
            )
          : Column(
              children: [
                YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                  ),
                  builder: (context, player) {
                    return AspectRatio(aspectRatio: 16 / 9, child: player);
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Comments',
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Expanded(
                          child: _comments.isEmpty
                              ? Center(
                                  child: Text(
                                    'No comments yet. Be the first to comment!',
                                    style: GoogleFonts.inter(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: _comments.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 12.h),
                                      padding: EdgeInsets.all(12.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 16.r,
                                                backgroundColor:
                                                    Colors.grey[300],
                                                child: Text(
                                                  'U${index + 1}',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 12.sp,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 8.w),
                                              Text(
                                                'User ${index + 1}',
                                                style: GoogleFonts.inter(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                'Just now',
                                                style: GoogleFonts.inter(
                                                  fontSize: 12.sp,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            _comments[index],
                                            style: GoogleFonts.inter(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: _commentController,
                                  decoration: InputDecoration(
                                    hintText: 'Add a comment...',
                                    hintStyle: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      color: Colors.grey[500],
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 12.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            ElevatedButton(
                              onPressed: () =>
                                  _addComment(_commentController.text),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 12.h,
                                ),
                              ),
                              child: Text(
                                'Post',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}







//////////////////////////////////////////// ok   


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
