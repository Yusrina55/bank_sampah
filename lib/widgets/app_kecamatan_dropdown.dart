import 'package:flutter/material.dart';
import '../widgets/app_input.dart';

class AppKecamatanDropdown extends StatefulWidget {
  final TextEditingController controller;

  const AppKecamatanDropdown({
    super.key,
    required this.controller,
  });

  @override
  State<AppKecamatanDropdown> createState() =>
      _AppKecamatanDropdownState();
}

class _AppKecamatanDropdownState extends State<AppKecamatanDropdown> {
  final GlobalKey _kecamatanKey = GlobalKey();

  String? selectedKecamatan;

  final List<String> kecamatanList = [
    'Sumbersari',
    'Patrang',
    'Kaliwates',
    'Ajung',
    'Ambulu',
  ];

  @override
  Widget build(BuildContext context) {
    return AppInput(
      key: _kecamatanKey,
      label: 'Kecamatan',
      hint: 'Pilih kecamatan',
      controller: widget.controller,
      readOnly: true,
      suffixIcon: const Icon(Icons.keyboard_arrow_down),
      onTap: () async {
        final RenderBox renderBox =
            _kecamatanKey.currentContext!.findRenderObject() as RenderBox;

        final Offset offset = renderBox.localToGlobal(Offset.zero);
        final double screenWidth = MediaQuery.of(context).size.width;

        final selected = await showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(
            offset.dx,
            offset.dy + renderBox.size.height,
            screenWidth - (offset.dx + renderBox.size.width),
            0,
          ),
          items: kecamatanList.map((kecamatan) {
            return PopupMenuItem<String>(
              value: kecamatan,
              child: SizedBox(
                width: renderBox.size.width,
                child: Text(kecamatan),
              ),
            );
          }).toList(),
        );

        if (selected != null) {
          setState(() {
            selectedKecamatan = selected;
            widget.controller.text = selected;
          });
        }
      },
    );
  }
}
