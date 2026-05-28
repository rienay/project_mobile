import 'package:flutter/material.dart';
import 'package:project_mobile/ui/auth/login_page.dart'; // Sesuaikan path login page Anda

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // Data konten onboarding sesuai gambar yang Anda berikan
  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'assets/images/onboarding1.jpg',
      'title': 'Semua dalam Satu Aplikasi',
      'subtitle': 'Temukan vendor, MUA, dekorasi, dan fotografer untuk hari spesialmu',
    },
    {
      'image': 'assets/images/onboarding2.jpg',
      'title': 'Booking Instan & Vendor Terpercaya',
      'subtitle': 'Pesan vendor favoritmu hanya dengan satu klik. Semua mitra telah diverifikasi',
    },
    {
      'image': 'assets/images/onboarding3.jpg',
      'title': 'Wujudkan Pernikahan Impianmu',
      'subtitle': 'Rencanakan momen spesial dengan mudah dan penuh makna',
    },
  ];

  void _onNextPage() {
    if (_currentIndex < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Jika sudah di slide terakhir, pergi ke halaman Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  void _onPrevPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color accentPink = Color(0xFFE91E63); // Warna pink tombol navigasi

    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image PageView dengan filter gelap
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_onboardingData[index]['image']!),
                    fit: BoxFit.cover,
                    // Memberikan efek overlay gelap agar teks putih terbaca jelas seperti di desain
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.55),
                      BlendMode.darken,
                    ),
                  ),
                ),
              );
            },
          ),

          // 2. Konten Teks & Tombol di atas background
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                children: [
                  const Spacer(flex: 4),
                  
                  // Bagian Teks (Judul & Subjudul)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      key: ValueKey<int>(_currentIndex),
                      children: [
                        Text(
                          _onboardingData[_currentIndex]['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _onboardingData[_currentIndex]['subtitle']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 2),

                  // Bagian Kontrol Bawah (Tombol Back, Dots Indicator, Tombol Next)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tombol Kiri (Hanya muncul di slide 2 & 3)
                      _currentIndex > 0
                          ? CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back, color: accentPink),
                                onPressed: _onPrevPage,
                              ),
                            )
                          : const SizedBox(width: 48), // Spacer penyeimbang layout

                      // Dots Indicator (Indikator titik tiga)
                      Row(
                        children: List.generate(
                          _onboardingData.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // Dot aktif berwarna pink pekat, sisanya putih
                              color: _currentIndex == index
                                  ? accentPink
                                  : Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),

                      // Tombol Kanan (Next / Selesai)
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: accentPink,
                        child: IconButton(
                          icon: Icon(
                            _currentIndex == _onboardingData.length - 1
                                ? Icons.check
                                : Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          onPressed: _onNextPage,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}