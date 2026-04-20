import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/app_input.dart';
import '../widgets/app_button.dart';
import 'package:flutter/gestures.dart';
import 'register_screen.dart';
import '../theme.dart';
import '../pages/pelanggan/home_page_pelanggan.dart';
import '../pages/mitra/home_page_mitra.dart';
import '../pages/petugas/main_petugas_page.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

enum UserRole { pelanggan, petugas, mitra }

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordHidden = true;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  UserRole? userRole; // "pelanggan", "petugas", atau "mitra"

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: blue1,
        resizeToAvoidBottomInset: true,
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nomor Telepon
                          AppInput(
                            label: 'Nomor Telepon',
                            hint: 'masukkan nomor telepon',
                            controller: phoneController,
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
                            controller: passwordController,
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
                              final phone = phoneController.text.trim();
                              final password = passwordController.text.trim();

                              UserRole? role;
                              Widget? targetPage;

                              if (phone == '081234567891' && password == 'password1') {
                                role = UserRole.pelanggan;
                                targetPage = const HomePagePelanggan();
                              } 
                              else if (phone == '081212343456' && password == 'password2') {
                                role = UserRole.petugas;
                                targetPage = const MainPetugasPage();
                              } 
                              else if (phone == '081298765432' && password == 'password3') {
                                role = UserRole.mitra;
                                targetPage = const HomePageMitra();
                              }

                              if (role != null && targetPage != null) {
                                setState(() {
                                  userRole = role;
                                });

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => targetPage!),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Nomor telepon atau password salah'),
                                  ),
                                );
                              }
                            },
                          ),

                          // teks redirect
                          const SizedBox(height: 16),

                          if (userRole == null || userRole == UserRole.pelanggan)
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
