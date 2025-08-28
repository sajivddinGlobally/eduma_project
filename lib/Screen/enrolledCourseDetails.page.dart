import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EnrolledDourseDetailsPage extends StatefulWidget {
  const EnrolledDourseDetailsPage({super.key});

  @override
  State<EnrolledDourseDetailsPage> createState() =>
      _EnrolledDourseDetailsPageState();
}

class _EnrolledDourseDetailsPageState extends State<EnrolledDourseDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: Stack(
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
                  "title",
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF000000),
                  ),
                ),
                Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "txt",
              style: GoogleFonts.roboto(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF000000),
                letterSpacing: -0.4,
                height: 1.1,
              ),
            ),
            Text(
              "{videos.length} Video(s)",
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF000000),
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        children: videos
            .map(
              (video) => GestureDetector(
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
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          video.contains('youtube.com') ||
                                  video.contains('youtu.be')
                              ? 'https://img.youtube.com/vi/${_extractYouTubeId(video)}/0.jpg'
                              : 'https://via.placeholder.com/100x60.png?text=Video',
                          width: 100.w,
                          height: 60.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 100.w,
                                height: 60.h,
                                color: Colors.grey,
                                child: Icon(
                                  Icons.videocam,
                                  color: Colors.white,
                                  size: 30.sp,
                                ),
                              ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          video,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
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
            )
            .toList(),
      ),
    ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
