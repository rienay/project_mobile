import 'package:flutter/material.dart';
import '../../model/vendor_model.dart';
import 'vendor_detail_page.dart'; 

class VendorListPage extends StatefulWidget {
  const VendorListPage({Key? key}) : super(key: key);

  @override
  State<VendorListPage> createState() => _VendorListPageState();
}

class _VendorListPageState extends State<VendorListPage> {
  int _currentIndex = 1; // Aktif di menu 'Vendor' sesuai desain Figma
  int _currentBannerIndex = 0; // Mengatur slide banner atas
  final PageController _bannerController = PageController();

  // BANNER ATAS SLIDER CAROUSEL
  final List<String> bannerImages = [
    'assets/vendor/arjuna_wedding.png',
    'assets/vendor/bella_moment.png',
    'assets/vendor/sakura_event.png',
  ];

  // 🔴 URUTAN FOTO VENDOR DISESUAIKAN PERSIS DENGAN FORMAT .JPG ANGKA DI FOLDERMU!
  final Map<String, List<Vendor>> kategoriVendor = {
    'Wedding Organizer': [
      Vendor(
        name: 'Bella Moments',
        location: 'Cilacap, Indonesia',
        rating: 4.0,
        reviews: 120,
        mainImage: 'assets/vendor/bella_moment.png', // Kotak 1
        portfolioImages: ['assets/vendor/bella_moment.png'],
        description: 'Buat momenmu sekarang juga bersama Bella Moments.',
        services: [], packages: [],
      ),
      Vendor(
        name: 'Bella Moments 1',
        location: 'Bandung, Indonesia',
        rating: 4.5,
        reviews: 85,
        mainImage: 'assets/vendor/bella_moment1.png', // Kotak 2
        portfolioImages: ['assets/vendor/bella_moment1.png'],
        description: 'Buat momenmu sekarang juga.',
        services: [], packages: [],
      ),
      Vendor(
        name: 'Bella Moments 2',
        location: 'Cilacap, Indonesia',
        rating: 4.9,
        reviews: 200,
        mainImage: 'assets/vendor/bella_moment2.png', // Kotak 3
        portfolioImages: ['assets/vendor/bella_moment2.png'],
        description: 'Buat momenmu sekarang juga.',
        services: [], packages: [],
      ),
      Vendor(
        name: 'Bella Moments 3',
        location: 'Jakarta, Indonesia',
        rating: 4.8,
        reviews: 150,
        mainImage: 'assets/vendor/bella_moment3.png', // Kotak 4
        portfolioImages: ['assets/vendor/bella_moment3.png'],
        description: 'Buat momenmu sekarang juga.',
        services: [], packages: [],
      ),
      Vendor(
        name: 'Bella Moments 4',
        location: 'Yogyakarta, Indonesia',
        rating: 4.6,
        reviews: 64,
        mainImage: 'assets/vendor/bella_moment4.png', // Kotak 5
        portfolioImages: ['assets/vendor/bella_moment4.png'],
        description: 'Buat momenmu sekarang juga.',
        services: [], packages: [],
      ),
    ],
    'MUA': [
      Vendor(
        name: 'Arjuna Wedding',
        location: 'Cilacap, Indonesia',
        rating: 4.0,
        reviews: 95,
        mainImage: 'assets/vendor/arjuna_wedding.png', // Kotak 1
        portfolioImages: ['assets/vendor/arjuna_wedding.png'],
        description: 'Pilihan makeup terbaik untuk hari bahagiamu.',
        services: [], packages: [],
      ),
      Vendor(
        name: 'Arjuna Wedding 1',
        location: 'Purwokerto, Indonesia',
        rating: 4.7,
        reviews: 24,
        mainImage: 'assets/vendor/arjuna_wedding1.png', // Kotak 2
        portfolioImages: ['assets/vendor/arjuna_wedding1.png'],
        description: 'Pilihanmu.',
        services: [], packages: [],
      ),
      Vendor(
        name: 'Arjuna Wedding 2',
        location: 'Bandung, Indonesia',
        rating: 4.2,
        reviews: 50,
        mainImage: 'assets/vendor/arjuna_wedding2.png', // Kotak 3
        portfolioImages: ['assets/vendor/arjuna_wedding2.png'],
        description: 'Pilihanmu.',
        services: [], packages: [],
      ),
      Vendor(
        name: 'Arjuna Wedding 3',
        location: 'Cilacap, Indonesia',
        rating: 5.0,
        reviews: 18,
        mainImage: 'assets/vendor/arjuna_wedding3.png', // Kotak 4
        portfolioImages: ['assets/vendor/arjuna_wedding3.png'],
        description: 'Pilihanmu.',
        services: [], packages: [],
      ),
      Vendor(
        name: 'Arjuna Wedding 4',
        location: 'Jakarta, Indonesia',
        rating: 4.9,
        reviews: 112,
        mainImage: 'assets/vendor/arjuna_wedding4.png', // Kotak 5
        portfolioImages: ['assets/vendor/arjuna_wedding4.png'],
        description: 'Pilihanmu.',
        services: [], packages: [],
      ),
    ],
    'PHOTOGRAPHY & VIDEOGRAPHY': [
      Vendor(
        name: 'Sakura Event',
        location: 'Purwokerto, Indonesia',
        rating: 4.7,
        reviews: 60,
        mainImage: 'assets/vendor/sakura_event.png', // Kotak 1
        portfolioImages: ['assets/vendor/sakura_event.png'],
        description: 'Capturing your beautiful wedding moments.',
        services: [], packages: [],
      ),
      Vendor(
        name: 'Sakura Event 1',
        location: 'Cilacap, Indonesia',
        rating: 4.9,
        reviews: 45,
        mainImage: 'assets/vendor/sakura_event1.png', // Kotak 2
        portfolioImages: ['assets/vendor/sakura_event1.png'],
        description: 'Capturing your beautiful moments.',
        services: [], packages: [],
      ),
      Vendor(
        name: 'Sakura Event 2',
        location: 'Jakarta, Indonesia',
        rating: 4.6,
        reviews: 78,
        mainImage: 'assets/vendor/sakura_event2.png', // Kotak 3
        portfolioImages: ['assets/vendor/sakura_event2.png'],
        description: 'Capturing your beautiful moments.',
        services: [], packages: [],
      ),
      Vendor(
        name: 'Sakura Event 3',
        location: 'Bandung, Indonesia',
        rating: 4.4,
        reviews: 30,
        mainImage: 'assets/vendor/sakura_event3.png', // Kotak 4
        portfolioImages: ['assets/vendor/sakura_event3.png'],
        description: 'Capturing your beautiful moments.',
        services: [], packages: [],
      ),
      Vendor(
        name: 'Sakura Event 4',
        location: 'Semarang, Indonesia',
        rating: 4.8,
        reviews: 55,
        mainImage: 'assets/vendor/sakura_event4.png', // Kotak 5
        portfolioImages: ['assets/vendor/sakura_event4.png'],
        description: 'Capturing your beautiful moments.',
        services: [], packages: [],
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BANNER ATAS SLIDER
              SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _bannerController,
                      itemCount: bannerImages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentBannerIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                bannerImages[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const Positioned(
                      bottom: 40,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sambut perjalanan cintamu',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Biarkan kami menghias hari untuk hari spesialmu!',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 20,
                      child: Row(
                        children: List.generate(bannerImages.length, (index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 6),
                            width: _currentBannerIndex == index ? 18 : 6,
                            height: 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: _currentBannerIndex == index ? const Color(0xFFF43F8B) : Colors.white54,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // RENDER KATEGORI DAN CARD HORIZONTAL
              ...kategoriVendor.keys.map((kategori) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Text(
                        kategori,
                        style: TextStyle(fontSize: 15, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 260, 
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 20, right: 8),
                        itemCount: kategoriVendor[kategori]!.length,
                        itemBuilder: (context, index) {
                          final vendor = kategoriVendor[kategori]![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VendorDetailPage(vendor: vendor),
                                ),
                              );
                            },
                            child: Container(
                              width: 290, 
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        vendor.mainImage,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey.shade200,
                                            child: const Icon(Icons.broken_image, color: Colors.grey),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.center,
                                          colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    left: 16,
                                    right: 16,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vendor.name,
                                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          vendor.description,
                                          style: const TextStyle(color: Colors.white70, fontSize: 11),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: List.generate(5, (starIndex) {
                                            return Icon(
                                              starIndex < 4 ? Icons.star : Icons.star_border,
                                              color: Colors.white,
                                              size: 16,
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFF43F8B), 
        unselectedItemColor: Colors.grey,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline), activeIcon: Icon(Icons.people), label: 'Vendor'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), activeIcon: Icon(Icons.assignment), label: 'Idea'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}