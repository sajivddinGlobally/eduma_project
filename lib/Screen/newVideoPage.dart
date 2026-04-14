// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hive/hive.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class NewVideoPage extends StatefulWidget {
//   final String videoId;

//   const NewVideoPage({super.key, required this.videoId});

//   @override
//   State<NewVideoPage> createState() => _NewVideoPageState();
// }

// class _NewVideoPageState extends State<NewVideoPage> {
//   // late YoutubePlayerController _controller;
//   YoutubePlayerController? _controller;
//   bool _isPlayerReady = false;
//   bool _showControls = true;
//   Timer? _hideTimer;
//   List<Map<String, dynamic>> _comments = [];
//   final TextEditingController _commentController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _initializePlayer();
//     _loadComments();
//   }

//   void _initializePlayer() async {
//     final box = await Hive.openBox('videoBox');
//     int savedPosition = box.get('pos_${widget.videoId}', defaultValue: 0);

//     _controller = YoutubePlayerController(
//       initialVideoId: widget.videoId,
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//         startAt: 0,
//         disableDragSeek: false,
//         loop: false,
//         isLive: false,
//         forceHD: false,
//         enableCaption: true,
//         hideControls: false,
//         controlsVisibleAtStart: true,
//       ),
//     )..addListener(_onPlayerStateChange);
//     // Controller assign hone ke baad UI update karein
//     // setState(() {});
//   }

//   void _onPlayerStateChange() {
//     if (mounted && _controller!.value.isReady) {
//       if (!_isPlayerReady) {
//         setState(() => _isPlayerReady = true);
//       }

//       if (_controller!.value.isPlaying) {
//         _saveProgress();
//       }
//     }
//     // Orientation change par rebuild zaroori hai
//     // if (mounted) setState(() {});
//   }

//   void _saveProgress() {
//     final box = Hive.box('videoBox');
//     box.put('pos_${widget.videoId}', _controller!.value.position.inSeconds);
//   }

//   void _startHideTimer() {
//     _hideTimer?.cancel();
//     _hideTimer = Timer(const Duration(seconds: 3), () {
//       if (mounted) setState(() => _showControls = false);
//     });
//   }

//   void _seekRelative(int seconds) {
//     if (_controller == null) return;
//     final currentPosition = _controller!.value.position;
//     final newPosition = currentPosition + Duration(seconds: seconds);
//     _controller!.seekTo(newPosition);
//     _startHideTimer();
//   }

//   @override
//   void dispose() {
//     _saveProgress();
//     _controller!.dispose();
//     _hideTimer?.cancel();
//     _commentController.dispose();
//     // Exit hote waqt orientation normal karein
//     // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_controller == null) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator(color: Colors.red)),
//       );
//     }
//     return YoutubePlayerBuilder(
//       onExitFullScreen: () {
//         // Force portrait when exiting full screen
//         // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//         SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//       },
//       player: YoutubePlayer(
//         controller: _controller!,
//         showVideoProgressIndicator: true,
//         progressIndicatorColor: Colors.red,
//         progressColors: const ProgressBarColors(
//           playedColor: Colors.red,
//           handleColor: Colors.redAccent,
//         ),
//         onReady: () {
//           _isPlayerReady = true;
//         },
//       ),
//       builder: (context, player) {
//         return Scaffold(
//           backgroundColor: Colors.white,
//           appBar: _controller!.value.isFullScreen
//               ? null
//               : AppBar(
//                   elevation: 0,
//                   backgroundColor: Colors.white,
//                   leading: IconButton(
//                     icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   title: Text(
//                     "Video Player",
//                     style: GoogleFonts.inter(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//           body: Column(
//             children: [
//               // Video Section
//               Stack(
//                 children: [
//                   player,

//                   if (!_controller!.value.isFullScreen)
//                     Positioned.fill(
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: GestureDetector(
//                               onDoubleTap: () => _seekRelative(-10),
//                               behavior: HitTestBehavior.translucent,
//                             ),
//                           ),
//                           const Spacer(), // beech mein space taaki pause chale
//                           Expanded(
//                             child: GestureDetector(
//                               onDoubleTap: () => _seekRelative(10),
//                               behavior: HitTestBehavior.translucent,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                 ],
//               ),

//               // Comments and Info
//               if (!_controller!.value.isFullScreen) ...[
//                 _buildVideoInfo(),
//                 const Divider(),
//                 _buildCommentSection(),
//                 _buildCommentInput(),
//               ],
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildVideoInfo() {
//     return Padding(
//       padding: EdgeInsets.all(12.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             _controller!.metadata.title.isEmpty
//                 ? "Loading..."
//                 : _controller!.metadata.title,
//             style: GoogleFonts.inter(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.bold,
//             ),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           SizedBox(height: 5.h),
//           Text(
//             "${_controller!.metadata.author}",
//             style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCommentSection() {
//     return Expanded(
//       child: _comments.isEmpty
//           ? Center(
//               child: Text(
//                 "No comments yet",
//                 style: GoogleFonts.inter(color: Colors.grey),
//               ),
//             )
//           : ListView.builder(
//               itemCount: _comments.length,
//               itemBuilder: (context, index) {
//                 final comment = _comments[index];
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundColor: const Color(0xFF001E6C),
//                     child: Text(
//                       comment['username'][0].toUpperCase(),
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   title: Text(
//                     comment['username'],
//                     style: GoogleFonts.inter(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 13.sp,
//                     ),
//                   ),
//                   subtitle: Text(
//                     comment['comment'],
//                     style: GoogleFonts.inter(fontSize: 13.sp),
//                   ),
//                 );
//               },
//             ),
//     );
//   }

//   Widget _buildCommentInput() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _commentController,
//               decoration: InputDecoration(
//                 hintText: "Add a comment...",
//                 border: InputBorder.none,
//                 hintStyle: GoogleFonts.inter(fontSize: 14.sp),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send, color: Color(0xFF001E6C)),
//             onPressed: () => _addComment(_commentController.text),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _loadComments() async {
//     final box = await Hive.openBox('videoBox');
//     final data = box.get('comments_${widget.videoId}', defaultValue: []);
//     setState(() {
//       _comments = List<Map<String, dynamic>>.from(data);
//     });
//   }

//   void _addComment(String text) async {
//     if (text.isEmpty) return;
//     final box = await Hive.openBox('videoBox');
//     final newComment = {
//       'username': 'You',
//       'comment': text,
//       'timestamp': DateTime.now().toIso8601String(),
//     };
//     setState(() {
//       _comments.add(newComment);
//       _commentController.clear();
//     });
//     await box.put('comments_${widget.videoId}', _comments);
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewVideoPage extends StatefulWidget {
  final String videoId;

  const NewVideoPage({super.key, required this.videoId});

  @override
  State<NewVideoPage> createState() => _NewVideoPageState();
}

class _NewVideoPageState extends State<NewVideoPage> {
  YoutubePlayerController? _controller;
  bool _isPlayerReady = false;
  List<Map<String, dynamic>> _comments = [];
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    _loadComments();
  }

  void _initializePlayer() async {
    final box = await Hive.openBox('videoBox');
    int savedPosition = box.get('pos_${widget.videoId}', defaultValue: 0);

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        startAt: savedPosition,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
        hideControls: false,
        controlsVisibleAtStart: true,
      ),
    )..addListener(_onPlayerStateChange);
  }

  void _onPlayerStateChange() {
    if (!mounted || _controller == null) return;

    if (_controller!.value.isReady && !_isPlayerReady) {
      setState(() => _isPlayerReady = true);
    }

    if (_controller!.value.isPlaying) {
      _saveProgress();
    }
  }

  void _saveProgress() {
    if (_controller == null) return;
    final box = Hive.box('videoBox');
    box.put('pos_${widget.videoId}', _controller!.value.position.inSeconds);
  }

  void _seekRelative(int seconds) {
    if (_controller == null) return;
    final currentPosition = _controller!.value.position;
    final newPosition = currentPosition + Duration(seconds: seconds);
    _controller!.seekTo(newPosition);
  }

  @override
  void dispose() {
    _saveProgress();
    _controller?.dispose();
    _commentController.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.red)),
      );
    }

    final bool isFullScreen = _controller!.value.isFullScreen;

    return YoutubePlayerBuilder(
      // Callbacks remove kiye → flicker fix
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
        ),
        onReady: () {
          if (mounted) setState(() => _isPlayerReady = true);
        },
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: isFullScreen
              ? null
              : AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Text(
                    "Video Player",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          body: Column(
            children: [
              // Video Player Section
              Stack(
                children: [
                  player,

                  // Double tap seek sirf portrait mode mein
                  if (!isFullScreen)
                    Positioned.fill(
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onDoubleTap: () => _seekRelative(-10),
                              behavior: HitTestBehavior.translucent,
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            child: GestureDetector(
                              onDoubleTap: () => _seekRelative(10),
                              behavior: HitTestBehavior.translucent,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              // Comments & Info sirf portrait mode mein
              if (!isFullScreen) ...[
                _buildVideoInfo(),
                const Divider(),
                _buildCommentSection(),
                _buildCommentInput(),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildVideoInfo() {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _controller!.metadata.title.isEmpty
                ? "Loading..."
                : _controller!.metadata.title,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5.h),
          Text(
            _controller!.metadata.author,
            style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentSection() {
    return Expanded(
      child: _comments.isEmpty
          ? Center(
              child: Text(
                "No comments yet",
                style: GoogleFonts.inter(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                final comment = _comments[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF001E6C),
                    child: Text(
                      comment['username'][0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    comment['username'],
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                  subtitle: Text(
                    comment['comment'],
                    style: GoogleFonts.inter(fontSize: 13.sp),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: "Add a comment...",
                border: InputBorder.none,
                hintStyle: GoogleFonts.inter(fontSize: 14.sp),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Color(0xFF001E6C)),
            onPressed: () => _addComment(_commentController.text),
          ),
        ],
      ),
    );
  }

  // Fixed _loadComments with safe casting
  Future<void> _loadComments() async {
    final box = await Hive.openBox('videoBox');
    final dynamic rawData = box.get(
      'comments_${widget.videoId}',
      defaultValue: <Map<String, dynamic>>[],
    );

    List<Map<String, dynamic>> loadedComments = [];

    if (rawData is List) {
      loadedComments = rawData.map((item) {
        if (item is Map) {
          return Map<String, dynamic>.from(item); // safe conversion
        }
        return <String, dynamic>{};
      }).toList();
    }

    if (mounted) {
      setState(() {
        _comments = loadedComments;
      });
    }
  }

  void _addComment(String text) async {
    if (text.isEmpty) return;

    final newComment = {
      'username': 'You',
      'comment': text,
      'timestamp': DateTime.now().toIso8601String(),
    };

    final box = await Hive.openBox('videoBox');

    setState(() {
      _comments.add(newComment);
      _commentController.clear();
    });

    await box.put('comments_${widget.videoId}', _comments);
  }
}
