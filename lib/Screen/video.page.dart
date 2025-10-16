// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hive/hive.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

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
//   final TextEditingController _commentController = TextEditingController();
//   List<Map<String, dynamic>> _comments = [];
//   bool _showControls = true;
//   Timer? _hideTimer;
//   bool _isPlaying = true; // Track playing state
//   bool _isFullScreen = false; // Track full screen state
//   double _progress = 0.0; // For custom progress bar
//   int? _savedPositionMs;
//   bool _hasSoughtToSaved = false;
//   DateTime? _lastSaveTime;

//   String timeAgo(DateTime date) {
//     final diff = DateTime.now().difference(date);
//     if (diff.inSeconds < 60) return "Just now";
//     if (diff.inMinutes < 60) return "${diff.inMinutes} min ago";
//     if (diff.inHours < 24) return "${diff.inHours} hr ago";
//     return "${diff.inDays} days ago";
//   }

//   Future<void> _saveProgress() async {
//     final box = await Hive.openBox('commentsBox');
//     await box.put(
//       'progress_${widget.videoId}',
//       _controller.value.position.inMilliseconds,
//     );
//   }

//   Future<void> _saveIfNeeded() async {
//     final now = DateTime.now();
//     if (_lastSaveTime == null ||
//         now.difference(_lastSaveTime!).inSeconds >= 10) {
//       await _saveProgress();
//       _lastSaveTime = now;
//     }
//   }

//   Future<void> _loadSavedPosition() async {
//     final box = await Hive.openBox('commentsBox');
//     _savedPositionMs =
//         box.get('progress_${widget.videoId}', defaultValue: 0) as int?;
//   }

//   void _seekToSaved() {
//     if (_savedPositionMs != null && _savedPositionMs! > 0) {
//       _controller.seekTo(Duration(milliseconds: _savedPositionMs!));
//     }
//   }

//   void _showPlayerControls() {
//     setState(() {
//       _showControls = true;
//     });
//     _hideTimer?.cancel();
//     _hideTimer = Timer(const Duration(seconds: 3), () {
//       if (mounted) {
//         setState(() {
//           _showControls = false;
//         });
//       }
//     });
//   }

//   void _togglePlayPause() {
//     if (_controller.value.isPlaying) {
//       _controller.pause();
//       _saveProgress(); // Save position on pause
//     } else {
//       _controller.play();
//     }
//     setState(() {
//       _isPlaying = _controller.value.isPlaying;
//     });
//     _showPlayerControls();
//   }

//   void _skipBackward() {
//     final currentPosition = _controller.value.position;
//     _controller.seekTo(currentPosition - const Duration(seconds: 10));
//     _showPlayerControls();
//   }

//   void _skipForward() {
//     final currentPosition = _controller.value.position;
//     _controller.seekTo(currentPosition + const Duration(seconds: 10));
//     _showPlayerControls();
//   }

//   void _replayVideo() {
//     _controller.seekTo(Duration.zero);
//     _controller.play();
//     setState(() {
//       _isVideoCompleted = false;
//     });
//     _showPlayerControls();
//   }

//   void _toggleFullScreen() {
//     if (_isFullScreen) {
//       _onExitFullScreen();
//     } else {
//       _onEnterFullScreen();
//     }
//   }

//   void _onEnterFullScreen() {
//     setState(() {
//       _isFullScreen = true;
//     });
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     _showPlayerControls();
//   }

//   void _onExitFullScreen() {
//     setState(() {
//       _isFullScreen = false;
//     });
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         YoutubePlayerController(
//           initialVideoId: widget.videoId,
//           flags: const YoutubePlayerFlags(
//             autoPlay: true,
//             mute: false,
//             controlsVisibleAtStart: false, // Hide native controls
//           ),
//         )..addListener(() {
//           if (mounted) {
//             final position = _controller.value.position.inSeconds;
//             final duration = _controller.metadata.duration.inSeconds;
//             setState(() {
//               _isPlaying = _controller.value.isPlaying;
//               // Update progress
//               if (_controller.metadata.duration != Duration.zero) {
//                 _progress =
//                     _controller.value.position.inMilliseconds.toDouble() /
//                     _controller.metadata.duration.inMilliseconds.toDouble();
//               }
//               // Handle video completion
//               if (_isVideoCompleted && _controller.value.isPlaying) {
//                 _isVideoCompleted = false;
//               }
//               if (!_controller.value.isPlaying &&
//                   position >= (duration - 1) &&
//                   !_isVideoCompleted &&
//                   duration > 0) {
//                 _isVideoCompleted = true;
//               }
//             });

//             // Seek to saved position when initialized
//             if (!_hasSoughtToSaved && _controller.value.isReady) {
//               _seekToSaved();
//               _hasSoughtToSaved = true;
//             }

//             // Periodic save when playing
//             if (_controller.value.isPlaying) {
//               _saveIfNeeded();
//             }
//           }
//         });

//     _loadSavedPosition();

//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//           _isPlaying = _controller.value.isPlaying;
//         });
//         _showPlayerControls();
//       }
//     });

//     _loadComments();
//   }

//   Future<void> _loadComments() async {
//     final box = await Hive.openBox('commentsBox');
//     final storedComments =
//         box.get('comments_${widget.videoId}', defaultValue: []) as List;
//     final userBox = await Hive.openBox('userBox');
//     final username =
//         userBox.get('storeName', defaultValue: 'Anonymous') as String;

//     setState(() {
//       _comments = [];
//       for (var comment in storedComments) {
//         if (comment is String) {
//           _comments.add({
//             'username': username,
//             'comment': comment,
//             'timestamp': DateTime.now().toIso8601String(),
//           });
//         } else if (comment is Map) {
//           _comments.add(Map<String, dynamic>.from(comment));
//         }
//       }
//       box.put('comments_${widget.videoId}', _comments);
//     });
//   }

//   Future<void> _addComment(String comment) async {
//     if (comment.trim().isNotEmpty) {
//       final userBox = await Hive.openBox('userBox');
//       final username =
//           userBox.get('storeName', defaultValue: 'Anonymous') as String;
//       final box = await Hive.openBox('commentsBox');
//       final newComment = {
//         'username': username,
//         'comment': comment,
//         'timestamp': DateTime.now().toIso8601String(),
//       };
//       final updatedComments = List<Map<String, dynamic>>.from(_comments)
//         ..add(newComment);
//       await box.put('comments_${widget.videoId}', updatedComments);
//       setState(() {
//         _comments = updatedComments;
//         _commentController.clear();
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _saveProgress(); // Save final position
//     _hideTimer?.cancel();
//     _controller.dispose();
//     _commentController.dispose();
//     super.dispose();
//   }

//   Widget _buildVideoOverlay() {
//     return AnimatedOpacity(
//       opacity: _showControls ? 1.0 : 0.0,
//       duration: const Duration(milliseconds: 300),
//       child: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: Colors.transparent,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(
//                   onPressed: _skipBackward,
//                   icon: Icon(
//                     Icons.replay_10,
//                     color: Colors.white,
//                     size: _isFullScreen ? 40.sp : 30.sp,
//                   ),
//                   style: IconButton.styleFrom(
//                     backgroundColor: const Color(0x80001E6C),
//                   ),
//                   tooltip: 'Rewind 10 seconds',
//                 ),
//                 IconButton(
//                   onPressed: _togglePlayPause,
//                   icon: Icon(
//                     _isPlaying
//                         ? Icons.pause_circle_filled
//                         : Icons.play_circle_filled,
//                     color: Colors.white,
//                     size: _isFullScreen ? 60.sp : 50.sp,
//                   ),
//                   style: IconButton.styleFrom(
//                     backgroundColor: const Color(0x80001E6C),
//                   ),
//                   tooltip: _isPlaying ? 'Pause' : 'Play',
//                 ),
//                 IconButton(
//                   onPressed: _skipForward,
//                   icon: Icon(
//                     Icons.forward_10,
//                     color: Colors.white,
//                     size: _isFullScreen ? 40.sp : 30.sp,
//                   ),
//                   style: IconButton.styleFrom(
//                     backgroundColor: const Color(0x80001E6C),
//                   ),
//                   tooltip: 'Forward 10 seconds',
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFullScreenButton() {
//     return AnimatedOpacity(
//       opacity: _showControls ? 1.0 : 0.0,
//       duration: const Duration(milliseconds: 300),
//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color(0x80001E6C),
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         child: IconButton(
//           onPressed: _toggleFullScreen,
//           icon: Icon(
//             _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
//             color: Colors.white,
//             size: 24.sp,
//           ),
//           tooltip: _isFullScreen ? 'Exit full screen' : 'Enter full screen',
//         ),
//       ),
//     );
//   }

//   Widget _buildProgressBar() {
//     return Positioned(
//       bottom: 0,
//       left: 0,
//       right: 0,
//       child: SliderTheme(
//         data: SliderTheme.of(context).copyWith(
//           thumbColor: _isFullScreen ? Colors.white : Colors.red,
//           activeTrackColor: Colors.red,
//           inactiveTrackColor: _isFullScreen
//               ? Colors.black.withOpacity(0.5)
//               : Colors.grey.withOpacity(0.3),
//           trackHeight: _isFullScreen ? 4 : 3,
//           overlayColor: Colors.transparent,
//         ),
//         child: Slider(
//           value: _progress,
//           min: 0.0,
//           max: 1.0,
//           onChanged: _controller.metadata.duration != Duration.zero
//               ? (value) {
//                   final position = Duration(
//                     milliseconds:
//                         (value * _controller.metadata.duration.inMilliseconds)
//                             .round(),
//                   );
//                   _controller.seekTo(position);
//                 }
//               : null,
//         ),
//       ),
//     );
//   }

//   Widget _buildCompletedOverlay() {
//     if (!_isVideoCompleted) return const SizedBox.shrink();
//     return Positioned.fill(
//       child: GestureDetector(
//         onTap: _replayVideo,
//         child: Container(
//           color: Colors.black54,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.replay_circle_filled,
//                 color: Colors.white,
//                 size: _isFullScreen ? 80 : 60,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'Video Completed',
//                 style: GoogleFonts.inter(
//                   fontSize: _isFullScreen ? 20 : 16.sp,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var box = Hive.box('userBox');
//     var name = box.get('storeName', defaultValue: 'Anonymous');
//     return YoutubePlayerBuilder(
//       // Remove onEnterFullScreen and onExitFullScreen to avoid conflicts
//       player: YoutubePlayer(
//         controller: _controller,
//         showVideoProgressIndicator: false, // Hide native progress, use custom
//         progressIndicatorColor: Colors.red,
//       ),
//       builder: (context, player) {
//         if (_isFullScreen) {
//           // Full screen layout - only player
//           return Scaffold(
//             backgroundColor: Colors.black,
//             body: GestureDetector(
//               onTap: _showPlayerControls,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   Center(
//                     child: AspectRatio(aspectRatio: 16 / 9, child: player),
//                   ),
//                   // Overlay controls
//                   _buildVideoOverlay(),
//                   // Custom progress bar at bottom in full screen
//                   _buildProgressBar(),
//                   // Full screen exit button (top right)
//                   Positioned(
//                     top: 40,
//                     right: 16,
//                     child: _buildFullScreenButton(),
//                   ),
//                   // Completed overlay
//                   _buildCompletedOverlay(),
//                 ],
//               ),
//             ),
//           );
//         }
//         // Normal layout
//         return Scaffold(
//           backgroundColor: const Color(0xFFFFFFFF),
//           body: _isLoading
//               ? SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                   child: const Center(child: CircularProgressIndicator()),
//                 )
//               : Column(
//                   children: [
//                     GestureDetector(
//                       onTap: _showPlayerControls,
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.width * 9 / 16,
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             player,
//                             // Overlay controls
//                             _buildVideoOverlay(),
//                             // Custom progress bar at bottom in normal mode
//                             _buildProgressBar(),
//                             // Full screen button (top right)
//                             Positioned(
//                               top: 10.h,
//                               right: 10.w,
//                               child: _buildFullScreenButton(),
//                             ),
//                             // Completed overlay
//                             _buildCompletedOverlay(),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: EdgeInsets.all(16.w),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Comments',
//                               style: GoogleFonts.inter(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             SizedBox(height: 12.h),
//                             Expanded(
//                               child: _comments.isEmpty
//                                   ? Center(
//                                       child: Text(
//                                         'No comments yet.',
//                                         style: GoogleFonts.inter(
//                                           fontSize: 15.sp,
//                                           fontWeight: FontWeight.w500,
//                                           color: Colors.grey[600],
//                                         ),
//                                       ),
//                                     )
//                                   : ListView.builder(
//                                       padding: EdgeInsets.zero,
//                                       itemCount: _comments.length,
//                                       itemBuilder: (context, index) {
//                                         final comment = _comments[index];
//                                         final timestamp = DateTime.parse(
//                                           comment['timestamp'],
//                                         );
//                                         return Container(
//                                           margin: EdgeInsets.only(bottom: 12.h),
//                                           padding: EdgeInsets.all(12.w),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.circular(
//                                               12.r,
//                                             ),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.grey.withOpacity(
//                                                   0.2,
//                                                 ),
//                                                 spreadRadius: 2,
//                                                 blurRadius: 5,
//                                                 offset: const Offset(0, 3),
//                                               ),
//                                             ],
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   CircleAvatar(
//                                                     radius: 16.r,
//                                                     backgroundColor:
//                                                         const Color(0xFF001E6C),
//                                                     child: Text(
//                                                       comment['username'][0]
//                                                           .toString()
//                                                           .toUpperCase(),
//                                                       style: GoogleFonts.inter(
//                                                         fontSize: 12.sp,
//                                                         color: Colors.white,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   SizedBox(width: 8.w),
//                                                   Text(
//                                                     comment['username'],
//                                                     style: GoogleFonts.inter(
//                                                       fontSize: 14.sp,
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       color: Colors.black87,
//                                                     ),
//                                                   ),
//                                                   const Spacer(),
//                                                   Text(
//                                                     timeAgo(timestamp),
//                                                     style: GoogleFonts.inter(
//                                                       fontSize: 12.sp,
//                                                       color: Colors.grey[500],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(height: 8.h),
//                                               Text(
//                                                 comment['comment'],
//                                                 style: GoogleFonts.inter(
//                                                   fontSize: 14.sp,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.black87,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                     ),
//                             ),
//                             SizedBox(height: 12.h),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(12.r),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.withOpacity(0.1),
//                                           spreadRadius: 1,
//                                           blurRadius: 3,
//                                           offset: const Offset(0, 2),
//                                         ),
//                                       ],
//                                     ),
//                                     child: TextField(
//                                       controller: _commentController,
//                                       decoration: InputDecoration(
//                                         hintText: 'Add a comment...',
//                                         hintStyle: GoogleFonts.inter(
//                                           fontSize: 14.sp,
//                                           color: Colors.grey[500],
//                                         ),
//                                         border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                             12.r,
//                                           ),
//                                           borderSide: BorderSide(
//                                             color: Color(0xFF001E6C),
//                                           ),
//                                         ),
//                                         contentPadding: EdgeInsets.symmetric(
//                                           horizontal: 16.w,
//                                           vertical: 12.h,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 8.w),
//                                 ElevatedButton(
//                                   onPressed: () =>
//                                       _addComment(_commentController.text),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: const Color(0xFF001E6C),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12.r),
//                                     ),
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: 16.w,
//                                       vertical: 10.h,
//                                     ),
//                                   ),
//                                   child: Text(
//                                     'Comment',
//                                     style: GoogleFonts.inter(
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//         );
//       },
//     );
//   }
// }

///////////////////////////////////////////////////////////////////////////////////
///import 'dart:async';


import 'dart:async';
import 'dart:io'; // Add this for Platform.isAndroid
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:android_pip/android_pip.dart'; 

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
  List<Map<String, dynamic>> _comments = [];
  bool _showControls = true;
  Timer? _hideTimer;
  bool _isPlaying = true; // Track playing state
  bool _isFullScreen = false; // Track full screen state
  double _progress = 0.0; // For custom progress bar
  int? _savedPositionMs;
  bool _hasSoughtToSaved = false;
  DateTime? _lastSaveTime;

  String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inSeconds < 60) return "Just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes} min ago";
    if (diff.inHours < 24) return "${diff.inHours} hr ago";
    return "${diff.inDays} days ago";
  }

  Future<void> _enterPiP() async {
    if (Platform.isAndroid) {
      try {
        AndroidPIP().enterPipMode();
      } on PlatformException catch (e) {
        debugPrint('Failed to enter PiP: ${e.message}');
      }
    } else {
      // For non-Android platforms, you can handle differently, e.g., just pop or show a message
      debugPrint('PiP is not supported on this platform');
    }
  }

  Future<void> _saveProgress() async {
    final box = await Hive.openBox('commentsBox');
    await box.put(
      'progress_${widget.videoId}',
      _controller.value.position.inMilliseconds,
    );
  }

  Future<void> _saveIfNeeded() async {
    final now = DateTime.now();
    if (_lastSaveTime == null ||
        now.difference(_lastSaveTime!).inSeconds >= 10) {
      await _saveProgress();
      _lastSaveTime = now;
    }
  }

  Future<void> _loadSavedPosition() async {
    final box = await Hive.openBox('commentsBox');
    _savedPositionMs =
        box.get('progress_${widget.videoId}', defaultValue: 0) as int?;
  }

  void _seekToSaved() {
    if (_savedPositionMs != null && _savedPositionMs! > 0) {
      _controller.seekTo(Duration(milliseconds: _savedPositionMs!));
    }
  }

  void _showPlayerControls() {
    setState(() {
      _showControls = true;
    });
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      _saveProgress(); // Save position on pause
    } else {
      _controller.play();
    }
    setState(() {
      _isPlaying = _controller.value.isPlaying;
    });
    _showPlayerControls();
  }

  void _skipBackward() {
    final currentPosition = _controller.value.position;
    _controller.seekTo(currentPosition - const Duration(seconds: 10));
    _showPlayerControls();
  }

  void _skipForward() {
    final currentPosition = _controller.value.position;
    _controller.seekTo(currentPosition + const Duration(seconds: 10));
    _showPlayerControls();
  }

  void _replayVideo() {
    _controller.seekTo(Duration.zero);
    _controller.play();
    setState(() {
      _isVideoCompleted = false;
    });
    _showPlayerControls();
  }

  void _toggleFullScreen() {
    if (_isFullScreen) {
      _onExitFullScreen();
    } else {
      _onEnterFullScreen();
    }
  }

  void _onEnterFullScreen() {
    setState(() {
      _isFullScreen = true;
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _showPlayerControls();
  }

  void _onExitFullScreen() {
    setState(() {
      _isFullScreen = false;
    });
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void initState() {
    super.initState();
    _controller =
        YoutubePlayerController(
          initialVideoId: widget.videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            controlsVisibleAtStart: false, // Hide native controls
          ),
        )..addListener(() {
          if (mounted) {
            final position = _controller.value.position.inSeconds;
            final duration = _controller.metadata.duration.inSeconds;
            setState(() {
              _isPlaying = _controller.value.isPlaying;
              // Update progress
              if (_controller.metadata.duration != Duration.zero) {
                _progress =
                    _controller.value.position.inMilliseconds.toDouble() /
                    _controller.metadata.duration.inMilliseconds.toDouble();
              }
              // Handle video completion
              if (_isVideoCompleted && _controller.value.isPlaying) {
                _isVideoCompleted = false;
              }
              if (!_controller.value.isPlaying &&
                  position >= (duration - 1) &&
                  !_isVideoCompleted &&
                  duration > 0) {
                _isVideoCompleted = true;
              }
            });

            // Seek to saved position when initialized
            if (!_hasSoughtToSaved && _controller.value.isReady) {
              _seekToSaved();
              _hasSoughtToSaved = true;
            }

            // Periodic save when playing
            if (_controller.value.isPlaying) {
              _saveIfNeeded();
            }
          }
        });

    _loadSavedPosition();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isPlaying = _controller.value.isPlaying;
        });
        _showPlayerControls();
      }
    });

    _loadComments();
  }

  Future<void> _loadComments() async {
    final box = await Hive.openBox('commentsBox');
    final storedComments =
        box.get('comments_${widget.videoId}', defaultValue: []) as List;
    final userBox = await Hive.openBox('userBox');
    final username =
        userBox.get('storeName', defaultValue: 'Anonymous') as String;

    setState(() {
      _comments = [];
      for (var comment in storedComments) {
        if (comment is String) {
          _comments.add({
            'username': username,
            'comment': comment,
            'timestamp': DateTime.now().toIso8601String(),
          });
        } else if (comment is Map) {
          _comments.add(Map<String, dynamic>.from(comment));
        }
      }
      box.put('comments_${widget.videoId}', _comments);
    });
  }

  Future<void> _addComment(String comment) async {
    if (comment.trim().isNotEmpty) {
      final userBox = await Hive.openBox('userBox');
      final username =
          userBox.get('storeName', defaultValue: 'Anonymous') as String;
      final box = await Hive.openBox('commentsBox');
      final newComment = {
        'username': username,
        'comment': comment,
        'timestamp': DateTime.now().toIso8601String(),
      };
      final updatedComments = List<Map<String, dynamic>>.from(_comments)
        ..add(newComment);
      await box.put('comments_${widget.videoId}', updatedComments);
      setState(() {
        _comments = updatedComments;
        _commentController.clear();
      });
    }
  }

  @override
  void dispose() {
    _saveProgress(); // Save final position
    _hideTimer?.cancel();
    _controller.dispose();
    _commentController.dispose();
    super.dispose();
  }

  Widget _buildVideoOverlay() {
    return AnimatedOpacity(
      opacity: _showControls ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _skipBackward,
                  icon: Icon(
                    Icons.replay_10,
                    color: Colors.white,
                    size: _isFullScreen ? 40.sp : 30.sp,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0x80001E6C),
                  ),
                  tooltip: 'Rewind 10 seconds',
                ),
                IconButton(
                  onPressed: _togglePlayPause,
                  icon: Icon(
                    _isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    color: Colors.white,
                    size: _isFullScreen ? 60.sp : 50.sp,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0x80001E6C),
                  ),
                  tooltip: _isPlaying ? 'Pause' : 'Play',
                ),
                IconButton(
                  onPressed: _skipForward,
                  icon: Icon(
                    Icons.forward_10,
                    color: Colors.white,
                    size: _isFullScreen ? 40.sp : 30.sp,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0x80001E6C),
                  ),
                  tooltip: 'Forward 10 seconds',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullScreenButton() {
    return AnimatedOpacity(
      opacity: _showControls ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0x80001E6C),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: IconButton(
          onPressed: _toggleFullScreen,
          icon: Icon(
            _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
            color: Colors.white,
            size: 24.sp,
          ),
          tooltip: _isFullScreen ? 'Exit full screen' : 'Enter full screen',
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          thumbColor: _isFullScreen ? Colors.white : Colors.red,
          activeTrackColor: Colors.red,
          inactiveTrackColor: _isFullScreen
              ? Colors.black.withOpacity(0.5)
              : Colors.grey.withOpacity(0.3),
          trackHeight: _isFullScreen ? 4 : 3,
          overlayColor: Colors.transparent,
        ),
        child: Slider(
          value: _progress,
          min: 0.0,
          max: 1.0,
          onChanged: _controller.metadata.duration != Duration.zero
              ? (value) {
                  final position = Duration(
                    milliseconds:
                        (value * _controller.metadata.duration.inMilliseconds)
                            .round(),
                  );
                  _controller.seekTo(position);
                }
              : null,
        ),
      ),
    );
  }

  Widget _buildCompletedOverlay() {
    if (!_isVideoCompleted) return const SizedBox.shrink();
    return Positioned.fill(
      child: GestureDetector(
        onTap: _replayVideo,
        child: Container(
          color: Colors.black54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.replay_circle_filled,
                color: Colors.white,
                size: _isFullScreen ? 80 : 60,
              ),
              const SizedBox(height: 16),
              Text(
                'Video Completed',
                style: GoogleFonts.inter(
                  fontSize: _isFullScreen ? 20 : 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('userBox');
    var name = box.get('storeName', defaultValue: 'Anonymous');
    return YoutubePlayerBuilder(
      // Remove onEnterFullScreen and onExitFullScreen to avoid conflicts
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: false, // Hide native progress, use custom
        progressIndicatorColor: Colors.red,
      ),
      builder: (context, player) {
        if (_isFullScreen) {
          // Full screen layout - only player
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (!didPop) {
                _onExitFullScreen();
              }
            },
            child: Scaffold(
              backgroundColor: Colors.black,
              body: GestureDetector(
                onTap: _showPlayerControls,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: AspectRatio(aspectRatio: 16 / 9, child: player),
                    ),
                    // Overlay controls
                    _buildVideoOverlay(),
                    // Custom progress bar at bottom in full screen
                    _buildProgressBar(),
                    // Full screen exit button (top right)
                    Positioned(
                      top: 40,
                      right: 16,
                      child: _buildFullScreenButton(),
                    ),
                    // Completed overlay
                    _buildCompletedOverlay(),
                  ],
                ),
              ),
            ),
          );
        }
        // Normal layout
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (didPop) return;
            if (_isLoading ||
                (!_controller.value.isPlaying && !_isVideoCompleted)) {
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            } else {
              await _enterPiP();
            }
          },
          child: Scaffold(
            backgroundColor: const Color(0xFFFFFFFF),
            body: _isLoading
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : Column(
                    children: [
                      GestureDetector(
                        onTap: _showPlayerControls,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 9 / 16,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              player,
                              // Overlay controls
                              _buildVideoOverlay(),
                              // Custom progress bar at bottom in normal mode
                              _buildProgressBar(),
                              // Full screen button (top right)
                              Positioned(
                                top: 10.h,
                                right: 10.w,
                                child: _buildFullScreenButton(),
                              ),
                              // Completed overlay
                              _buildCompletedOverlay(),
                            ],
                          ),
                        ),
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
                                          'No comments yet.',
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
                                          final comment = _comments[index];
                                          final timestamp = DateTime.parse(
                                            comment['timestamp'],
                                          );
                                          return Container(
                                            margin: EdgeInsets.only(
                                              bottom: 12.h,
                                            ),
                                            padding: EdgeInsets.all(12.w),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
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
                                                          const Color(
                                                            0xFF001E6C,
                                                          ),
                                                      child: Text(
                                                        comment['username'][0]
                                                            .toString()
                                                            .toUpperCase(),
                                                        style:
                                                            GoogleFonts.inter(
                                                              fontSize: 12.sp,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 8.w),
                                                    Text(
                                                      comment['username'],
                                                      style: GoogleFonts.inter(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      timeAgo(timestamp),
                                                      style: GoogleFonts.inter(
                                                        fontSize: 12.sp,
                                                        color: Colors.grey[500],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 8.h),
                                                Text(
                                                  comment['comment'],
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
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
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
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                            borderSide: BorderSide(
                                              color: Color(0xFF001E6C),
                                            ),
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
                                      backgroundColor: const Color(0xFF001E6C),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 10.h,
                                      ),
                                    ),
                                    child: Text(
                                      'Comment',
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
          ),
        );
      },
    );
  }
}






// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hive/hive.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
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
//   final TextEditingController _commentController = TextEditingController();
//   List<Map<String, dynamic>> _comments = [];
//   bool _showControls = true;
//   Timer? _hideTimer;
//   bool _isPlaying = true; // Track playing state
//   bool _isFullScreen = false; // Track full screen state
//   double _progress = 0.0; // For custom progress bar
//   String timeAgo(DateTime date) {
//     final diff = DateTime.now().difference(date);
//     if (diff.inSeconds < 60) return "Just now";
//     if (diff.inMinutes < 60) return "${diff.inMinutes} min ago";
//     if (diff.inHours < 24) return "${diff.inHours} hr ago";
//     return "${diff.inDays} days ago";
//   }
//   void _showPlayerControls() {
//     setState(() {
//       _showControls = true;
//     });
//     _hideTimer?.cancel();
//     _hideTimer = Timer(const Duration(seconds: 3), () {
//       if (mounted) {
//         setState(() {
//           _showControls = false;
//         });
//       }
//     });
//   }
//   void _togglePlayPause() {
//     if (_controller.value.isPlaying) {
//       _controller.pause();
//     } else {
//       _controller.play();
//     }
//     setState(() {
//       _isPlaying = _controller.value.isPlaying;
//     });
//     _showPlayerControls();
//   }
//   void _skipBackward() {
//     final currentPosition = _controller.value.position;
//     _controller.seekTo(currentPosition - const Duration(seconds: 10));
//     _showPlayerControls();
//   }
//   void _skipForward() {
//     final currentPosition = _controller.value.position;
//     _controller.seekTo(currentPosition + const Duration(seconds: 10));
//     _showPlayerControls();
//   }
//   void _replayVideo() {
//     _controller.seekTo(Duration.zero);
//     _controller.play();
//     setState(() {
//       _isVideoCompleted = false;
//     });
//     _showPlayerControls();
//   }
//   void _toggleFullScreen() {
//     if (_isFullScreen) {
//       _onExitFullScreen();
//     } else {
//       _onEnterFullScreen();
//     }
//   }
//   void _onEnterFullScreen() {
//     setState(() {
//       _isFullScreen = true;
//     });
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     _showPlayerControls();
//   }

//   void _onExitFullScreen() {
//     setState(() {
//       _isFullScreen = false;
//     });
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   }
//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         YoutubePlayerController(
//           initialVideoId: widget.videoId,
//           flags: const YoutubePlayerFlags(
//             autoPlay: true,
//             mute: false,
//             controlsVisibleAtStart: false, // Hide native controls
//           ),
//         )..addListener(() {
//           if (mounted) {
//             final position = _controller.value.position.inSeconds;
//             final duration = _controller.metadata.duration.inSeconds;
//             setState(() {
//               _isPlaying = _controller.value.isPlaying;
//               // Update progress
//               if (_controller.metadata.duration != Duration.zero) {
//                 _progress =
//                     _controller.value.position.inMilliseconds.toDouble() /
//                     _controller.metadata.duration.inMilliseconds.toDouble();
//               }
//               // Handle video completion
//               if (_isVideoCompleted && _controller.value.isPlaying) {
//                 _isVideoCompleted = false;
//               }
//               if (!_controller.value.isPlaying &&
//                   position >= (duration - 1) &&
//                   !_isVideoCompleted &&
//                   duration > 0) {
//                 _isVideoCompleted = true;
//               }
//             });
//           }
//         });

//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//           _isPlaying = _controller.value.isPlaying;
//         });
//         _showPlayerControls();
//       }
//     });

//     _loadComments();
//   }

//   Future<void> _loadComments() async {
//     final box = await Hive.openBox('commentsBox');
//     final storedComments =
//         box.get('comments_${widget.videoId}', defaultValue: []) as List;
//     final userBox = await Hive.openBox('userBox');
//     final username =
//         userBox.get('storeName', defaultValue: 'Anonymous') as String;

//     setState(() {
//       _comments = [];
//       for (var comment in storedComments) {
//         if (comment is String) {
//           _comments.add({
//             'username': username,
//             'comment': comment,
//             'timestamp': DateTime.now().toIso8601String(),
//           });
//         } else if (comment is Map) {
//           _comments.add(Map<String, dynamic>.from(comment));
//         }
//       }
//       box.put('comments_${widget.videoId}', _comments);
//     });
//   }

//   Future<void> _addComment(String comment) async {
//     if (comment.trim().isNotEmpty) {
//       final userBox = await Hive.openBox('userBox');
//       final username =
//           userBox.get('storeName', defaultValue: 'Anonymous') as String;
//       final box = await Hive.openBox('commentsBox');
//       final newComment = {
//         'username': username,
//         'comment': comment,
//         'timestamp': DateTime.now().toIso8601String(),
//       };
//       final updatedComments = List<Map<String, dynamic>>.from(_comments)
//         ..add(newComment);
//       await box.put('comments_${widget.videoId}', updatedComments);
//       setState(() {
//         _comments = updatedComments;
//         _commentController.clear();
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _hideTimer?.cancel();
//     _controller.dispose();
//     _commentController.dispose();
//     super.dispose();
//   }

//   Widget _buildVideoOverlay() {
//     return AnimatedOpacity(
//       opacity: _showControls ? 1.0 : 0.0,
//       duration: const Duration(milliseconds: 300),
//       child: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: Colors.transparent,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(
//                   onPressed: _skipBackward,
//                   icon: Icon(
//                     Icons.replay_10,
//                     color: Colors.white,
//                     size: _isFullScreen ? 40 : 30.sp,
//                   ),
//                   style: IconButton.styleFrom(
//                     backgroundColor: const Color(0x80001E6C),
//                   ),
//                   tooltip: 'Rewind 10 seconds',
//                 ),
//                 IconButton(
//                   onPressed: _togglePlayPause,
//                   icon: Icon(
//                     _isPlaying
//                         ? Icons.pause_circle_filled
//                         : Icons.play_circle_filled,
//                     color: Colors.white,
//                     size: _isFullScreen ? 60 : 50.sp,
//                   ),
//                   style: IconButton.styleFrom(
//                     backgroundColor: const Color(0x80001E6C),
//                   ),
//                   tooltip: _isPlaying ? 'Pause' : 'Play',
//                 ),
//                 IconButton(
//                   onPressed: _skipForward,
//                   icon: Icon(
//                     Icons.forward_10,
//                     color: Colors.white,
//                     size: _isFullScreen ? 40 : 30.sp,
//                   ),
//                   style: IconButton.styleFrom(
//                     backgroundColor: const Color(0x80001E6C),
//                   ),
//                   tooltip: 'Forward 10 seconds',
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFullScreenButton() {
//     return AnimatedOpacity(
//       opacity: _showControls ? 1.0 : 0.0,
//       duration: const Duration(milliseconds: 300),
//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color(0x80001E6C),
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         child: IconButton(
//           onPressed: _toggleFullScreen,
//           icon: Icon(
//             _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
//             color: Colors.white,
//             size: 24.sp,
//           ),
//           tooltip: _isFullScreen ? 'Exit full screen' : 'Enter full screen',
//         ),
//       ),
//     );
//   }

//   Widget _buildProgressBar() {
//     return Positioned(
//       bottom: 0,
//       left: 0,
//       right: 0,
//       child: SliderTheme(
//         data: SliderTheme.of(context).copyWith(
//           thumbColor: Colors.white,
//           activeTrackColor: Colors.red,
//           inactiveTrackColor: _isFullScreen
//               ? Colors.black.withOpacity(0.5)
//               : Colors.grey.withOpacity(0.3),
//           trackHeight: _isFullScreen ? 4 : 3,
//           overlayColor: Colors.transparent,
//         ),
//         child: Slider(
//           value: _progress,
//           min: 0.0,
//           max: 1.0,
//           onChanged: _controller.metadata.duration != Duration.zero
//               ? (value) {
//                   final position = Duration(
//                     milliseconds:
//                         (value * _controller.metadata.duration.inMilliseconds)
//                             .round(),
//                   );
//                   _controller.seekTo(position);
//                 }
//               : null,
//         ),
//       ),
//     );
//   }

//   Widget _buildCompletedOverlay() {
//     if (!_isVideoCompleted) return const SizedBox.shrink();
//     return Positioned.fill(
//       child: GestureDetector(
//         onTap: _replayVideo,
//         child: Container(
//           color: Colors.black54,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.replay_circle_filled,
//                 color: Colors.white,
//                 size: _isFullScreen ? 80 : 60,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'Video Completed',
//                 style: GoogleFonts.inter(
//                   fontSize: _isFullScreen ? 20 : 16.sp,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var box = Hive.box('userBox');
//     var name = box.get('storeName', defaultValue: 'Anonymous');
//     return YoutubePlayerBuilder(
//       // Remove onEnterFullScreen and onExitFullScreen to avoid conflicts
//       player: YoutubePlayer(
//         controller: _controller,
//         showVideoProgressIndicator: false, // Hide native progress, use custom
//         progressIndicatorColor: Colors.red,
//       ),
//       builder: (context, player) {
//         if (_isFullScreen) {
//           // Full screen layout - only player
//           return Scaffold(
//             backgroundColor: Colors.black,
//             body: GestureDetector(
//               onTap: _showPlayerControls,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   Center(child: player),
//                   // Overlay controls
//                   _buildVideoOverlay(),
//                   // Custom progress bar at bottom in full screen
//                   _buildProgressBar(),
//                   // Full screen exit button (top right)
//                   Positioned(
//                     top: 40,
//                     right: 16,
//                     child: _buildFullScreenButton(),
//                   ),
//                   // Completed overlay
//                   _buildCompletedOverlay(),
//                 ],
//               ),
//             ),
//           );
//         }
//         // Normal layout
//         return Scaffold(
//           backgroundColor: const Color(0xFFFFFFFF),
//           body: _isLoading
//               ? SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                   child: const Center(child: CircularProgressIndicator()),
//                 )
//               : Column(
//                   children: [
//                     GestureDetector(
//                       onTap: _showPlayerControls,
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.width * 9 / 16,
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             player,
//                             // Overlay controls
//                             _buildVideoOverlay(),
//                             // Custom progress bar at bottom in normal mode
//                             _buildProgressBar(),
//                             // Full screen button (top right)
//                             Positioned(
//                               top: 10.h,
//                               right: 10.w,
//                               child: _buildFullScreenButton(),
//                             ),
//                             // Completed overlay
//                             _buildCompletedOverlay(),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: EdgeInsets.all(16.w),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Comments',
//                               style: GoogleFonts.inter(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             SizedBox(height: 12.h),
//                             Expanded(
//                               child: _comments.isEmpty
//                                   ? Center(
//                                       child: Text(
//                                         'No comments yet.',
//                                         style: GoogleFonts.inter(
//                                           fontSize: 15.sp,
//                                           fontWeight: FontWeight.w500,
//                                           color: Colors.grey[600],
//                                         ),
//                                       ),
//                                     )
//                                   : ListView.builder(
//                                       padding: EdgeInsets.zero,
//                                       itemCount: _comments.length,
//                                       itemBuilder: (context, index) {
//                                         final comment = _comments[index];
//                                         final timestamp = DateTime.parse(
//                                           comment['timestamp'],
//                                         );
//                                         return Container(
//                                           margin: EdgeInsets.only(bottom: 12.h),
//                                           padding: EdgeInsets.all(12.w),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.circular(
//                                               12.r,
//                                             ),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.grey.withOpacity(
//                                                   0.2,
//                                                 ),
//                                                 spreadRadius: 2,
//                                                 blurRadius: 5,
//                                                 offset: const Offset(0, 3),
//                                               ),
//                                             ],
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   CircleAvatar(
//                                                     radius: 16.r,
//                                                     backgroundColor:
//                                                         const Color(0xFF001E6C),
//                                                     child: Text(
//                                                       comment['username'][0]
//                                                           .toString()
//                                                           .toUpperCase(),
//                                                       style: GoogleFonts.inter(
//                                                         fontSize: 12.sp,
//                                                         color: Colors.white,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   SizedBox(width: 8.w),
//                                                   Text(
//                                                     comment['username'],
//                                                     style: GoogleFonts.inter(
//                                                       fontSize: 14.sp,
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       color: Colors.black87,
//                                                     ),
//                                                   ),
//                                                   const Spacer(),
//                                                   Text(
//                                                     timeAgo(timestamp),
//                                                     style: GoogleFonts.inter(
//                                                       fontSize: 12.sp,
//                                                       color: Colors.grey[500],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(height: 8.h),
//                                               Text(
//                                                 comment['comment'],
//                                                 style: GoogleFonts.inter(
//                                                   fontSize: 14.sp,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.black87,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                     ),
//                             ),
//                             SizedBox(height: 12.h),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(12.r),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.withOpacity(0.1),
//                                           spreadRadius: 1,
//                                           blurRadius: 3,
//                                           offset: const Offset(0, 2),
//                                         ),
//                                       ],
//                                     ),
//                                     child: TextField(
//                                       controller: _commentController,
//                                       decoration: InputDecoration(
//                                         hintText: 'Add a comment...',
//                                         hintStyle: GoogleFonts.inter(
//                                           fontSize: 14.sp,
//                                           color: Colors.grey[500],
//                                         ),
//                                         border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                             12.r,
//                                           ),
//                                           borderSide: BorderSide.none,
//                                         ),
//                                         contentPadding: EdgeInsets.symmetric(
//                                           horizontal: 16.w,
//                                           vertical: 12.h,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 8.w),
//                                 ElevatedButton(
//                                   onPressed: () =>
//                                       _addComment(_commentController.text),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: const Color(0xFF001E6C),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12.r),
//                                     ),
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: 16.w,
//                                       vertical: 12.h,
//                                     ),
//                                   ),
//                                   child: Text(
//                                     'Comment',
//                                     style: GoogleFonts.inter(
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//         );
//       },
//     );
//   }
// }