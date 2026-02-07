import 'package:flutter/material.dart';
import '../widgets/app_input.dart';

class AppJenisSampahDropdown extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const AppJenisSampahDropdown({
    super.key,
    required this.controller,
    required this.label,
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
      suffixIcon: const Icon(Icons.keyboard_arrow_down),
      onTap: () async {

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
