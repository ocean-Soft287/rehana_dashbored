import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rehana_dashboared/core/bloc/base_state.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';
import 'package:rehana_dashboared/core/utils/services/services_locator.dart';
import 'package:rehana_dashboared/core/utils/Network/local/flutter_secure_storage.dart';
import 'package:rehana_dashboared/feature/Chat/data/model/chat_message.dart';
import 'package:rehana_dashboared/feature/Chat/data/model/chat_user.dart';
import 'package:rehana_dashboared/feature/Chat/presentation/manager/chat_messages_cubit.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _myId;

  @override
  void initState() {
    super.initState();
    _getMyId();
  }

  Future<void> _getMyId() async {
    // As per user request, it's only one admin
    setState(() {
      _myId = "admin";
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isNotEmpty && _myId != null) {
      final text = _controller.text.trim();
      final senderName =
          await SecureStorageService.read(SecureStorageService.name) ?? "Admin";

      context.read<ChatMessagesCubit>().add(
        SendMessageEvent(
          conversationId: _getConversationId(),
          senderId: _myId!,
          receiverId: widget.user.id,
          text: text,
          senderName: senderName,
          receiverName: widget.user.name,
        ),
      );
      _controller.clear();
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  String _getConversationId() {
    // In this app structure, the conversation ID is the user's ID
    return widget.user.id;
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a', 'ar').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black12,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Appcolors.kprimary,
            size: 22,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Appcolors.kprimary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Appcolors.kprimary,
                    backgroundImage:
                        widget.user.image != null
                            ? NetworkImage(widget.user.image!)
                            : null,
                    child:
                        widget.user.image == null
                            ? Text(
                              widget.user.name.isNotEmpty
                                  ? widget.user.name[0].toUpperCase()
                                  : "?",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                            : null,
                  ),
                ),
                if (widget.user.isOnline ?? false)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.5),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    (widget.user.isOnline ?? false) ? 'نشط الآن' : 'غير متصل',
                    style: TextStyle(
                      color:
                          (widget.user.isOnline ?? false)
                              ? const Color(0xFF4CAF50)
                              : Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Appcolors.kprimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatMessagesCubit, BaseState<ChatMessage>>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.isFailure) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? 'Error loading messages',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                final messages = state.items;

                if (messages.isEmpty) {
                  return const Center(
                    child: Text(
                      'لا توجد رسائل',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final bool isSent = msg.senderId == _myId;
                    final bool showAvatar =
                        index == messages.length - 1 ||
                        messages[index + 1].senderId != msg.senderId;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment:
                            isSent
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!isSent)
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child:
                                  showAvatar
                                      ? CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Appcolors.kprimary,
                                        backgroundImage:
                                            widget.user.image != null
                                                ? NetworkImage(
                                                  widget.user.image!,
                                                )
                                                : null,
                                        child:
                                            widget.user.image == null
                                                ? Text(
                                                  widget.user.name.isNotEmpty
                                                      ? widget.user.name[0]
                                                          .toUpperCase()
                                                      : "?",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                                : null,
                                      )
                                      : const SizedBox(width: 32),
                            ),
                          if (!isSent) const SizedBox(width: 8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment:
                                  isSent
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient:
                                        isSent
                                            ? LinearGradient(
                                              colors: [
                                                Appcolors.kprimary,
                                                Appcolors.kprimary.withOpacity(
                                                  0.85,
                                                ),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )
                                            : null,
                                    color: isSent ? null : Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(20),
                                      topRight: const Radius.circular(20),
                                      bottomLeft: Radius.circular(
                                        isSent ? 20 : 4,
                                      ),
                                      bottomRight: Radius.circular(
                                        isSent ? 4 : 20,
                                      ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            isSent
                                                ? Appcolors.kprimary
                                                    .withOpacity(0.3)
                                                : Colors.black.withOpacity(
                                                  0.08,
                                                ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    msg.content,
                                    style: TextStyle(
                                      color:
                                          isSent
                                              ? Colors.white
                                              : Colors.black87,
                                      fontSize: 15,
                                      height: 1.4,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: Text(
                                    _formatTime(msg.timestamp),
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'اكتب رسالة...',
                                hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                              ),
                              style: const TextStyle(fontSize: 15),
                              onSubmitted: (value) => _sendMessage(),
                              textInputAction: TextInputAction.send,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              color: Colors.grey[600],
                              size: 24,
                            ),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Material(
                    color: Appcolors.kprimary,
                    borderRadius: BorderRadius.circular(26),
                    elevation: 2,
                    shadowColor: Appcolors.kprimary.withOpacity(0.4),
                    child: InkWell(
                      onTap: _sendMessage,
                      borderRadius: BorderRadius.circular(26),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Appcolors.kprimary,
                              Appcolors.kprimary.withOpacity(0.85),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 22,
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
    );
  }
}
