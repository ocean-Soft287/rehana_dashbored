import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rehana_dashboared/core/bloc/base_state.dart';
import 'package:rehana_dashboared/core/utils/font/fonts.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';
import 'package:rehana_dashboared/feature/Chat/data/model/chat_user.dart';
import 'package:rehana_dashboared/feature/Chat/presentation/manager/chat_contacts_cubit.dart';
import 'package:rehana_dashboared/feature/Chat/presentation/view/screen/chat_screen.dart';

import '../../../../../core/utils/services/services_locator.dart';
import '../../manager/chat_messages_cubit.dart';

class ChatContactsScreen extends StatefulWidget {
  const ChatContactsScreen({super.key});

  @override
  State<ChatContactsScreen> createState() => _ChatContactsScreenState();
}

class _ChatContactsScreenState extends State<ChatContactsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatContactsCubit>().add(const GetContactsEvent());
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a', 'ar').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "المحادثات",
          style: TextStyle(
            color: Colors.black87,
            fontFamily: Fonts.font,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Appcolors.kprimary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.search, color: Appcolors.kprimary),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: BlocBuilder<ChatContactsCubit, BaseState<ChatUser>>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.isFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    "خطأ: ${state.errorMessage}",
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          }

          final contacts = state.items;

          if (contacts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "لا توجد محادثات سابقة",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontFamily: Fonts.font,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<ChatContactsCubit>().add(
                        const GetUsersEvent(),
                      );
                    },
                    icon: const Icon(Icons.person_add_alt_1),
                    label: const Text("استكشاف المستخدمين لبدء دردشة"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.kprimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final user = contacts[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Appcolors.kprimary.withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: Appcolors.kprimary.withOpacity(0.1),
                          backgroundImage:
                              user.image != null
                                  ? CachedNetworkImageProvider(user.image!)
                                  : null,
                          child:
                              user.image == null
                                  ? Text(
                                    user.name.substring(0, 1).toUpperCase(),
                                    style: const TextStyle(
                                      color: Appcolors.kprimary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                  : null,
                        ),
                      ),
                      if (user.isOnline ?? false)
                        Positioned(
                          right: 2,
                          bottom: 2,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(
                      fontFamily: Fonts.font,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      user.lastMessage ?? user.email ?? 'بدء محادثة جديدة',
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight:
                            user.lastMessage != null
                                ? FontWeight.w500
                                : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (user.lastMessageTime != null)
                        Text(
                          _formatTime(user.lastMessageTime!),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                            fontFamily: Fonts.font,
                          ),
                        ),
                      const SizedBox(height: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create:
                                (context) =>
                            sl<ChatMessagesCubit>()
                              ..add(ListenToMessagesEvent(user.id)),
                            child: ChatScreen(user: user)),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
