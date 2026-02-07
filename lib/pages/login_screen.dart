import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/app_input.dart';
import '../widgets/app_button.dart';
import 'package:flutter/gestures.dart';
import 'register_screen.dart';
import '../theme.dart';
import '../pages/pelanggan/home_page_pelanggan.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                        'Masuk',
                        style: semiBold24.copyWith(color: white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Silakan masuk dan mulai jelajahi\nuntuk akses yang lebih lengkap',
                        style: regular12.copyWith(color: white),
                      ),
                    ],
                  ),
                ),

                // ===== FORM =====
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          text: 'Masuk', 
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePagePelanggan(),
                              ),
                            );
                          },
                        ),

                        // teks redirect
                        const SizedBox(height: 16),

                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: regular12.copyWith(color: textgrey1),
                              children: [
                                const TextSpan(
                                  text: 'Jika belum punya akun, ',
                                ),
                                TextSpan(
                                  text: 'silakan daftar',
                                  style: regular12.copyWith(color: blue1),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const RegisterScreen(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
