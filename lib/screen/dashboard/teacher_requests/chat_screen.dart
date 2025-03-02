import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lms/screen/dashboard/teacher_requests/teacher_requests_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/utils/app_consts.dart';

class ChatScreen extends StatefulWidget {
  final int requestId;

  const ChatScreen({Key? key, required this.requestId}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TeacherRequestsProvider>().getRequestDetails(widget.requestId);
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<TeacherRequestsProvider>(
          builder: (context, provider, child) {
            final details = provider.currentRequestDetails;
            return Text(details?.title ?? 'المحادثة');
          },
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Consumer<TeacherRequestsProvider>(
        builder: (context, provider, child) {
          final details = provider.currentRequestDetails;
          
          if (provider.isLoadingMessages) {
            return const Center(child: CircularProgressIndicator());
          }

          if (details == null) {
            return const Center(child: Text('لا توجد تفاصيل'));
          }

          return Column(
            children: [
              // تفاصيل الطلب
              Container(
                padding: EdgeInsets.all(16.r),
                color: Colors.grey[100],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تفاصيل الطلب',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text('الموضوع: ${details.subject}'),
                    Text('السبب: ${details.reason}'),
                  ],
                ),
              ),

              // قائمة الرسائل
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(16.r),
                  itemCount: details.messages?.length ?? 0,
                  itemBuilder: (context, index) {
                    final message = details.messages![index];
                    final isMe = message.senderId == details.teacherId;

                    return MessageBubble(
                      message: message.message ?? '',
                      isMe: isMe,
                      senderName: message.userName ?? '',
                      time: message.createdAt ?? '',
                    );
                  },
                ),
              ),

              // حقل إرسال الرسالة
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'اكتب رسالتك هنا...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    IconButton(
                      onPressed: () async {
                        if (_messageController.text.trim().isNotEmpty) {
                          final success = await context
                              .read<TeacherRequestsProvider>()
                              .sendMessage(
                                widget.requestId,
                                _messageController.text.trim(),
                              );
                          
                          if (success) {
                            _messageController.clear();
                            _scrollToBottom();
                          }
                        }
                      },
                      icon: const Icon(Icons.send),
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String senderName;
  final String time;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
    required this.senderName,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 16.r,
          left: isMe ? 64.w : 0,
          right: isMe ? 0 : 64.w,
        ),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : Colors.grey[300],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              senderName,
              style: TextStyle(
                fontSize: 12.sp,
                color: isMe ? Colors.white70 : Colors.black54,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              time,
              style: TextStyle(
                fontSize: 10.sp,
                color: isMe ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 