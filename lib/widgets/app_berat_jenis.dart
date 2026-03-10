import 'package:flutter/material.dart';
import '../widgets/app_input.dart';

class AppBeratJenisField extends StatefulWidget {
  final TextEditingController jenisController;
  final TextEditingController jumlahController;
  final VoidCallback? onDelete;
  final bool showDelete;
  final bool readOnly;

  const AppBeratJenisField({
    super.key,
    required this.jenisController,
    required this.jumlahController,
    this.onDelete,
    this.showDelete = false,
    this.readOnly = false,
  });

  @override
  State<AppBeratJenisField> createState() =>
      _AppBeratJenisFieldState();
}

class _AppBeratJenisFieldState
    extends State<AppBeratJenisField> {

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// DROPDOWN JENIS SAMPAH
          Expanded(
            child: AppInput(
              key: _dropdownKey,
              label: "",
              hint: 'Pilih jenis sampah',
              controller: widget.jenisController,
              readOnly: true,
              suffixIcon: widget.readOnly
                  ? null
                  : const Icon(Icons.keyboard_arrow_down),
              onTap: widget.readOnly
                  ? null
                  : () async {

                      final RenderBox renderBox =
                          _dropdownKey.currentContext!
                              .findRenderObject() as RenderBox;

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
                        setState(() {
                          widget.jenisController.text = selected;
                        });
                      }
                    },
            ),
          ),


          const SizedBox(width: 8),

          /// INPUT JUMLAH
          Expanded(
            child: AppInput(
              label: "",
              hint: "berat/jumlah",
              keyboardType: TextInputType.number,
              controller: widget.jumlahController,
              readOnly: widget.readOnly, // ✅ TAMBAHAN
            ),
          ),

          /// DELETE BUTTON
          if (widget.showDelete)
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, top: 36),
              child: GestureDetector(
                onTap: widget.onDelete,
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
