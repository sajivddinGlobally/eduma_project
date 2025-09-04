// import 'package:eduma_app/Screen/youtubePlayScreen.dart';
// import 'package:eduma_app/data/Controller/popularCourseController.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class EnrolledDourseDetailsPage extends ConsumerStatefulWidget {
//   final String id;
//   const EnrolledDourseDetailsPage({super.key, required this.id});

//   @override
//   ConsumerState<EnrolledDourseDetailsPage> createState() =>
//       _EnrolledDourseDetailsPageState();
// }

// class _EnrolledDourseDetailsPageState
//     extends ConsumerState<EnrolledDourseDetailsPage> {
//   @override
//   Widget build(BuildContext context) {
//     final courseDetailsProvider = ref.watch(
//       popularCourseDetailsController(widget.id),
//     );
//     return Scaffold(
//       backgroundColor: Color(0xFFF5F7FA),
//       body: courseDetailsProvider.when(
//         data: (data) {
//           return Stack(
//             children: [
//               Positioned(
//                 left: -150.w,
//                 top: -120.h,
//                 child: Opacity(
//                   opacity: 0.1,
//                   child: Image.asset(
//                     "assets/vect.png",
//                     width: 400.w,
//                     height: 300.h,
//                     fit: BoxFit.fitHeight,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: -60.h,
//                 right: -50.w,
//                 child: Opacity(
//                   opacity: 0.1,
//                   child: Image.asset(
//                     "assets/vec.png",
//                     width: 500.w,
//                     height: 480.h,
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 37.w,
//                           height: 37.h,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Color.fromARGB(25, 0, 0, 0),
//                           ),
//                           child: IconButton(
//                             style: IconButton.styleFrom(
//                               minimumSize: Size(0, 0),
//                               padding: EdgeInsets.zero,
//                               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                             ),
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             icon: Icon(
//                               Icons.arrow_back,
//                               color: Color(0xFF001E6C),
//                               size: 20.sp,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 16.w),
//                       ],
//                     ),
//                     SizedBox(height: 30.h),
//                     Text(
//                       data.title.toString(),
//                       style: GoogleFonts.inter(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xFF000000),
//                       ),
//                     ),
//                     SizedBox(height: 30.h),
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.only(
//                           left: 10.w,
//                           right: 10.w,
//                           top: 10.h,
//                           bottom: 10.h,
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.r),
//                           color: Color(0xFFFFFFFF),
//                           boxShadow: [
//                             BoxShadow(
//                               offset: Offset(0, 1),
//                               spreadRadius: 0,
//                               blurRadius: 4,
//                               color: Color.fromARGB(63, 0, 0, 0),
//                             ),
//                           ],
//                         ),
//                         child: SingleChildScrollView(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: data.topics!
//                                 .expand(
//                                   (topic) => topic.lessons!
//                                       .map(
//                                         (lesson) => lessonTile(
//                                           lesson.lessonTitle.toString(),
//                                           lesson.lessonMeta!.video.toString(),
//                                         ),
//                                       )
//                                       .toList(),
//                                 )
//                                 .toList(),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//         error: (error, stackTrace) => Center(child: Text(error.toString())),
//         loading: () => Center(child: CircularProgressIndicator()),
//       ),
//     );
//   }

//   Widget lessonTile(String title, String video) {
//     return Theme(
//       data: Theme.of(context).copyWith(
//         dividerColor: Colors.transparent,
//         splashColor: Colors.transparent,
//         highlightColor: Colors.transparent,
//       ),
//       child: ExpansionTile(
//         tilePadding: EdgeInsets.zero,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 15.w),
//               child: Text(
//                 title,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: GoogleFonts.roboto(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w600,
//                   color: const Color(0xFF000000),
//                   letterSpacing: -0.3,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 15.w),
//               child: Text(
//                 "1 Video",
//                 style: GoogleFonts.roboto(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w400,
//                   color: const Color(0xFF000000),
//                 ),
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Divider(color: Color(0xFFBFBFBF)),
//           ],
//         ),
//         children: [
//           InkWell(
//             onTap: () {
//               final id = _extractYouTubeId(video);
//               if (id.isNotEmpty) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => YoutubePlayerScreen(videoId: id),
//                   ),
//                 );
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("Invalid YouTube link")),
//                 );
//               }
//             },
//             child: Padding(
//               padding: EdgeInsets.only(left: 25.w, bottom: 10.h),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Icon(Icons.ondemand_video_outlined, size: 24.sp),
//                   SizedBox(width: 10.w),
//                   Expanded(
//                     child: Text(
//                       title,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: GoogleFonts.roboto(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w400,
//                         color: const Color(0xFF000000),
//                         letterSpacing: -0.3,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _extractYouTubeId(String url) {
//     // Extract YouTube video ID from URL
//     RegExp regExp = RegExp(
//       r'^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?v=))([^#\&\?]*).*',
//       caseSensitive: false,
//     );
//     Match? match = regExp.firstMatch(url);
//     return match != null && match.group(7)!.length == 11 ? match.group(7)! : '';
//   }
// }

import 'package:eduma_app/Screen/video.page.dart';
import 'package:eduma_app/data/Controller/popularCourseController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EnrolledDourseDetailsPage extends ConsumerStatefulWidget {
  final String id;
  const EnrolledDourseDetailsPage({super.key, required this.id});

  @override
  ConsumerState<EnrolledDourseDetailsPage> createState() =>
      _EnrolledDourseDetailsPageState();
}

class _EnrolledDourseDetailsPageState
    extends ConsumerState<EnrolledDourseDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final courseDetailsProvider = ref.watch(
      popularCourseDetailsController(widget.id),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: courseDetailsProvider.when(
          data: (data) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.05),
                        radius: 18.r,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.arrow_back,
                            size: 20.sp,
                            color: const Color(0xFF001E6C),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    data.title ?? "Untitled Course",
                    style: GoogleFonts.inter(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: data.topics!.length ?? 0,
                      itemBuilder: (context, topicIndex) {
                        final topic = data.topics![topicIndex];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...topic.lessons!.map(
                              (lesson) => _lessonTile(
                                lesson.lessonTitle ?? "Untitled Lesson",
                                lesson.lessonMeta!.video.toString(),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) =>
              Center(child: Text("Error: ${error.toString()}")),
          loading: () =>
              const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
      ),
    );
  }

  Widget _lessonTile(String title, String videoUrl) {
    final videoId = _extractYouTubeId(videoUrl);
    final displayTitle = videoId.isNotEmpty ? title : "No Video";
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      elevation: 2,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        childrenPadding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              videoId.isNotEmpty ? "1 Video" : "No Video Available",
              style: GoogleFonts.roboto(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () {
              if (videoId.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => VideoPge(videoId: videoId)),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No Video Available")),
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Divider(color: Color(0xFFBFBFBF), thickness: 0.90.w),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        videoId.isNotEmpty
                            ? "https://img.youtube.com/vi/$videoId/0.jpg"
                            : "https://via.placeholder.com/120x90.png?text=No+Video",
                        width: 120.w,
                        height: 70.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.network(
                              "https://t4.ftcdn.net/jpg/05/97/47/95/360_F_597479556_7bbQ7t4Z8k3xbAloHFHVdZIizWK1PdOo.jpg",
                              width: 120.w,
                              height: 70.h,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        displayTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    Icon(
                      Icons.play_circle_fill,
                      size: 28.sp,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _extractYouTubeId(String url) {
    final regExp = RegExp(
      r'^.*((youtu.be/)|(v/)|(u/\w/)|(embed/)|(watch\?v=))([^#&?]*).*',
      caseSensitive: false,
    );
    final match = regExp.firstMatch(url);
    return match != null && match.group(7)!.length == 11 ? match.group(7)! : "";
  }
}
