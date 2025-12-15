import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/core/utils/font/fonts.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';
import 'package:rehana_dashboared/feature/Chat/presentation/manager/chat_contacts_cubit.dart';
import 'package:rehana_dashboared/feature/Chat/presentation/manager/chat_contacts_state.dart';
import 'package:rehana_dashboared/feature/Chat/presentation/view/screen/chat_screen.dart';

class ChatContactsScreen extends StatefulWidget {
  const ChatContactsScreen({super.key});

  @override
  State<ChatContactsScreen> createState() => _ChatContactsScreenState();
}

class _ChatContactsScreenState extends State<ChatContactsScreen> {
  @override
  void initState() {
    super.initState();
    ChatContactsCubit.get(context).getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Contacts", // Should use Localization
          style: TextStyle(
            color: Colors.black,
            fontFamily: Fonts.font,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<ChatContactsCubit, ChatContactsState>(
        builder: (context, state) {
          if (state is ChatContactsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ChatContactsError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          if (state is ChatContactsLoaded) {
            if (state.contacts.isEmpty) {
              return const Center(child: Text("No contacts found"));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.contacts.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final user = state.contacts[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.grey, width: 0.2),
                  ),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Appcolors.kprimary,
                    backgroundImage:
                        user.image != null
                            ? CachedNetworkImageProvider(user.image!)
                            : null,
                    child:
                        user.image == null
                            ? Text(
                              user.name.substring(0, 1).toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            )
                            : null,
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(
                      fontFamily: Fonts.font,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    user.email ?? '',
                    style: const TextStyle(
                      fontFamily: Fonts.font,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(user: user),
                      ),
                    );
                  },
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
