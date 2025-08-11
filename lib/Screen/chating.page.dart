import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatingPage extends StatefulWidget {
  const ChatingPage({super.key});

  @override
  State<ChatingPage> createState() => _ChatingPageState();
}

class _ChatingPageState extends State<ChatingPage> {
  final messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // ✅ Add message list
  final List<Map<String, dynamic>> _messages = [];

  void _handleSendMessage() {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({'text': text, 'isSender': true});
      });
      messageController.clear();

      // ✅ Scroll to bottom after sending
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // ✅ Optional: preload some messages
    _messages.addAll([
      {'text': "And the HR round?", 'isSender': true},
      {
        'text':
            "Be honest and confident. Practice answers for common questions like strengths, weaknesses, and career goals.",
        'isSender': false,
      },
      {'text': "Any tips to stay calm?", 'isSender': true},
      {
        'text':
            "Stick to a schedule, practice mock interviews, and take breaks. Rejections happen—learn and move forward.",
        'isSender': false,
      },
      {'text': "Thanks! This really helps.", 'isSender': true},
    ]);

    // ✅ Scroll after a frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B1B1B),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40.h),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.w),
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF262626),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 6.w),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Mike Pena",
                    style: GoogleFonts.roboto(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Online",
                    style: GoogleFonts.roboto(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFDCF881),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(right: 20.w),
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF262626),
                ),
                child: Icon(
                  Icons.more_horiz_outlined,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: AnimatedPadding(
                      duration: Duration(milliseconds: 100),
                      padding: EdgeInsets.only(bottom: 80.h),
                      child: SingleChildScrollView(
                        controller: _scrollController, // ✅ Important
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            right: 20.w,
                            top: 20.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                itemCount: _messages.length,
                                //reverse: false,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final message = _messages[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: ChatBubble(
                                      message: message['text'],
                                      isSender: message['isSender'],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 10.h),
          child: TextField(
            controller: messageController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 16.h,
                bottom: 16.h,
              ),
              filled: true,
              fillColor: Color(0xFFF1F2F6),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.r),
                borderSide: BorderSide.none,
              ),
              hint: Text(
                "Enter Message...",
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 140, 140, 148),
                  letterSpacing: -0.2,
                ),
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.all(12), // kam padding
                child: CircleAvatar(
                  radius: 12.r,
                  backgroundColor: Color(0xFF001E6C),
                  child: Icon(Icons.add, size: 16.sp, color: Colors.white),
                ),
              ),
              suffixIcon: IconButton(
                style: IconButton.styleFrom(
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  _handleSendMessage();
                },
                icon: Icon(Icons.send, color: Color(0xFF001E6C)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  const ChatBubble({super.key, required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isSender ? Color(0xFF001E6C) : Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isSender ? 16.r : 0),
            topRight: Radius.circular(isSender ? 0 : 16.r),
            bottomLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          ),
          border: Border.all(color: Color(0xFF263238)),
        ),
        child: Text(
          message,
          style: GoogleFonts.roboto(
            fontSize: 17.sp,
            fontWeight: FontWeight.w400,
            color: isSender ? Colors.white : Color(0xFF2B2B2B),
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }
}
