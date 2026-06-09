import 'package:flutter/material.dart';
import '../../model/vendor_model.dart';
import 'package:project_mobile/ui/vendor/vendor_detail_page.dart';
import 'package:project_mobile/helpers/api_helper.dart';

class VendorListPage extends StatefulWidget {
  const VendorListPage({super.key});

  @override
  State<VendorListPage> createState() => _VendorListPageState();
}

class _VendorListPageState extends State<VendorListPage> {
  int _currentBannerIndex = 0;
  final PageController _bannerController = PageController();
  bool isLoading = true;

  final List<String> bannerImages = [
    'assets/vendor/arjuna_wedding.png',
    'assets/vendor/bella_moment.png',
    'assets/vendor/sakura_event.png',
  ];

  Map<String, List<Vendor>> kategoriVendor = {};

  @override
  void initState() {
    super.initState();
    _fetchVendors();
  }

  Future<void> _fetchVendors() async {
    try {
      final data = await ApiHelper.getVendor();
      final Map<String, List<Vendor>> grouped = {};
      
      for (var item in data) {
        String rawCategory = item['kategori'] ?? 'Lainnya';
        String category = rawCategory;
        if (rawCategory.toLowerCase() == 'make up') {
          category = 'MUA';
        } else if (rawCategory.toLowerCase() == 'photography' || rawCategory.toLowerCase() == 'videography') {
          category = 'PHOTOGRAPHY & VIDEOGRAPHY';
        } else if (rawCategory.toLowerCase() == 'dekorasi') {
          category = 'DEKORASI';
        } else if (rawCategory.toLowerCase() == 'musik') {
          category = 'MUSIK & ENTERTAINMENT';
        } else if (rawCategory.toLowerCase() == 'catering') {
          category = 'CATERING';
        } else if (rawCategory.toLowerCase().contains('organizer') || rawCategory.toLowerCase().contains('planner')) {
          category = 'WEDDING ORGANIZER';
        }
        
        final ratingVal = double.tryParse(item['rating'].toString()) ?? 0.0;
        final reviewsVal = int.tryParse(item['jumlah_review'].toString()) ?? 0;
        
        String fotoName = item['foto'] ?? '';
        String mainImage = fotoName.isNotEmpty
            ? (fotoName.startsWith('http') ? fotoName : 'http://10.78.162.176/ci/lovewedding/public/images/$fotoName')
            : 'assets/images/default_vendor.png';
            
        final vendor = Vendor(
          id: item['id']?.toString() ?? '',
          name: item['nama'] ?? '',
          location: item['lokasi'] ?? '',
          rating: ratingVal,
          reviews: reviewsVal,
          mainImage: mainImage,
          portfolioImages: [mainImage],
          description: item['deskripsi'] ?? '',
          services: [],
          packages: [],
          price: item['harga']?.toString() ?? '0',
          phone: item['no_telepon'] ?? '',
          experience: item['pengalaman'] ?? '',
          servicesText: item['layanan'] ?? '',
          reasonsText: item['alasan'] ?? '',
          notesText: item['catatan'] ?? '',
          category: category,
        );
        
        if (!grouped.containsKey(category)) {
          grouped[category] = [];
        }
        grouped[category]!.add(vendor);
      }
      
      setState(() {
        kategoriVendor = grouped;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Gagal mengambil data vendor: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF43F8B)),
                ),
              )
            : NotificationListener<ScrollNotification>(
          onNotification: (_) => false,
          child: CustomScrollView(
            slivers: [
              // BANNER SLIDER
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 250,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _bannerController,
                        itemCount: bannerImages.length,
                        onPageChanged: (index) {
                          setState(() => _currentBannerIndex = index);
                        },
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  bannerImages[index],
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      Container(color: Colors.grey.shade200),
                                ),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withValues(alpha: 0.6),
                                        Colors.transparent,
                                      ],
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
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
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
                                color: _currentBannerIndex == index
                                    ? const Color(0xFFF43F8B)
                                    : Colors.white54,
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 15)),

              // KATEGORI + CARD 
              ...kategoriVendor.keys.map((kategori) {
                return SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          kategori,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 260,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(left: 20, right: 8),
                          itemCount: kategoriVendor[kategori]!.length,
                          itemBuilder: (context, index) {
                            final vendor = kategoriVendor[kategori]![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        VendorDetailPage(vendor: vendor),
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
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        child: vendor.mainImage.startsWith('http')
                                            ? Image.network(
                                                vendor.mainImage,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (context, error, stackTrace) {
                                                  return Container(
                                                    color: Colors.grey.shade200,
                                                    child: const Icon(
                                                        Icons.broken_image,
                                                        color: Colors.grey),
                                                  );
                                                },
                                              )
                                            : Image.asset(
                                                vendor.mainImage,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (context, error, stackTrace) {
                                                  return Container(
                                                    color: Colors.grey.shade200,
                                                    child: const Icon(
                                                        Icons.broken_image,
                                                        color: Colors.grey),
                                                  );
                                                },
                                              ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.center,
                                            colors: [
                                              Colors.black
                                                  .withValues(alpha: 0.6),
                                              Colors.transparent,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 16,
                                      left: 16,
                                      right: 16,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            vendor.name,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            vendor.description,
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 11),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: List.generate(5,
                                                (starIndex) {
                                              return Icon(
                                                starIndex < vendor.rating.round()
                                                    ? Icons.star
                                                    : Icons.star_border,
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
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}