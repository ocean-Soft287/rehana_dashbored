import 'package:flutter/material.dart';
import 'package:rehana_dashboared/core/utils/colors/colors.dart';
import '../../../../../core/utils/font/fonts.dart';
import 'package:rehana_dashboared/l10n/app_localizations.dart';


class FromtoWidget extends StatefulWidget {
  final TimeOfDay? fromTime;
  final TimeOfDay? toTime;
  final DateTime? selectedDate;

  final void Function(TimeOfDay from, TimeOfDay to) onTimeSelected;

  const FromtoWidget({
    super.key,
    required this.fromTime,
    required this.toTime,
    required this.onTimeSelected,
    required this.selectedDate,
  });

  @override
  State<FromtoWidget> createState() => _FromtoWidgetState();
}

class _FromtoWidgetState extends State<FromtoWidget> {
  late TimeOfDay? _localFrom;
  late TimeOfDay? _localTo;

  @override
  void initState() {
    super.initState();
    _localFrom = widget.fromTime;
    _localTo = widget.toTime;
  }

  @override
  void didUpdateWidget(covariant FromtoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.fromTime != oldWidget.fromTime ||
        widget.toTime != oldWidget.toTime) {
      _localFrom = widget.fromTime;
      _localTo = widget.toTime;
    }
  }

  Future<void> _selectTime({required bool isFrom}) async {
    final nowOfDay = TimeOfDay.now();
    final today = DateTime.now();
    final selDate = widget.selectedDate ?? today;

    final isToday =
    (selDate.year == today.year &&
        selDate.month == today.month &&
        selDate.day == today.day);

    TimeOfDay initial =
    isFrom ? (_localFrom ?? nowOfDay) : (_localTo ?? nowOfDay);

    if (isToday && isFrom) {
      initial = nowOfDay;
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );

    if (!mounted || picked == null) return;

    if (isFrom) {
      if (isToday && (_compareTimeOfDay(picked, nowOfDay) < 0)) {
        _showInvalidTimeWarning(AppLocalizations.of(context)!.from_time_required);
        return;
      }
      if (_localTo != null && !_isValidTimeRange(picked, _localTo!)) {
        _showInvalidTimeWarning(AppLocalizations.of(context)!.from_before_to);
        return;
      }
      _localFrom = picked;
    } else {
      if (isToday && (_compareTimeOfDay(picked, nowOfDay) <= 0) && _localFrom == null) {
        _showInvalidTimeWarning(AppLocalizations.of(context)!.to_after_now);
        return;
      }
      if (isToday && _localFrom != null) {
        final baseline = _compareTimeOfDay(_localFrom!, nowOfDay) < 0 ? nowOfDay : _localFrom!;
        if (_compareTimeOfDay(picked, baseline) <= 0) {
          _showInvalidTimeWarning(AppLocalizations.of(context)!.to_after_from_or_now);
          return;
        }
      }
      if (!isToday && _localFrom != null && !_isValidTimeRange(_localFrom!, picked)) {
        _showInvalidTimeWarning(AppLocalizations.of(context)!.to_after_from);
        return;
      }
      _localTo = picked;
    }

    if (_localFrom != null && _localTo != null) {
      if (isToday) {
        final endOfDay = const TimeOfDay(hour: 23, minute: 59);

        if (_compareTimeOfDay(_localTo!, endOfDay) > 0) {
          _localTo = endOfDay;
        }
        if (_compareTimeOfDay(_localFrom!, _localTo!) > 0) {
          _localFrom = nowOfDay;
        }
      }

      widget.onTimeSelected(_localFrom!, _localTo!);
    }

    if (mounted) {
      setState(() {});
    }
  }

  int _compareTimeOfDay(TimeOfDay t1, TimeOfDay t2) {
    final m1 = t1.hour * 60 + t1.minute;
    final m2 = t2.hour * 60 + t2.minute;
    return m1.compareTo(m2);
  }

  bool _isValidTimeRange(TimeOfDay from, TimeOfDay to) {
    return _compareTimeOfDay(from, to) < 0;
  }

  void _showInvalidTimeWarning(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  String _formatUserFriendlyTime(TimeOfDay? time) {
    if (time == null) return "--";
    return time.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               AppLocalizations.of(context)!.from,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.font,
                  color: Appcolors.bIcon,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectTime(isFrom: true),
                child: Container(
                  alignment: Alignment.center,
                  width: 130,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Appcolors.bIcon),
                  ),
                  child: Text(
                    _formatUserFriendlyTime(_localFrom),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: Fonts.font,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               AppLocalizations.of(context)!.to,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.font,
                  color: Appcolors.bIcon,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectTime(isFrom: false),
                child: Container(
                  alignment: Alignment.center,
                  width: 130,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Appcolors.bIcon),
                  ),
                  child: Text(
                    _formatUserFriendlyTime(_localTo),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: Fonts.font,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
