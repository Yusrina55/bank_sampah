import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/app_input.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_kecamatan_dropdown.dart';
import '../../theme.dart';
import '../login_screen.dart';
import '../../widgets/app_back_button.dart';

class ProfileMitra extends StatefulWidget {
  const ProfileMitra({super.key});

  @override
  State<ProfileMitra> createState() => _ProfileMitraState();
}

class _ProfileMitraState extends State<ProfileMitra> {
  bool isEditMode = false;
  bool isPasswordHidden = true;

  final TextEditingController namaController =
      TextEditingController(text: "Pabrik Kertas A");
  final TextEditingController phoneController =
      TextEditingController(text: "081298765432");
  final TextEditingController kecamatanController =
      TextEditingController(text: "Tegalgede");
  final TextEditingController alamatController =
      TextEditingController(text: "Perum kaliurang green garden N11");
  final TextEditingController passwordController =
      TextEditingController(text: "password3");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: blue1,
        body: SafeArea(
          child: Column(
            children: [
              // ===== HEADER =====
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                child: Row(
                  children: [
                    const AppBackButton(),
                    const SizedBox(width: 16),
                    Expanded(
                      child: 
                      Text(
                        isEditMode ? 'Edit Profil' : 'Lihat Profil',
                        style: semiBold24.copyWith(color: white),
                      ),
                    ),
                  ],
                ),
              ),

              // ===== FORM =====
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        AppInput(
                          label: 'Nama',
                          hint: '',
                          controller: namaController,
                          readOnly: !isEditMode,
                        ),
                        const SizedBox(height: 16),

                        AppInput(
                          label: 'Nomor Telepon',
                          hint: '',
                          controller: phoneController,
                          readOnly: !isEditMode,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        const SizedBox(height: 16),

                        AppKecamatanDropdown(
                          controller: kecamatanController,
                          readOnly: !isEditMode,
                        ),
                        const SizedBox(height: 16),

                        AppInput(
                          label: 'Alamat Lengkap',
                          hint: '',
                          controller: alamatController,
                          readOnly: !isEditMode,
                        ),
                        const SizedBox(height: 16),

                        AppInput(
                          label: 'Kata Sandi',
                          hint: '',
                          controller: passwordController,
                          readOnly: !isEditMode,
                          obscureText: isPasswordHidden,
                          suffixIcon: isEditMode
                              ? IconButton(
                                  icon: Icon(
                                    isPasswordHidden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: textgrey2,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordHidden =
                                          !isPasswordHidden;
                                    });
                                  },
                                )
                              : null,
                        ),

                        const SizedBox(height: 32),

                        Row(
                          children: [
                            // ===== Keluar =====
                            Expanded(
                              child: AppButton(
                                text: 'Keluar',
                                backgroundColor: Colors.red,
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen(),
                                    ),
                                    (route) => false,
                                  );
                                },
                              ),
                            ),

                            const SizedBox(width: 16),

                            // ===== Ubah / Simpan =====
                            Expanded(
                              child: AppButton(
                                text: isEditMode ? 'Simpan' : 'Ubah',
                                onPressed: () {
                                  setState(() {
                                    isEditMode = !isEditMode;
                                  });

                                  if (!isEditMode) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Profil berhasil diperbarui"),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
