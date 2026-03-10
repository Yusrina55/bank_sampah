import 'package:flutter/material.dart';
import '../theme.dart';

class AppDatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<DateTime>? onDateSelected;
  final bool enabled;

  const AppDatePickerField({
    super.key,
    required this.controller,
    this.onDateSelected,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      enabled: true,
      style: regular12,
      decoration: InputDecoration(
        hintText: "Pilih tanggal",
        hintStyle: regular12.copyWith(color: textgrey2),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
        suffixIcon: Icon(
          Icons.calendar_today,
          color: textgrey2,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: bordergrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: blue1),
        ),
      ),
      onTap: enabled
        ? () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              final day =
                  pickedDate.day.toString().padLeft(2, '0');
              final month =
                  pickedDate.month.toString().padLeft(2, '0');
              final year = pickedDate.year;

              controller.text = "$day/$month/$year";

              if (onDateSelected != null) {
                onDateSelected!(pickedDate);
              }
            }
          }
        : null, 
    );
  }
}
