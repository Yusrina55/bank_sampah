import 'package:flutter/material.dart';
import '../widgets/app_input.dart';

class AppDropdown extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final List<String> items;
  final bool readOnly;

  const AppDropdown({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.items,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final dropdownKey = GlobalKey();

    return AppInput(
      key: dropdownKey,
      label: label,
      hint: hint,
      controller: controller,
      readOnly: true,
      suffixIcon: readOnly
          ? null
          : const Icon(Icons.keyboard_arrow_down),
      onTap: readOnly
          ? null
          : () async {
              final renderBox = dropdownKey.currentContext!
                  .findRenderObject() as RenderBox;
              final offset = renderBox.localToGlobal(Offset.zero);
              final screenWidth = MediaQuery.of(context).size.width;

              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(
                  offset.dx,
                  offset.dy + renderBox.size.height,
                  screenWidth - (offset.dx + renderBox.size.width),
                  0,
                ),
                items: items
                    .map(
                      (item) => PopupMenuItem<String>(
                        value: item,
                        child: SizedBox(
                          width: renderBox.size.width,
                          child: Text(item),
                        ),
                      ),
                    )
                    .toList(),
              );

              if (selected != null) {
                controller.text = selected;
              }
            },
    );
  }
}