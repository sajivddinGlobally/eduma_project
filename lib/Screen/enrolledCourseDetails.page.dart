import 'package:eduma_app/Screen/youtubePlayScreen.dart';
import 'package:eduma_app/data/Controller/popularCourseController.dart';
import 'package:flutter/cupertino.dart';
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
      backgroundColor: Color(0xFFF5F7FA),
      body: courseDetailsProvider.when(
        data: (data) {
          return Stack(
            children: [
              Positioned(
                left: -150.w,
                top: -120.h,
                child: Opacity(
                  opacity: 0.1,
                  child: Image.asset(
                    "assets/vect.png",
                    width: 400.w,
                    height: 300.h,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Positioned(
                bottom: -60.h,
                right: -50.w,
                child: Opacity(
                  opacity: 0.1,
                  child: Image.asset(
                    "assets/vec.png",
                    width: 500.w,
                    height: 480.h,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 37.w,
                          height: 37.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(25, 0, 0, 0),
                          ),
                          child: IconButton(
                            style: IconButton.styleFrom(
                              minimumSize: Size(0, 0),
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Color(0xFF001E6C),
                              size: 20.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      data.title.toString(),
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF000000),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 10.w,
                          right: 10.w,
                          top: 10.h,
                          bottom: 10.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              spreadRadius: 0,
                              blurRadius: 4,
                              color: Color.fromARGB(63, 0, 0, 0),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: data.topics!
                                .expand(
                                  (topic) => topic.lessons!
                                      .map(
                                        (lession) => lessonTile(
                                          lession.lessonTitle.toString(),
                                          lession.lessonMeta!.video.toString(),
                                          lession.lessonTitle.toString(),
                                        ),
                                      )
                                      .toList(),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget lessonTile(String title, String video, String lessionTitle) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF000000),
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  //"${video.length} video",
                  "video",
                  style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF000000),
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
        children: [
          InkWell(
            onTap: () {
              final id = _extractYouTubeId(video);
              if (id.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => YoutubePlayerScreen(videoId: id),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Invalid YouTube link")),
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.only(left: 25.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.ondemand_video_outlined),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(8.r),
                  //   child: Image.network(
                  //     video.contains('youtube.com') || video.contains('youtu.be')
                  //         ? 'https://img.youtube.com/vi/${_extractYouTubeId(video)}/0.jpg'
                  //         : 'https://via.placeholder.com/100x60.png?text=Video',
                  //     width: 100.w,
                  //     height: 60.h,
                  //     fit: BoxFit.cover,
                  //     errorBuilder: (context, error, stackTrace) => Container(
                  //       width: 100.w,
                  //       height: 60.h,
                  //       color: Colors.grey,
                  //       child: Icon(
                  //         Icons.videocam,
                  //         color: Colors.white,
                  //         size: 30.sp,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      lessionTitle,
                      style: GoogleFonts.roboto(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF000000),
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _extractYouTubeId(String url) {
    // Extract YouTube video ID from URL
    RegExp regExp = RegExp(
      r'^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?v=))([^#\&\?]*).*',
      caseSensitive: false,
    );
    Match? match = regExp.firstMatch(url);
    return match != null && match.group(7)!.length == 11 ? match.group(7)! : '';
  }
}
