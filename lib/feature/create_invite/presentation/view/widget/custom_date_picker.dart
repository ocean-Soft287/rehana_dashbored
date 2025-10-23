import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/colors/colors.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';
import '../../../../localization/manger/localization_cubit.dart';
class CustomDatePicker extends StatefulWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const CustomDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _focusedDate;

  @override
  void initState() {
    super.initState();
    if (widget.selectedDate != null) {
      final d = widget.selectedDate!;
      _focusedDate = DateTime(d.year, d.month, d.day);
    } else {
      final now = DateTime.now();
      _focusedDate = DateTime(now.year, now.month, now.day);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, langState) {
        String currentLanguageCode = 'en';
        if (langState is ChangeLanguage && langState.languageCode != null) {
          currentLanguageCode = langState.languageCode!;
        }
        return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                 AppLocalizations.of(context)!.date,
                  style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                  color: Appcolors.bIcon),
                ),
              ],
            ),
            const SizedBox(height: 8),
            EasyTheme(
              data: EasyTheme.of(context).copyWithState(
                selectedDayTheme: DayThemeData(backgroundColor: Appcolors.bIcon),
                unselectedDayTheme: DayThemeData(backgroundColor: Appcolors.kwhite),
                disabledDayTheme: DayThemeData(backgroundColor: Appcolors.kwhite),
              ),
              child: EasyDateTimeLinePicker(
                focusedDate: _focusedDate,
                firstDate: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                ),
                lastDate: DateTime(2900, 3, 18),
                onDateChange: (date) {
                  final picked = DateTime(date.year, date.month, date.day);
                  setState(() {
                    _focusedDate = picked;
                  });
                  widget.onDateSelected(picked);
                },
                locale:currentLanguageCode=='en'? Locale("en"):Locale('ar'),

                disableStrategy: DisableStrategy.beforeToday(),
              ),
            ),
          ],
        );
      },

    );
  }
}