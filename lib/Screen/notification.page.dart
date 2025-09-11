import 'dart:developer';
import 'package:eduma_app/data/Controller/notificationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  @override
  void initState() {
    super.initState();
    // ✅ Page open होने पर unread रीसेट करें
    Future.microtask(() {
      ref.read(showNotification.notifier).resetUnread();
    });
  }

  // @override
  // void dispose() {
  //   ref.read(showNotification.notifier).leaveNotificationPage();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userBox");
    var id = box.get("storeId");
    final notificationProvider = ref.watch(
      notifcationController(id.toString()),
    );
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 24,
          ),
          onPressed: () {
            //  ref.read(showNotification.notifier).leaveNotificationPage();
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: notificationProvider.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(child: Text("No Notification"));
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return NotificationCard(
                title: data[index].title,
                message: data[index].content,
                time: data[index].createdAt.toString(),
                onTap: () {},
              );
            },
          );
        },
        error: (error, stackTrace) {
          log(stackTrace.toString());
          return Center(
            child: Text(
              error.toString(),
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String time;

  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFFE3F2FD),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    time,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Icon(Icons.circle, size: 10.w, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
