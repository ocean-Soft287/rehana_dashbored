import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehana_dashboared/core/utils/Network/local/flutter_secure_storage.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';
import 'package:rehana_dashboared/core/utils/route/approutes.dart';

import '../../../../core/const/widget/side_bar_item.dart';
import '../../../../core/utils/font/fonts.dart';
import '../../../../core/utils/image/images.dart';
import '../../../Auth/presentation/view/screen/login.dart';
import '../../../localization/localizationmodel/localizationmodel.dart';
import '../../../localization/manger/localization_cubit.dart';
import '../../manger/bar_cubit.dart';
import '../../manger/bar_state.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BottomCubit.get(context);

    return BlocBuilder<BottomCubit, BottomState>(
      builder: (context, state) {
        final selectedIndex = state is BottomItemSelected ? state.index : 0;
        final menuItems = cubit.menuItems(
          context,
        ); // Call the method with context

        return Material(
          color: const Color(0xFFAECB70),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
          ),
          child: SizedBox(
            width: 250,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BlocBuilder<LocalizationCubit, LocalizationState>(
                          builder: (context, langState) {
                            String currentLanguageCode = 'ar';
                            if (langState is ChangeLanguage && langState.languageCode != null) {
                              currentLanguageCode = langState.languageCode!;
                            }
                            return Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {

                                  if(currentLanguageCode=='en'){
                                    BlocProvider.of<LocalizationCubit>(context)
                                        .appLanguage(LanguageEventEnums.arabicLanguage);

                                  }else{
                                    BlocProvider.of<LocalizationCubit>(context)
                                        .appLanguage(LanguageEventEnums.englishLanguage);

                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Appcolors.kwhite),
                                  ),
                                  child: const Text(
                                    "EN",
                                    style: TextStyle(
                                      fontFamily: Fonts.font,
                                      fontSize: 12,
                                      color: Appcolors.kwhite,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Column(
                            children: [
                              Image.asset(Images.logo, height: 80),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, idx) {
                      final item = menuItems[idx]; // Use the list variable
                      return SidebarItem(
                        title: item.title,
                        icon: item.icon,
                        isSelected: idx == selectedIndex,
                        onTap: () {
                          if (idx == 5) {
                            cubit.changefinnaceAndItem(0, 5);
                          } else {
                            cubit.changeItem(idx);
                          }
                        },
                      );
                    },
                    childCount: menuItems.length, // Use the list variable
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  fillOverscroll: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton.icon(
                        onPressed: () {

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const ResponsiveLogin()),
                                (route) => false,
                          );
SecureStorageService.clearAll();
                        },
                        icon: const Icon(Icons.logout, color: Colors.white),
                        label: const Text(
                          "تسجيل خروج",
                          style: TextStyle(
                            fontFamily: Fonts.font,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.3),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
