import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import 'date_slot_card.dart';
import 'premium_section_header.dart';
import 'time_slot_button.dart';

/// Section that allows the user to pick a date and time slot.
///
/// Renders a horizontal list of [DateSlotCard]s and a wrap of
/// [TimeSlotButton]s. State is lifted to the parent via callbacks.
class ScheduleSlotSection extends StatelessWidget {
  const ScheduleSlotSection({
    super.key,
    required this.selectedDateIndex,
    required this.selectedTimeIndex,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  final int selectedDateIndex;
  final int selectedTimeIndex;
  final ValueChanged<int> onDateSelected;
  final ValueChanged<int> onTimeSelected;

  static const List<Map<String, String>> _dates = [
    {'day': 'Mon', 'date': '27'},
    {'day': 'Tue', 'date': '28'},
    {'day': 'Wed', 'date': '29'},
    {'day': 'Thu', 'date': '30'},
    {'day': 'Fri', 'date': '31'},
    {'day': 'Sat', 'date': '01'},
  ];

  static const List<String> _times = [
    '8:00 AM',
    '10:00 AM',
    '12:00 PM',
    '2:00 PM',
    '4:00 PM',
    '6:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PremiumSectionHeader(
          AppStrings.checkoutScheduleSlot,
          icon: Icons.calendar_today,
        ),
        const SizedBox(height: AppConstants.paddingM),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _dates.length,
            separatorBuilder: (_, __) =>
                const SizedBox(width: AppConstants.paddingS),
            itemBuilder: (context, index) {
              final slot = _dates[index];
              return DateSlotCard(
                dayLabel: slot['day']!,
                dateLabel: slot['date']!,
                isSelected: selectedDateIndex == index,
                onTap: () => onDateSelected(index),
              );
            },
          ),
        ),
        const SizedBox(height: AppConstants.paddingM),
        Wrap(
          spacing: AppConstants.paddingS,
          runSpacing: AppConstants.paddingS,
          children: List.generate(_times.length, (index) {
            return TimeSlotButton(
              label: _times[index],
              isSelected: selectedTimeIndex == index,
              onTap: () => onTimeSelected(index),
            );
          }),
        ),
      ],
    );
  }
}
