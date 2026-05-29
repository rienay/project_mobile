import 'package:flutter/material.dart';
import '../../model/vendor_model.dart';

class VendorDetailPage extends StatefulWidget {
  final Vendor vendor;

  const VendorDetailPage({Key? key, required this.vendor}) : super(key: key);

  @override
  State<VendorDetailPage> createState() => _VendorDetailPageState();
}

class _VendorDetailPageState extends State<VendorDetailPage> {
  static const Color primaryPink = Color(0xFFF43F8B);
  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color darkBg = Color(0xFF1A1A2E);

  // =====================
  // HELPER: Star builder
  // =====================
  Widget _buildStars(double rating, {double size = 16, Color color = primaryPink}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < rating.floor()) {
          return Icon(Icons.star, size: size, color: color);
        } else if (i < rating && rating - i >= 0.5) {
          return Icon(Icons.star_half, size: size, color: color);
        } else {
          return Icon(Icons.star_border, size: size, color: color);
        }
      }),
    );
  }

  // =====================
  // SECTION: HEADER BANNER
  // =====================
  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              widget.vendor.mainImage,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: Colors.grey.shade300),
            ),
          ),
          // Gradient overlay bottom
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                ),
              ),
            ),
          ),
          // Back button
          Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================
  // SECTION: VENDOR INFO
  // =====================
  Widget _buildVendorInfo() {
    final tags = _inferTags(widget.vendor.name);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar circle
          Container(
            width: 62,
            height: 62,
            margin: const EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
            ),
            child: ClipOval(
              child: Image.asset(
                widget.vendor.mainImage,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: Colors.grey.shade200),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.vendor.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 13, color: Colors.grey),
                    const SizedBox(width: 2),
                    Text(widget.vendor.location, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    _buildStars(widget.vendor.rating, size: 15),
                    const SizedBox(width: 6),
                    Text(
                      '${widget.vendor.rating}',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.vendor.reviews} reviews',
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Tags/badge row
                Wrap(
                  spacing: 6,
                  children: tags
                      .map((t) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.pink.shade50,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(t, style: TextStyle(fontSize: 10, color: primaryPink, fontWeight: FontWeight.w500)),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> _inferTags(String name) {
    final lname = name.toLowerCase();
    if (lname.contains('sakura')) return ['Japanese Style', 'Minimalis'];
    if (lname.contains('bella')) return ['Luxury Events', 'Modern Style'];
    if (lname.contains('arjuna')) return ['Wedding Planner', 'Pre-Wedding'];
    return ['Wedding', 'Events'];
  }

  // =====================
  // SECTION: STATS ROW
  // =====================
  Widget _buildStats() {
    final stats = _inferStats(widget.vendor.name);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: stats.entries.map((e) {
          return Column(
            children: [
              Icon(e.value['icon'] as IconData, size: 22, color: primaryPink),
              const SizedBox(height: 4),
              Text(e.value['value'] as String,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 2),
              Text(e.key, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Map<String, Map<String, dynamic>> _inferStats(String name) {
    final lname = name.toLowerCase();
    if (lname.contains('sakura')) {
      return {
        'Events': {'icon': Icons.calendar_today_outlined, 'value': '600+'},
        'Clients': {'icon': Icons.people_outline, 'value': '1.8K'},
        'Awards': {'icon': Icons.emoji_events_outlined, 'value': '18+'},
      };
    }
    if (lname.contains('bella')) {
      return {
        'Events': {'icon': Icons.calendar_today_outlined, 'value': '800+'},
        'Clients': {'icon': Icons.people_outline, 'value': '2.5K'},
        'Awards': {'icon': Icons.emoji_events_outlined, 'value': '25+'},
      };
    }
    return {
      'Events': {'icon': Icons.calendar_today_outlined, 'value': '200+'},
      'Clients': {'icon': Icons.people_outline, 'value': '500'},
      'Awards': {'icon': Icons.emoji_events_outlined, 'value': '10+'},
    };
  }

  // =====================
  // SECTION: PORTFOLIO
  // =====================
  Widget _buildPortfolio() {
    final List<String> portfolioImages = widget.vendor.portfolioImages.isNotEmpty
        ? widget.vendor.portfolioImages
        : [widget.vendor.mainImage];

    // Buat lebih banyak jika hanya 1 gambar (supaya grid terlihat penuh)
    final List<String> displayImages = portfolioImages.length < 5
        ? List.generate(7, (i) => portfolioImages[i % portfolioImages.length])
        : portfolioImages;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Portfolio', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
              Text('200+ photos', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Grid layout persis seperti desain: 1 besar kiri + 2 kanan, lalu 2+2, lalu 1
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Row 1: 1 besar kiri + 2 kanan
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _portfolioImage(displayImages[0], height: 160),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        _portfolioImage(displayImages.length > 1 ? displayImages[1] : displayImages[0], height: 77),
                        const SizedBox(height: 6),
                        _portfolioImage(displayImages.length > 2 ? displayImages[2] : displayImages[0], height: 77),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              // Row 2: 2 equal
              Row(
                children: [
                  Expanded(child: _portfolioImage(displayImages.length > 3 ? displayImages[3] : displayImages[0], height: 110)),
                  const SizedBox(width: 6),
                  Expanded(child: _portfolioImage(displayImages.length > 4 ? displayImages[4] : displayImages[0], height: 110)),
                ],
              ),
              const SizedBox(height: 6),
              // Row 3: 1 full lebar
              _portfolioImage(displayImages.length > 5 ? displayImages[5] : displayImages[0], height: 120, fullWidth: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _portfolioImage(String path, {required double height, bool fullWidth = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: fullWidth ? double.infinity : null,
        height: height,
        child: Image.asset(
          path,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            height: height,
            color: Colors.grey.shade200,
            child: const Icon(Icons.image, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  // =====================
  // SECTION: OUR SERVICES
  // =====================
  final List<Map<String, dynamic>> services = [
    {'icon': Icons.favorite_outline, 'label': 'Wedding\nVenue', 'color': Color(0xFFF43F8B)},
    {'icon': Icons.camera_alt_outlined, 'label': 'Photography', 'color': Color(0xFF3B82F6)},
    {'icon': Icons.restaurant_menu_outlined, 'label': 'Catering', 'color': Color(0xFFFF8C42)},
    {'icon': Icons.auto_awesome_outlined, 'label': 'Decoration', 'color': Color(0xFF10B981)},
    {'icon': Icons.music_note_outlined, 'label': 'Entertainment', 'color': Color(0xFF8B5CF6)},
    {'icon': Icons.face_retouching_natural_outlined, 'label': 'Makeup Artist', 'color': Color(0xFFEC4899)},
  ];

  Widget _buildServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Our Services', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemCount: services.length,
            itemBuilder: (_, i) {
              final s = services[i];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3))],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: (s['color'] as Color).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(s['icon'] as IconData, color: s['color'] as Color, size: 24),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      s['label'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 10, color: Colors.black87, height: 1.3),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // =====================
  // SECTION: PRICING PACKAGES
  // =====================
  Widget _buildPricingPackages() {
    final prices = _inferPrices(widget.vendor.name);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Pricing Packages', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
        ),
        const SizedBox(height: 12),
        // BASIC PACKAGE - Pink card (Most Popular)
        _buildBasicPackageCard(prices['basic']!),
        const SizedBox(height: 14),
        // PREMIUM PACKAGE - White card
        _buildPremiumPackageCard(prices['premium']!),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '✦ Custom packages available. Contact us for personalised quote',
            style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
          ),
        ),
      ],
    );
  }

  Map<String, String> _inferPrices(String name) {
    final lname = name.toLowerCase();
    if (lname.contains('sakura')) return {'basic': 'IDR 700.000', 'premium': 'IDR 2.000.000'};
    if (lname.contains('bella')) return {'basic': 'IDR 1.000.000', 'premium': 'IDR 3.000.000'};
    if (lname.contains('arjuna')) return {'basic': 'IDR 500.000', 'premium': 'IDR 1.500.000'};
    return {'basic': 'IDR 500.000', 'premium': 'IDR 1.500.000'};
  }

  Widget _buildBasicPackageCard(String price) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF43F8B), Color(0xFFFF6DAF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: primaryPink.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Basic Package', style: TextStyle(color: Colors.white70, fontSize: 13)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  children: [
                    Icon(Icons.star, color: Colors.white, size: 12),
                    SizedBox(width: 4),
                    Text('Most Popular', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(price, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('A basic package that includes essential wedding planning services.',
              style: TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 12),
          _checkItem('Venue coordination', Colors.white),
          _checkItem('Vendor management', Colors.white),
          _checkItem('Day-of coordination', Colors.white),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Choose Package', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumPackageCard(String price) {
    final premiumFeatures = [
      'Venue coordination',
      'Vendor management',
      'Day-of coordination',
      'Photography and videography',
      'Floral arrangements',
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 14, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Premium Package', style: TextStyle(color: Colors.black54, fontSize: 13)),
          const SizedBox(height: 4),
          Text(price, style: const TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('A premium package that includes all basic services plus additional features.',
              style: TextStyle(color: Colors.grey, fontSize: 11)),
          const SizedBox(height: 12),
          ...premiumFeatures.map((f) => _checkItem(f, Colors.black87)),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPink,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 0,
              ),
              child: const Text('Choose Package', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkItem(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, size: 16, color: textColor == Colors.white ? Colors.white : primaryPink),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(fontSize: 12, color: textColor)),
        ],
      ),
    );
  }

  // =====================
  // SECTION: CLIENT REVIEWS
  // =====================
  Widget _buildClientReviews() {
    final reviews = _inferReviews(widget.vendor.name);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Client Reviews', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
              Row(
                children: [
                  const Icon(Icons.star, color: primaryPink, size: 15),
                  const SizedBox(width: 3),
                  Text(
                    '${widget.vendor.rating} (${widget.vendor.reviews})',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...reviews.map((r) => _buildReviewCard(r['name']!, r['date']!, r['review']!, r['rating']!)),
      ],
    );
  }

  Widget _buildReviewCard(String name, String date, String review, String rating) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
              _buildStars(double.parse(rating), size: 14),
            ],
          ),
          const SizedBox(height: 2),
          Text(date, style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('"', style: TextStyle(fontSize: 28, color: primaryPink, height: 0.8, fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              Expanded(
                child: Text(review, style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.4)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _inferReviews(String name) {
    final lname = name.toLowerCase();
    if (lname.contains('sakura')) {
      return [
        {'name': 'Yuki & Tanaka', 'date': 'Oct 2024', 'rating': '4.5', 'review': 'Beautiful fusion of Japanese and Indonesian traditions. The cherry blossom decorations were breathtaking!'},
        {'name': 'Sari & Hiro', 'date': 'Sep 2024', 'rating': '4.5', 'review': 'Elegant, and perfectly executed. Sakura Events made our dream wedding come true.'},
      ];
    }
    if (lname.contains('bella')) {
      return [
        {'name': 'Jessica & Ryan', 'date': 'Dec 2024', 'rating': '4.5', 'review': 'Absolutely stunning! Bella Moments transformed our vision into reality with such grace and professionalism.'},
        {'name': 'Dian & Kevin', 'date': 'Nov 2024', 'rating': '4.0', 'review': 'The attention to detail was impeccable. Our luxury wedding exceeded all expectations!'},
      ];
    }
    return [
      {'name': 'Sarah & Michael', 'date': 'Nov 2024', 'rating': '5.0', 'review': 'Arjuna Wedding made our special day absolutely perfect! Every detail was handled with care and professionalism.'},
      {'name': 'Anisa & Budi', 'date': 'Oct 2024', 'rating': '4.5', 'review': 'Best wedding planner in Cilacap! They understood our vision and brought it to life beautifully.'},
    ];
  }

  // =====================
  // SECTION: ABOUT US
  // =====================
  Widget _buildAboutUs() {
    final about = _inferAbout(widget.vendor.name);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  widget.vendor.mainImage,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(width: 48, height: 48, color: Colors.grey.shade200),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.vendor.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                  Text(about['tagline']!, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(about['description']!, style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.5)),
          const SizedBox(height: 10),
          ...about['points']!.split('|').map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: primaryPink, size: 14),
                    const SizedBox(width: 6),
                    Text(p, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Map<String, String> _inferAbout(String name) {
    final lname = name.toLowerCase();
    if (lname.contains('sakura')) {
      return {
        'tagline': 'Japanese-inspired elegance',
        'description':
            'Sakura Events brings the beauty of Japanese aesthetics to Indonesian weddings. We create serene, elegant celebrations that blend tradition with modern sophistication.',
        'points': 'Certified Japanese wedding specialist|Zen-inspired designs|Cherry Blossom season specials',
      };
    }
    if (lname.contains('bella')) {
      return {
        'tagline': 'Jakarta\'s premier luxury planner',
        'description':
            'Bella Moments is Jakarta\'s premier luxury wedding planner, specialising in contemporary and sophisticated celebrations. We bring innovation and elegance to every event we create.',
        'points': '10+ years of expertise|Featured in Vogue Weddings|International vendor network',
      };
    }
    return {
      'tagline': 'Cilacap\'s trusted event team',
      'description':
          'We are an experienced wedding and event planning service, established to cater to the needs of premium intimate wedding parties. Our team specialises in creating unforgettable moments that reflect your unique love story.',
      'points': '7+ years of experience|Professional certified team|Customised packages available',
    };
  }

  // =====================
  // SECTION: GET IN TOUCH
  // =====================
  Widget _buildGetInTouch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Get In Touch', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPink,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
              ),
              child: const Text('Booking Sekarang', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call_outlined, size: 16, color: Colors.black54),
                  label: const Text('Call', style: TextStyle(color: Colors.black54, fontSize: 13)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.email_outlined, size: 16, color: Colors.black54),
                  label: const Text('Email', style: TextStyle(color: Colors.black54, fontSize: 13)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 13, color: Colors.grey),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  _inferAddress(widget.vendor.name),
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Icon(Icons.access_time, size: 13, color: Colors.grey),
              const SizedBox(width: 4),
              Text('Open: Mon – Sun  9:00 AM – 7:00 PM', style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  String _inferAddress(String name) {
    final lname = name.toLowerCase();
    if (lname.contains('sakura')) return 'Jl. Dirgja No. 36, Bandung, Jawa Barat';
    if (lname.contains('bella')) return 'Jl. Sudirman Kav. 52, Jakarta Selatan';
    return 'Jl. Ahmad Yani No. 221, Cilacap Street';
  }

  // =====================
  // BUILD
  // =====================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -20),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        _buildVendorInfo(),
                        _buildStats(),
                        const Divider(height: 1, color: Color(0xFFF5F5F5)),
                        const SizedBox(height: 20),
                        _buildPortfolio(),
                        const SizedBox(height: 24),
                        _buildServices(),
                        const SizedBox(height: 24),
                        _buildPricingPackages(),
                        const SizedBox(height: 24),
                        _buildClientReviews(),
                        const SizedBox(height: 24),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 12),
                          child: Text('About Us', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                        ),
                        _buildAboutUs(),
                        const SizedBox(height: 24),
                        _buildGetInTouch(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}