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

import 'dart:developer';
import 'dart:io' show Directory, Platform;
import 'package:dio/dio.dart';
import 'package:eduma_app/Screen/payCourseDetails.page.dart';
import 'package:eduma_app/Screen/video.page.dart';
import 'package:eduma_app/data/Controller/popularCourseController.dart';
import 'package:eduma_app/data/Model/popularCourseDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

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
                  // Expanded(
                  //   child: ListView.builder(
                  //     padding: EdgeInsets.zero,
                  //     itemCount: data.topics!.length ?? 0,
                  //     itemBuilder: (context, topicIndex) {
                  //       final topic = data.topics![topicIndex];
                  //       return Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           // ✅ Lessons ko MyLession widget ke through map karo
                  //           ...topic.lessons!.map(
                  //             (lesson) => MyLession(
                  //               title: lesson.lessonTitle ?? "Untitled Lesson",
                  //               videoUrl:
                  //                   lesson.lessonMeta?.video?.firstOrNull
                  //                       ?.toString() ??
                  //                   "",
                  //               attachments: lesson.attachments,
                  //             ),
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   ),
                  // ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: data.topics?.length ?? 0,
                      itemBuilder: (context, topicIndex) {
                        final topic = data.topics![topicIndex];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...topic.lessons!.map(
                              (lesson) => ModuleLessionWidget(
                                title: lesson.lessonTitle ?? "Untitled Lesson",
                                videoUrl:
                                    lesson.lessonMeta?.video?.firstOrNull
                                        ?.toString() ??
                                    "",
                                attachments: lesson.attachments,
                                lessonContent: lesson
                                    .lessonContent, // ✅ Added lesson_content
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
}

// class ModuleLessionWidget extends StatefulWidget {
//   final String title;
//   final String? videoUrl;
//   final List<Attachment>? attachments;
//   final String? lessonContent;

//   const ModuleLessionWidget({
//     super.key,
//     required this.title,
//     this.videoUrl,
//     this.attachments,
//     this.lessonContent,
//   });

//   @override
//   State<ModuleLessionWidget> createState() => _ModuleLessionWidgetState();
// }

// class _ModuleLessionWidgetState extends State<ModuleLessionWidget> {
//   bool isDownloading = false;
//   double downloadProgress = 0.0;
//   bool isDownloadComplete = false;

//   String extractYouTubeId(String url) {
//     if (url.contains("youtu")) {
//       final regExp = RegExp(r'(?:v=|\/)([0-9A-Za-z_-]{11}).*');
//       final match = regExp.firstMatch(url);
//       if (match != null) return match.group(1)!;

//       final uri = Uri.tryParse(url);
//       if (uri != null && uri.pathSegments.contains("live")) {
//         return uri.pathSegments.last;
//       }
//     }
//     return '';
//   }

//   String? extractPdfUrlFromContent(String? content) {
//     if (content == null || content.isEmpty) return null;
//     RegExp regExp = RegExp(r'\[pdf-embedder url="([^"]+)"');
//     Match? match = regExp.firstMatch(content);
//     return match?.group(1);
//   }

//   Future<String?> downloadPdf(String url, String fileName) async {
//     try {
//       if (Platform.isAndroid) {
//         if (await Permission.storage.isDenied) {
//           await Permission.storage.request();
//         }
//         if (await Permission.manageExternalStorage.isDenied) {
//           await Permission.manageExternalStorage.request();
//         }
//       }

//       fileName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');

//       String? filePath;
//       if (Platform.isAndroid &&
//           await Permission.manageExternalStorage.isGranted) {
//         final downloadsDir = Directory('/storage/emulated/0/Download');
//         if (!downloadsDir.existsSync()) {
//           downloadsDir.createSync(recursive: true);
//         }
//         filePath = path.join(downloadsDir.path, fileName);
//       } else {
//         final dir = await getApplicationDocumentsDirectory();
//         if (!dir.existsSync()) dir.createSync(recursive: true);
//         filePath = path.join(dir.path, fileName);
//       }

//       await Dio().download(
//         url,
//         filePath,
//         options: Options(
//           followRedirects: true,
//           responseType: ResponseType.bytes,
//           headers: {"Accept": "application/pdf"},
//           validateStatus: (status) => status != null && status < 500,
//         ),
//         onReceiveProgress: (received, total) {
//           if (total != -1 && mounted) {
//             setState(() {
//               downloadProgress = (received / total * 100).clamp(0, 100);
//             });
//           }
//         },
//       );

//       log("✅ PDF download complete: $filePath");
//       return filePath; // bas path return karo
//     } catch (e) {
//       log("❌ PDF download error: $e");
//       return null;
//     }
//   }

//   String? parseVideoUrl(String? videoData) {
//     if (videoData == null || videoData.isEmpty) return null;

//     try {
//       final externalUrlRegex = RegExp(
//         r'source_external_url";s:\d+:"(https?://[^"]+)"',
//         multiLine: true,
//       );
//       final match = externalUrlRegex.firstMatch(videoData);
//       if (match != null) {
//         return match.group(1);
//       }

//       final youtubeRegex = RegExp(
//         r'(https?:\/\/(?:www\.)?youtu(?:be\.com|\.be)/[^\s"]+)',
//         multiLine: true,
//       );
//       final youtubeMatch = youtubeRegex.firstMatch(videoData);
//       if (youtubeMatch != null) return youtubeMatch.group(1);

//       return null;
//     } catch (e) {
//       log("❌ Error parsing video URL: $e");
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final videoUrl = parseVideoUrl(widget.videoUrl);
//     final videoId = videoUrl != null ? extractYouTubeId(videoUrl) : '';
//     final isVideoAvailable = videoUrl != null && videoUrl.isNotEmpty;

//     final pdfAttachment = widget.attachments?.firstWhere(
//       (attachment) => attachment.type?.toLowerCase() == "application/pdf",
//       orElse: () => Attachment(),
//     );

//     final pdfUrlFromContent = extractPdfUrlFromContent(widget.lessonContent);
//     final isPdfAvailable =
//         (pdfAttachment?.url != null && pdfAttachment!.url!.isNotEmpty) ||
//         pdfUrlFromContent != null;

//     final bool isPdfTitle = widget.title.toLowerCase().contains("pdf");

//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//       margin: EdgeInsets.symmetric(vertical: 8.h),
//       elevation: 2,
//       child: ExpansionTile(
//         tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//         childrenPadding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
//         collapsedShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         backgroundColor: Colors.white,
//         collapsedBackgroundColor: Colors.white,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.title,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: GoogleFonts.roboto(
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: 4.h),
//             Text(
//               isPdfTitle
//                   ? (isPdfAvailable ? "1 PDF" : "No PDF Available")
//                   : (isVideoAvailable ? "1 Video" : "No Video Available"),
//               style: GoogleFonts.roboto(
//                 fontSize: 13.sp,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//         children: [
//           if (isPdfTitle && isPdfAvailable)
//             Row(
//               children: [
//                 Icon(
//                   Icons.picture_as_pdf,
//                   size: 50.sp,
//                   color: Color(0xFF3e64de),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: Text(
//                     "${pdfAttachment!.title ?? widget.title} (PDF)",
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: GoogleFonts.roboto(
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//                 isDownloading
//                     ? Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           SizedBox(
//                             height: 28.w,
//                             width: 28.w,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               value: downloadProgress / 100,
//                               color: Color(0xFF3e64de),
//                             ),
//                           ),
//                           Text(
//                             "${downloadProgress.toStringAsFixed(0)}%",
//                             style: GoogleFonts.roboto(
//                               fontSize: 10.sp,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ],
//                       )
//                     : IconButton(
//                         icon: Icon(
//                           isDownloadComplete
//                               ? Icons.check_circle
//                               : Icons.downloading_sharp,
//                           size: 28.sp,
//                           color: isDownloadComplete
//                               ? Colors.green
//                               : Colors.black,
//                         ),
//                         onPressed: isDownloadComplete
//                             ? null
//                             : () async {
//                                 setState(() {
//                                   isDownloading = true;
//                                   downloadProgress = 0.0;
//                                   isDownloadComplete = false;
//                                 });

//                                 final filePath = await downloadPdf(
//                                   pdfAttachment.url!,
//                                   pdfAttachment.title ?? "${widget.title}.pdf",
//                                 );

//                                 if (filePath != null && mounted) {
//                                   setState(() {
//                                     isDownloading = false;
//                                     isDownloadComplete = true;
//                                   });

//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text(
//                                         "PDF downloaded at: $filePath",
//                                       ),
//                                     ),
//                                   );

//                                   // yaha open karna hai sirf ek jagah
//                                   final result = await OpenFilex.open(filePath);
//                                   log("📂 OpenFilex result: ${result.message}");
//                                 } else {
//                                   setState(() {
//                                     isDownloading = false;
//                                   });

//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text("Download failed"),
//                                     ),
//                                   );
//                                 }
//                               },
//                       ),
//               ],
//             ),
//           if (!isPdfTitle && isVideoAvailable)
//             InkWell(
//               onTap: () {
//                 final videoUrl = parseVideoUrl(widget.videoUrl);
//                 final videoId = videoUrl != null
//                     ? extractYouTubeId(videoUrl)
//                     : '';
//                 log("✅ videoUrl: $videoUrl");
//                 log("✅ videoId: $videoId");

//                 if (videoId.isNotEmpty) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => VideoPage(videoId: videoId),
//                     ),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("No Video Available")),
//                   );
//                 }
//               },
//               child: Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(
//                       videoId.isNotEmpty
//                           ? "https://img.youtube.com/vi/$videoId/0.jpg"
//                           : "https://via.placeholder.com/120x90.png?text=No+Video",
//                       width: 120.w,
//                       height: 70.h,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return ClipRRect(
//                           borderRadius: BorderRadius.circular(10.r),
//                           child: Image.network(
//                             "https://t4.ftcdn.net/jpg/05/97/47/95/360_F_597479556_7bbQ7t4Z8k3xbAloHFHVdZIizWK1PdOo.jpg",
//                             width: 120.w,
//                             height: 70.h,
//                             fit: BoxFit.cover,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(width: 12.w),
//                   Expanded(
//                     child: Text(
//                       widget.title,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: GoogleFonts.roboto(
//                         fontSize: 15.sp,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                   Icon(
//                     Icons.play_circle_fill,
//                     size: 28.sp,
//                     color: Colors.redAccent,
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

class ModuleLessionWidget extends StatefulWidget {
  final String title;
  final String? videoUrl;
  final List<Attachment>? attachments;
  final String? lessonContent;

  const ModuleLessionWidget({
    super.key,
    required this.title,
    this.videoUrl,
    this.attachments,
    this.lessonContent,
  });

  @override
  State<ModuleLessionWidget> createState() => _ModuleLessionWidgetState();
}

class _ModuleLessionWidgetState extends State<ModuleLessionWidget> {
  bool isDownloading = false;
  double downloadProgress = 0.0;
  bool isDownloadComplete = false;

  String extractYouTubeId(String url) {
    if (url.contains("youtu")) {
      final regExp = RegExp(r'(?:v=|\/)([0-9A-Za-z_-]{11}).*');
      final match = regExp.firstMatch(url);
      if (match != null) return match.group(1)!;

      final uri = Uri.tryParse(url);
      if (uri != null && uri.pathSegments.contains("live")) {
        return uri.pathSegments.last;
      }
    }
    return '';
  }

  String? extractPdfUrlFromContent(String? content) {
    if (content == null || content.isEmpty) return null;
    RegExp regExp = RegExp(r'\[pdf-embedder url="([^"]+)"');
    Match? match = regExp.firstMatch(content);
    return match?.group(1);
  }

  Future<String?> downloadPdf(String url, String fileName) async {
    try {
      if (Platform.isAndroid) {
        if (await Permission.storage.isDenied) {
          await Permission.storage.request();
        }
        if (await Permission.manageExternalStorage.isDenied) {
          await Permission.manageExternalStorage.request();
        }
      }

      fileName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');

      String? filePath;
      if (Platform.isAndroid &&
          await Permission.manageExternalStorage.isGranted) {
        final downloadsDir = Directory('/storage/emulated/0/Download');
        if (!downloadsDir.existsSync())
          downloadsDir.createSync(recursive: true);
        filePath = path.join(downloadsDir.path, fileName);
      } else {
        final dir = await getApplicationDocumentsDirectory();
        if (!dir.existsSync()) dir.createSync(recursive: true);
        filePath = path.join(dir.path, fileName);
      }

      await Dio().download(
        url,
        filePath,
        options: Options(
          followRedirects: true,
          responseType: ResponseType.bytes,
          headers: {"Accept": "application/pdf"},
          validateStatus: (status) => status != null && status < 500,
        ),
        onReceiveProgress: (received, total) {
          if (total != -1 && mounted) {
            setState(() {
              downloadProgress = (received / total * 100).clamp(0, 100);
            });
          }
        },
      );

      log("✅ PDF download complete: $filePath");
      return filePath;
    } catch (e) {
      log("❌ PDF download error: $e");
      return null;
    }
  }

  String? parseVideoUrl(String? videoData) {
    if (videoData == null || videoData.isEmpty) return null;

    try {
      final externalUrlRegex = RegExp(
        r'source_external_url";s:\d+:"(https?://[^"]+)"',
        multiLine: true,
      );
      final match = externalUrlRegex.firstMatch(videoData);
      if (match != null) return match.group(1);

      final youtubeRegex = RegExp(
        r'(https?:\/\/(?:www\.)?youtu(?:be\.com|\.be)/[^\s"]+)',
        multiLine: true,
      );
      final youtubeMatch = youtubeRegex.firstMatch(videoData);
      if (youtubeMatch != null) return youtubeMatch.group(1);

      return null;
    } catch (e) {
      log("❌ Error parsing video URL: $e");
      return null;
    }
  }

  Future<void> _openFile(String filePath) async {
    final result = await OpenFilex.open(filePath, type: "application/pdf");
    log("📂 OpenFilex result: ${result.message}");
  }

  @override
  Widget build(BuildContext context) {
    final videoUrl = parseVideoUrl(widget.videoUrl);
    final videoId = videoUrl != null ? extractYouTubeId(videoUrl) : '';
    final isVideoAvailable = videoUrl != null && videoUrl.isNotEmpty;

    final pdfAttachment = widget.attachments?.firstWhere(
      (attachment) => attachment.type?.toLowerCase() == "application/pdf",
      orElse: () => Attachment(),
    );

    final pdfUrlFromContent = extractPdfUrlFromContent(widget.lessonContent);

    // Null safe check
    final pdfUrl = pdfAttachment?.url ?? pdfUrlFromContent;
    final pdfTitle = pdfAttachment?.title ?? widget.title;

    final isPdfAvailable = pdfUrl != null;

    final bool isPdfTitle = widget.title.toLowerCase().contains("pdf");

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
              widget.title,
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
              isPdfTitle
                  ? (isPdfAvailable ? "1 PDF" : "No PDF Available")
                  : (isVideoAvailable ? "1 Video" : "No Video Available"),
              style: GoogleFonts.roboto(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        children: [
          if (isPdfTitle && isPdfAvailable)
            Row(
              children: [
                Icon(
                  Icons.picture_as_pdf,
                  size: 50.sp,
                  color: Color(0xFF3e64de),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    "$pdfTitle (PDF)",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                isDownloading
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 28.w,
                            width: 28.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              value: downloadProgress / 100,
                              color: Color(0xFF3e64de),
                            ),
                          ),
                          Text(
                            "${downloadProgress.toStringAsFixed(0)}%",
                            style: GoogleFonts.roboto(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      )
                    : IconButton(
                        icon: Icon(
                          isDownloadComplete
                              ? Icons.check_circle
                              : Icons.downloading_sharp,
                          size: 28.sp,
                          color: isDownloadComplete
                              ? Colors.green
                              : Colors.black,
                        ),
                        onPressed: isDownloadComplete
                            ? null
                            : () async {
                                if (pdfUrl == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("No PDF URL available"),
                                    ),
                                  );
                                  return;
                                }

                                setState(() {
                                  isDownloading = true;
                                  downloadProgress = 0.0;
                                  isDownloadComplete = false;
                                });

                                final filePath = await downloadPdf(
                                  pdfUrl,
                                  "$pdfTitle.pdf",
                                );

                                if (filePath != null && mounted) {
                                  setState(() {
                                    isDownloading = false;
                                    isDownloadComplete = true;
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "PDF downloaded at: $filePath",
                                      ),
                                    ),
                                  );

                                  await _openFile(filePath);
                                } else if (mounted) {
                                  setState(() => isDownloading = false);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Download failed"),
                                    ),
                                  );
                                }
                              },
                      ),
              ],
            ),
          if (!isPdfTitle && isVideoAvailable)
            InkWell(
              onTap: () {
                if (videoId.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VideoPage(videoId: videoId),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No Video Available")),
                  );
                }
              },
              child: Row(
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
                      widget.title,
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
            ),
        ],
      ),
    );
  }
}

class MyLession extends StatefulWidget {
  final String title;
  final String videoUrl;
  final List<Attachment>? attachments;

  const MyLession({
    super.key,
    required this.title,
    required this.videoUrl,
    this.attachments,
  });

  @override
  State<MyLession> createState() => _MyLessionState();
}

class _MyLessionState extends State<MyLession> {
  bool isDownloading = false;
  double downloadProgress = 0.0;
  bool isDownloadComplete = false;

  String extractYouTubeId(String url) {
    RegExp regExp = RegExp(
      r'^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?v=))([^#\&\?]*).*',
      caseSensitive: false,
    );
    Match? match = regExp.firstMatch(url);
    return match != null && match.group(7)!.length == 11 ? match.group(7)! : '';
  }

  String? extractPdfUrlFromContent(String? content) {
    if (content == null || content.isEmpty) return null;
    RegExp regExp = RegExp(r'\[pdf-embedder url="([^"]+)"');
    Match? match = regExp.firstMatch(content);
    return match?.group(1);
  }

  Future<String?> downloadPdf(String url, String fileName) async {
    try {
      if (Platform.isAndroid) {
        if (!await Permission.storage.isGranted) {
          await Permission.storage.request();
        }
      }

      Directory dir =
          await getExternalStorageDirectory() ??
          await getApplicationDocumentsDirectory();

      if (!dir.existsSync()) dir.createSync(recursive: true);

      fileName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');

      final filePath = "${dir.path}/$fileName";

      await Dio().download(
        url,
        filePath,
        options: Options(
          followRedirects: true,
          responseType: ResponseType.bytes,
          headers: {"Accept": "application/pdf"},
          validateStatus: (status) => status != null && status < 500,
        ),
        onReceiveProgress: (receive, total) {
          if (total != -1 && mounted) {
            setState(() {
              downloadProgress = (receive / total * 100).clamp(0, 100);
            });
          }
        },
      );
      log("✅ PDF download complete: $filePath");
      if (mounted) {
        setState(() {
          isDownloadComplete = true;
        });
      }
      return filePath;
    } catch (e) {
      log("❌ Error: $e");
      if (mounted) {
        isDownloadComplete = false;
        downloadProgress = 0.0;
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoId = extractYouTubeId(widget.videoUrl);

    final pdfAttachment = widget.attachments?.firstWhere(
      (attachment) => attachment.type?.toLowerCase() == "application/pdf",
      orElse: () => Attachment(),
    );

    final isPdfAvailable =
        pdfAttachment != null &&
        pdfAttachment.url != null &&
        pdfAttachment.url!.isNotEmpty;

    final isVideoAvailable = videoId.isNotEmpty;

    final bool isPdfTitle = widget.title.toLowerCase().contains("pdf");

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
              widget.title,
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
              isPdfTitle
                  ? (isPdfAvailable ? "1 PDF" : "No PDF Available")
                  : (isVideoAvailable ? "1 Video" : "No Video Available"),
              style: GoogleFonts.roboto(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        children: [
          if (isPdfTitle && isPdfAvailable)
            Row(
              children: [
                Icon(Icons.picture_as_pdf, size: 50.sp, color: Colors.red),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    "${pdfAttachment!.title ?? widget.title} (PDF)",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                isDownloading
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 28.w,
                            width: 28.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              value: downloadProgress / 100,
                              color: Color(0xFF3e64de),
                            ),
                          ),
                          Text(
                            "${downloadProgress.toStringAsFixed(0)}%",
                            style: GoogleFonts.roboto(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      )
                    : IconButton(
                        icon: Icon(
                          isDownloadComplete
                              ? Icons.check_circle
                              : Icons.downloading_sharp,
                          size: 28.sp,
                          color: isDownloadComplete
                              ? Colors.green
                              : Colors.black,
                        ),
                        onPressed: isDownloadComplete
                            ? null
                            : () async {
                                setState(() {
                                  isDownloading = true;
                                  downloadProgress = 0.0;
                                  isDownloadComplete = false;
                                });
                                final filePath = await downloadPdf(
                                  pdfAttachment.url!,
                                  pdfAttachment.title ?? "${widget.title}.pdf",
                                );

                                if (filePath != null && context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "PDF download complete: $filePath",
                                      ),
                                    ),
                                  );
                                  await OpenFilex.open(
                                    filePath,
                                    type: "application/pdf",
                                  );
                                } else if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Download failed"),
                                    ),
                                  );
                                }
                                if (mounted) {
                                  setState(() {
                                    isDownloading = false;
                                  });
                                }
                              },
                      ),
              ],
            ),
          if (!isPdfTitle && isVideoAvailable)
            InkWell(
              onTap: () {
                if (videoId.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VideoPage(videoId: videoId),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No Video Available")),
                  );
                }
              },
              child: Row(
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
                      widget.title,
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
            ),
        ],
      ),
    );
  }
}
