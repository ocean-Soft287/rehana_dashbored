import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rehana_dashboared/feature/Chat/presentation/manager/chat_contacts_cubit.dart';
import 'package:rehana_dashboared/feature/Chat/data/repo/chat_repo.dart';
import 'package:rehana_dashboared/feature/Chat/presentation/view/screen/chat_contacts_screen.dart';

import '../../../../../core/utils/services/services_locator.dart';

class ResponsiveChat extends StatelessWidget {
  const ResponsiveChat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChatContactsCubit>(),
      child: const ChatContactsScreen(),
    );
  }
}
