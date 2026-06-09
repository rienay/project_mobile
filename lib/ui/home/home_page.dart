import 'package:flutter/material.dart';
import 'package:project_mobile/helpers/api_helper.dart';
import 'package:project_mobile/ui/auth/login_page.dart';
import 'package:project_mobile/ui/main_navigator.dart'; 
import 'package:project_mobile/ui/home/open_slider.dart';
import 'package:project_mobile/model/vendor_model.dart';
import 'package:project_mobile/ui/vendor/vendor_detail_page.dart';
import 'package:project_mobile/ui/vendor/vendor_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeData(
      fontFamily: 'Plus Jakarta Sans',
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE91E63)),
      useMaterial3: true,
    ) == null ? const SizedBox() : MaterialApp(
      title: 'Wedding Planner Custom App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Plus Jakarta Sans',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE91E63)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Available wedding categories mapped dynamically
  List<Map<String, dynamic>> categories = [];

  // Active category element ID
  String _selectedCategoryId = '';

  // Trend lists
  List<Map<String, dynamic>> trendWeddings = [];
  List<Map<String, dynamic>> trendMUA = [];
  List<Map<String, dynamic>> trendWO = [];
  List<Map<String, dynamic>> trendPhotoVideo = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDbData();
  }

  Future<void> _fetchDbData() async {
    try {
      final rawData = await ApiHelper.getVendor();
      
      final List<Map<String, dynamic>> dbCategories = [];
      final List<Map<String, dynamic>> dbTrendWeddings = [];
      final List<Map<String, dynamic>> dbTrendMUA = [];
      final List<Map<String, dynamic>> dbTrendWO = [];
      final List<Map<String, dynamic>> dbTrendPhotoVideo = [];

      for (var item in rawData) {
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
        
        final ratingVal = double.tryParse(item['rating']?.toString() ?? '') ?? 4.0;
        final reviewsVal = int.tryParse(item['jumlah_review']?.toString() ?? '') ?? 0;
        final isTrendVal = int.tryParse(item['is_trend']?.toString() ?? '') ?? 0;
        final isWeddingReferenceVal = int.tryParse(item['is_wedding_reference']?.toString() ?? '') ?? 0;
        final weddingReferenceTitleVal = item['wedding_reference_title'] ?? '';
        
        final String rawRefFoto = item['wedding_reference_foto'] ?? '';
        final String weddingReferenceFotoVal = rawRefFoto.isNotEmpty
            ? rawRefFoto.split(',').map((f) => ApiHelper.formatImageUrl(f.trim())).join(',')
            : '';
            
        final weddingReferenceDescriptionVal = item['wedding_reference_description'] ?? '';
        final trendFotoVal = ApiHelper.formatImageUrl(item['trend_foto'] ?? '');
        final mainImage = ApiHelper.formatImageUrl(item['foto'] ?? '');

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
          isTrend: isTrendVal,
          isWeddingReference: isWeddingReferenceVal,
          weddingReferenceTitle: weddingReferenceTitleVal,
          weddingReferenceFoto: weddingReferenceFotoVal,
          weddingReferenceDescription: weddingReferenceDescriptionVal,
          trendFoto: trendFotoVal,
        );

        if (item['is_wedding_reference'] == 1 || item['is_wedding_reference'] == '1') {
          dbCategories.add({
            'id': item['id']?.toString() ?? '',
            'title': item['wedding_reference_title'] ?? item['nama'] ?? '',
            'image': weddingReferenceFotoVal.isNotEmpty ? weddingReferenceFotoVal : mainImage,
            'slider_image': weddingReferenceFotoVal.isNotEmpty ? weddingReferenceFotoVal : mainImage,
            'description': item['wedding_reference_description'] ?? '',
            'vendor': vendor,
          });
        }

        if (item['is_trend'] == 1 || item['is_trend'] == '1') {
          final title = item['nama'] ?? '';
          final desc = item['deskripsi'] ?? '';
          final rating = ratingVal;
          // Use trend_foto if available, otherwise fall back to profile foto
          final trendImage = trendFotoVal.isNotEmpty && !trendFotoVal.endsWith('default_vendor.png')
              ? trendFotoVal
              : mainImage;

          final trendItem = {
            'title': title,
            'description': desc,
            'image': trendImage,
            'rating': rating,
            'vendor': vendor,
          };

          final catLower = category.toLowerCase();
          if (catLower == 'mua') {
            dbTrendMUA.add(trendItem);
          } else if (catLower == 'wedding organizer') {
            dbTrendWO.add(trendItem);
          } else if (catLower.contains('photography') || catLower.contains('videography')) {
            dbTrendPhotoVideo.add(trendItem);
          } else {
            final refTitle = item['wedding_reference_title'];
            // For wedding concept trends, use trendImage
            dbTrendWeddings.add({
              'title': (refTitle != null && refTitle.toString().isNotEmpty) ? refTitle : title,
              'description': desc,
              'image': trendImage,
              'rating': rating,
              'vendor': vendor,
            });
          }
        }
      }

      setState(() {
        categories = dbCategories;
        if (dbCategories.isNotEmpty) {
          _selectedCategoryId = dbCategories[0]['id'];
        } else {
          _selectedCategoryId = '';
        }
        trendWeddings = dbTrendWeddings;
        trendMUA = dbTrendMUA;
        trendWO = dbTrendWO;
        trendPhotoVideo = dbTrendPhotoVideo;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Gagal memuat tren/referensi dari DB: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Immersive Hero Carousel Header section
            _buildHeroHeader(context),
            
            const SizedBox(height: 24),

            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF4D6D)),
                  ),
                ),
              )
            else if (categories.isEmpty &&
                trendWeddings.isEmpty &&
                trendMUA.isEmpty &&
                trendWO.isEmpty &&
                trendPhotoVideo.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.0),
                  child: Text(
                    'Belum ada data referensi atau tren.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            else ...[
              // Wedding Reference Section Title
              if (categories.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Wedding Reference',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[900],
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Horizontal scrolling reference circles
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      final isSelected = _selectedCategoryId == cat['id'];
                      return _buildCategoryItem(
                        cat['title'], 
                        cat['image'], 
                        cat['id'], 
                        isSelected
                      );
                    },
                  ),
                ),
                const Divider(color: Color(0xFFEEEEEE), height: 40, thickness: 1, indent: 16, endIndent: 16),
              ],
              
              // Trend Wedding Heading
              if (trendWeddings.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Trend Wedding',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[900],
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Trend Wedding horizontal cards custom viewport
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: trendWeddings.length,
                    itemBuilder: (context, index) {
                      final item = trendWeddings[index];
                      return _buildTrendCard(
                        context,
                        item,
                      );
                    },
                  ),
                ),
                const Divider(color: Color(0xFFEEEEEE), height: 40, thickness: 1, indent: 16, endIndent: 16),
              ],

              // Trend MUA Heading
              if (trendMUA.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Trend MUA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[900],
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Trend MUA Cards
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: trendMUA.length,
                    itemBuilder: (context, index) {
                      final item = trendMUA[index];
                      return _buildTrendCard(
                        context,
                        item,
                      );
                    },
                  ),
                ),
                const Divider(color: Color(0xFFEEEEEE), height: 40, thickness: 1, indent: 16, endIndent: 16),
              ],

              // Trend WO Heading
              if (trendWO.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Trend WO',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[900],
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Trend WO Cards
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: trendWO.length,
                    itemBuilder: (context, index) {
                      final item = trendWO[index];
                      return _buildTrendCard(
                        context,
                        item,
                      );
                    },
                  ),
                ),
                const Divider(color: Color(0xFFEEEEEE), height: 40, thickness: 1, indent: 16, endIndent: 16),
              ],

              // Trend Photografer & Videografer Heading
              if (trendPhotoVideo.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Trend Photografer & Videografer',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[900],
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Trend Photografer & Videografer Cards
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: trendPhotoVideo.length,
                    itemBuilder: (context, index) {
                      final item = trendPhotoVideo[index];
                      return _buildTrendCard(
                        context,
                        item,
                      );
                    },
                  ),
                ),
              ],
              const SizedBox(height: 32),
            ],
          ],
        ),
      ),
    );
  }

  // Hero header with background image, custom opacity layers and premium layout titles
  Widget _buildHeroHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 240,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/hero.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Dark linear aesthetic overlay gradient
        Container(
          height: 240,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFFE91E63).withOpacity(0.35), // Gradien pink lembut di atas
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.8),
              ],
            ),
          ),
        ),
        // Positioned custom typography texts
        Positioned(
          bottom: 24,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sambut perjalanan cintamu',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Playfair Display',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Biarkan kami menghias hari untuk hari spesialmu!',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Elegant circular reference element with customizable active index tracking
  Widget _buildCategoryItem(String title, String imageUrl, String id, bool isSelected) {
    final String displayUrl = imageUrl.split(',').first.trim();
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryId = id;
        });

        // Cari index dari item yang di klik
        int initialIndex = categories.indexWhere((cat) => cat['id'] == id);
        if (initialIndex == -1) initialIndex = 0;

        // Buka halaman slider dengan mengirim daftar kategori
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OpenSlider(
              categories: categories,
              initialIndex: initialIndex,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFFE91E63) : Colors.grey[300]!,
                  width: isSelected ? 2.5 : 1.0,
                ),
              ),
              padding: const EdgeInsets.all(3.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: displayUrl.startsWith('http')
                    ? Image.network(
                        displayUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.favorite, color: Colors.grey, size: 20),
                        ),
                      )
                    : Image.asset(
                        displayUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.favorite, color: Colors.grey, size: 20),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? const Color(0xFFE91E63) : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Elegant Trend Wedding cards matching high fidelity custom parameters
  Widget _buildTrendCard(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    final String title = item['title'] ?? '';
    final String description = item['description'] ?? '';
    final String imageUrl = item['image'] ?? '';
    final double rating = item['rating'] ?? 4.0;
    final Vendor? vendor = item['vendor'] as Vendor?;
    
    final String displayUrl = imageUrl.split(',').first.trim();

    return GestureDetector(
      onTap: () {
        if (vendor != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VendorDetailPage(vendor: vendor),
            ),
          );
        }
      },
      child: Container(
        width: 300,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Backdrop photo
              Positioned.fill(
                child: displayUrl.startsWith('http')
                    ? Image.network(
                        displayUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      )
                    : Image.asset(
                        displayUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.favorite, color: Colors.grey),
                        ),
                      ),
              ),
              // Bottom vignette layer
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.9),
                      ],
                      stops: const [0.3, 0.6, 1.0],
                    ),
                  ),
                ),
              ),
              // Content labels
              Positioned(
                bottom: 16,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Rating Star Row Match
                    Row(
                      children: [
                        _buildStars(rating),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Row helper mapping high-fidelity ratings
  Widget _buildStars(double rating) {
    List<Widget> stars = [];
    int filledStars = rating.floor();
    for (int i = 0; i < 5; i++) {
      if (i < filledStars) {
        stars.add(const Icon(
          Icons.star,
          color: Colors.white,
          size: 14,
        ));
      } else {
        stars.add(Icon(
          Icons.star_border,
          color: Colors.white.withOpacity(0.7),
          size: 14,
        ));
      }
      if (i < 4) {
        stars.add(const SizedBox(width: 2));
      }
    }
    return Row(mainAxisSize: MainAxisSize.min, children: stars);
  }
}
