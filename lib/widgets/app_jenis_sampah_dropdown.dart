import 'package:flutter/material.dart';
import '../widgets/app_input.dart';

class AppJenisSampahDropdown extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool readOnly;

  const AppJenisSampahDropdown({
    super.key,
    required this.controller,
    required this.label,
    this.readOnly = false,
  });

  @override
  State<AppJenisSampahDropdown> createState() =>
      _AppJenisSampahDropdownState();
}

class _AppJenisSampahDropdownState
    extends State<AppJenisSampahDropdown> {

  final GlobalKey _dropdownKey = GlobalKey();

  final List<String> jenisSampahList = [
    'Plastik',
    'Elektronik',
    'Kertas',
    'Besi dan Logam',
    'Kaca',

  ];

  @override
  Widget build(BuildContext context) {
    return AppInput(
      key: _dropdownKey,
      label: widget.label,
      hint: 'Pilih jenis sampah',
      controller: widget.controller,
      readOnly: true,

      // icon hanya muncul kalau bisa edit
      suffixIcon: widget.readOnly
          ? null
          : const Icon(Icons.keyboard_arrow_down),

      // kalau readonly → tidak bisa tap
      onTap: widget.readOnly
          ? null
          : () async {
              final RenderBox renderBox =
                  _dropdownKey.currentContext!.findRenderObject()
                      as RenderBox;

              final Offset offset =
                  renderBox.localToGlobal(Offset.zero);

              final double screenWidth =
                  MediaQuery.of(context).size.width;

              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(
                  offset.dx,
                  offset.dy + renderBox.size.height,
                  screenWidth - (offset.dx + renderBox.size.width),
                  0,
                ),
                items: jenisSampahList.map((jenis) {
                  return PopupMenuItem<String>(
                    value: jenis,
                    child: SizedBox(
                      width: renderBox.size.width,
                      child: Text(jenis),
                    ),
                  );
                }).toList(),
              );

              if (selected != null) {
                widget.controller.text = selected;
              }
      },
    );
  }
}
