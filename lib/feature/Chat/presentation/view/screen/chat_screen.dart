import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rehana_dashboared/core/utils/font/fonts.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';
import 'package:rehana_dashboared/core/utils/Network/local/flutter_secure_storage.dart';
import 'package:rehana_dashboared/feature/Chat/data/repo/chat_repo.dart';
import 'package:rehana_dashboared/feature/Chat/data/model/chat_user.dart';
import 'package:rehana_dashboared/feature/Chat/presentation/manager/chat_messages_cubit.dart';
import 'package:rehana_dashboared/feature/Chat/presentation/manager/chat_messages_state.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _myId;

  @override
  void initState() {
    super.initState();
    _getMyId();
  }

  Future<void> _getMyId() async {
    // Assuming we store some ID in secure storage, or we use email as ID fallback
    // The user said they have "id" but SecureStorage showed "token", "mobile", "email", "name".
    // I'll use "email" if id is not there, or maybe "name".
    // Ideally, we should store UID.
    // For now, I'll attempt to read "id", if null use email.
    String? id = await SecureStorageService.read("id");
    if (id == null) {
      id = await SecureStorageService.read("email");
    }
    setState(() {
      _myId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => ChatMessagesCubit(
            GetIt.instance<ChatRepository>(),
            widget.user.id,
          )..getMessages(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Appcolors.kprimary,
                backgroundImage:
                    widget.user.image != null
                        ? CachedNetworkImageProvider(widget.user.image!)
                        : null,
                child:
                    widget.user.image == null
                        ? Text(widget.user.name.substring(0, 1).toUpperCase())
                        : null,
              ),
              const SizedBox(width: 10),
              Text(
                widget.user.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: Fonts.font,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatMessagesCubit, ChatMessagesState>(
                builder: (context, state) {
                  if (state is ChatMessagesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ChatMessagesError) {
                    return Center(child: Text("Error: ${state.message}"));
                  }
                  if (state is ChatMessagesLoaded) {
                    final messages = state.messages;
                    if (messages.isEmpty) {
                      return const Center(child: Text("No messages yet"));
                    }
                    return ListView.builder(
                      reverse: true, // Standard chat behavior
                      padding: const EdgeInsets.all(16),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMe = message.senderId == _myId;
                        return Align(
                          alignment:
                              isMe
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isMe ? Appcolors.kprimary : Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(12),
                                topRight: const Radius.circular(12),
                                bottomLeft:
                                    isMe
                                        ? const Radius.circular(12)
                                        : Radius.zero,
                                bottomRight:
                                    isMe
                                        ? Radius.zero
                                        : const Radius.circular(12),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              message.content,
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                color: isMe ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            _buildMessageInput(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: const TextStyle(fontFamily: Fonts.font),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Appcolors.kprimary,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
              onPressed: () {
                if (_controller.text.trim().isEmpty || _myId == null) return;

                ChatMessagesCubit.get(context).sendMessage(
                  senderId: _myId!,
                  content: _controller.text.trim(),
                );
                _controller.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
