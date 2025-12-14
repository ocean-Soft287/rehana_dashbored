import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';

import '../../manger/bar_cubit.dart';
import '../../manger/bar_state.dart';
import 'buildsidebar.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({super.key});

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  int selectedIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 800;

    return BlocProvider(
      create: (context) => BottomCubit(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar:
            isMobile
                ? AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
                )
                : null,
        drawer:
            isMobile
                ? Drawer(backgroundColor: Appcolors.kprimary, child: Sidebar())
                : null,

        body: Builder(
          builder: (context) {
            return BlocBuilder<BottomCubit, BottomState>(
              buildWhen: (previous, current) => 
                  current is BottomItemSelected || current is BottomSubItemSelected,
              builder: (context, state) {
                BottomCubit bottomCubit = context.read<BottomCubit>();
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              isMobile
                                  ? const SizedBox()
                                  : Expanded(flex: 1, child: const Sidebar()),
                              Expanded(
                                flex: 3,
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder: (
                                    Widget child,
                                    Animation<double> animation,
                                  ) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0.1, 0),
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: child,
                                      ),
                                    );
                                  },
                                  key: ValueKey<String>('${bottomCubit.selectedMainIndex}-${bottomCubit.selectedSubIndex}'),
                                  child: bottomCubit.currentScreen,
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
