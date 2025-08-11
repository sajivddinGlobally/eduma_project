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
      {'text': "Hello", 'isSender': true},
      {'text': "Does this has features similar to my phone?", 'isSender': true},
      {
        'text': "Yes this product has same feature as the one you told me ",
        'isSender': false,
      },
      {'text': "Awesome, thanks for letting me know!", 'isSender': true},
      {'text': "When can i expect this product Delivery ?", 'isSender': true},
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
      body: SingleChildScrollView(
        child: Column(
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
            Container(
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
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
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
          ],
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 74.h,
        decoration: BoxDecoration(color: Color(0xffFFFFFF)),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            bottom: 13.h,
            top: 13.h,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 233, 232, 235),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    hint: Text(
                      "Type Message",
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 140, 140, 148),
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: () {
                  _handleSendMessage();
                },
                child: Container(
                  width: 48.w,
                  height: 46.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Color(0xff4A3DFE),
                  ),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ),
            ],
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
          color: isSender ? Color(0xff00D0B8) : Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(isSender ? 16.r : 0),
            bottomRight: Radius.circular(isSender ? 0 : 16.r),
          ),
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
