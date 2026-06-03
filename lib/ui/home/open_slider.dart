import 'package:flutter/material.dart';

class OpenSlider extends StatefulWidget {
  final List<Map<String, dynamic>> categories;
  final int initialIndex;

  const OpenSlider({
    super.key,
    required this.categories,
    this.initialIndex = 0,
  });

  @override
  State<OpenSlider> createState() => _OpenSliderState();
}

class _OpenSliderState extends State<OpenSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  late List<String> _sliderImages;

  @override
  void initState() {
    super.initState();
    // Selalu mulai dari foto pertama (index 0) di dalam slider kategori ini
    _pageController = PageController(initialPage: 0);

    // Mengambil data kategori yang sedang diklik
    final category = widget.categories[widget.initialIndex];
    final mainImage = category['slider_image'] ?? category['image'] ?? '';

    // Menyiapkan 4 foto dummy untuk slider kategori ini menggunakan aset yang ada
    _sliderImages = [
      mainImage,
      'assets/trend_wedding/Garden_Wedding.png',
      'assets/trend_wedding/Crystal_Ballroom.png',
      'assets/trend_wedding/Opulent_Vintage.png',
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category = widget.categories[widget.initialIndex];
    final String title = category['title'] ?? 'Theme';

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, // Pastikan seluruh area layar merespon tap
        onTapUp: (details) {
          final width = MediaQuery.of(context).size.width;
          // Jika tap di 1/3 layar bagian kiri -> Mundur
          if (details.globalPosition.dx < width / 3) {
            if (_currentPage > 0) {
              _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            }
          } 
          // Jika tap di 2/3 layar bagian kanan -> Maju
          else {
            if (_currentPage < _sliderImages.length - 1) {
              _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            }
          }
        },
        child: Stack(
          children: [
            // 1. Background Images
            PageView.builder(
              controller: _pageController,
              itemCount: _sliderImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(_sliderImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),

          // 2. Gradient Overlay Atas & Bawah (STAY / Tetap tidak ikut geser)
          Positioned(
            top: 0, left: 0, right: 0, height: 250,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [const Color(0xFFD6568F).withOpacity(0.8), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0, left: 0, right: 0, height: 350,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
            ),
          ),

          // 3. Instagram Story Indicator Overlay (STAY)
          Positioned(
            top: 0, left: 0, right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                child: Row(
                  children: List.generate(
                    _sliderImages.length,
                    (index) {
                      final isActive = index <= _currentPage;
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          height: 3.0,
                          decoration: BoxDecoration(
                            color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(1.5),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // 4. Konten Utama UI (STAY)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24), // Ruang di bawah garis story
                  // --- Bagian Atas: Judul (Selalu Tampil) ---
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pilih pernikahan impianmu!',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),

                  const Spacer(),

                  // --- Bagian Tengah: Deskripsi & Rating (Hilang di Slide ke-2 dst) ---
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _currentPage == 0 ? 1.0 : 0.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tema $title ini menggabungkan keindahan elegan, suasana romantis, dan latar belakang yang menakjubkan.',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < 4 ? Icons.star : Icons.star_border,
                              color: Colors.white,
                              size: 24,
                            );
                          }),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),

                  // --- Bagian Bawah: Tombol Aksi (Selalu Tampil) ---
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB33671),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            ),
                            child: const Text('Kembali', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: Arahkan ke halaman daftar Vendor
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB33671),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            ),
                            child: const Text('Cek Vendor', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
      ],
    ),
    ), // Closes GestureDetector
  ); // Closes Scaffold
  }
}