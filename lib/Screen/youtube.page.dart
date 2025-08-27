// import 'package:eduma_app/Screen/youtubePlayScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// class YoutubePage extends StatefulWidget {
//   const YoutubePage({super.key});

//   @override
//   State<YoutubePage> createState() => _YoutubePageState();
// }

// class _YoutubePageState extends State<YoutubePage> {
//   final List<String> youtubeUrls = [
//     "https://www.youtube.com/watch?v=p8gXqMfF2uU",
//     "https://www.youtube.com/watch?v=jNQXAC9IVRw",
//     "https://www.youtube.com/watch?v=aqz-KE-bpKQ",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFFFFFF),
//       body: Stack(
//         children: [
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
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
//                 child: Text(
//                   "YouTube Video List",
//                   style: GoogleFonts.inter(
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10.h),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: youtubeUrls.length,
//                   padding: EdgeInsets.zero,
//                   itemBuilder: (context, index) {
//                     final url = youtubeUrls[index];
//                     final videoId = YoutubePlayerController.convertUrlToId(url);
//                     return Card(
//                       margin: const EdgeInsets.all(10),
//                       child: ListTile(
//                         leading: videoId != null
//                             ? Image.network(
//                                 "https://img.youtube.com/vi/$videoId/0.jpg",
//                                 width: 100,
//                                 fit: BoxFit.cover,
//                               )
//                             : const Icon(Icons.video_library),
//                         title: Text("Video ${index + 1}"),
//                         subtitle: Text(url),
//                         onTap: () {
//                           if (videoId != null) {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     YoutubePlayerScreen(videoId: videoId),
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubePage extends StatefulWidget {
  const YoutubePage({Key? key}) : super(key: key);

  @override
  State<YoutubePage> createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  final String youtubeChannelUrl =
      "https://www.youtube.com/channel/UCmFHSJGwYAsrtjF8xcVZOFw";

  @override
  void initState() {
    super.initState();
    _openYoutubeChannel();
  }

  Future<void> _openYoutubeChannel() async {
    final Uri url = Uri.parse(youtubeChannelUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication, 
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open YouTube channel")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Opening YouTube Channel..."),
      ),
    );
  }
}
