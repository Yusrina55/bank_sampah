import 'package:flutter/material.dart';
import '../widgets/app_input.dart';
import '../theme.dart';

class AppScheduleField extends StatefulWidget {
  final TextEditingController controller;
  final List<String> scheduleList;
  final bool readOnly;

  const AppScheduleField({
    super.key,
    required this.controller,
    required this.scheduleList,
    this.readOnly = false,
  });

  @override
  State<AppScheduleField> createState() =>
      _AppScheduleFieldState();
}

class _AppScheduleFieldState extends State<AppScheduleField> {
  final GlobalKey _scheduleKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    /// =========================
    /// READ ONLY MODE (Detail Screen)
    /// =========================
    if (widget.readOnly) {
      return AppInput(
        key: _scheduleKey,
        label: "Pilihan Jadwal",
        hint: "",
        controller: widget.controller,
        readOnly: true,
      );
    }

    /// =========================
    /// DROPDOWN MODE (Editable)
    /// =========================
    return AppInput(
      key: _scheduleKey,
      label: "Pilihan Jadwal",
      hint: "Pilih jadwal",
      controller: widget.controller,
      readOnly: true,
      suffixIcon: const Icon(Icons.keyboard_arrow_down),
      onTap: () async {
        final RenderBox renderBox =
            _scheduleKey.currentContext!.findRenderObject() as RenderBox;

        final Offset offset =
            renderBox.localToGlobal(Offset.zero);

        final double screenWidth =
            MediaQuery.of(context).size.width;

        final selected = await showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(
            offset.dx,
            offset.dy + renderBox.size.height,
            screenWidth -
                (offset.dx + renderBox.size.width),
            0,
          ),
          items: widget.scheduleList.map((schedule) {
            return PopupMenuItem<String>(
              value: schedule,
              child: SizedBox(
                width: renderBox.size.width,
                child: Text(
                  schedule,
                  style: regular12,
                ),
              ),
            );
          }).toList(),
        );

        if (selected != null) {
          setState(() {
            widget.controller.text = selected;
          });
        }
      },
    );
  }
}
