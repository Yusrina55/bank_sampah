import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/app_input.dart';
import '../widgets/app_button.dart';
import 'package:flutter/gestures.dart';
import '../widgets/app_kecamatan_dropdown.dart';
import 'login_screen.dart';
import '../theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPasswordHidden = true;

final TextEditingController kecamatanController =
    TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: blue1,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:0 ),
            child: Column(
              children: [
              // ===== HEADER =====
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 100, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Buat Akun',
                        style: semiBold24.copyWith(color: white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Mari menjadi bagian dari Bank\nSampah Abang Recycle!',
                        style: regular12.copyWith(color: white),
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
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama Lengkap
                          AppInput(
                            label: 'Nama Lengkap', 
                            hint: 'masukkan nama lengkap',
                          ),
                          const SizedBox(height: 16),

                          // Nomor Telepon
                          AppInput(
                            label: 'Nomor Telepon', 
                            hint: 'masukkan nomor telepon',
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          //kecamatan
                          AppKecamatanDropdown(
                            controller: kecamatanController,
                          ),
                          
                          const SizedBox(height: 16),

                          //alamat
                          AppInput(
                            label: 'Alamat Lengkap', 
                            hint: 'masukkan alamat lengkap',
                          ),
                          const SizedBox(height: 16),

                          // Kata Sandi
                          AppInput(
                            label: 'Kata Sandi',
                            hint: 'masukkan kata sandi',
                            obscureText: isPasswordHidden,
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: textgrey2,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordHidden = !isPasswordHidden;
                                });
                              },
                            ),
                          ),
                  
                          const SizedBox(height: 24),

                          // Button Masuk
                          AppButton(
                            text: 'Daftar', 
                            onPressed: () {},
                          ),

                          const SizedBox(height: 16),

                          Center(
                            child: RichText(
                              text: TextSpan(
                                style: regular12.copyWith(color: textgrey1),
                                children: [
                                  const TextSpan(
                                    text: 'Jika sudah punya akun, ',
                                  ),
                                  TextSpan(
                                    text: 'silakan masuk',
                                    style: regular12.copyWith(color: blue1),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const LoginScreen(),
                                          ),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
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
      ),
    );
  }
}
