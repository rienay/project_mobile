import 'package:flutter/material.dart';
import '../../model/vendor_model.dart';
import 'booking_konsultasi_page.dart';
import 'hubungi_vendor_sheet.dart';

class VendorDetailPage extends StatefulWidget {
  final Vendor vendor;

  const VendorDetailPage({super.key, required this.vendor});

  @override
  State<VendorDetailPage> createState() => _VendorDetailPageState();
}

class _VendorDetailPageState extends State<VendorDetailPage> {
  static const Color primaryPink = Color(0xFFF43F8B);
  static const Color bgColor = Color(0xFFF7F9FC);

  Widget _buildStars(double rating, {double size = 16, Color color = primaryPink}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < rating.floor()) return Icon(Icons.star, size: size, color: color);
        if (i < rating && rating - i >= 0.5) return Icon(Icons.star_half, size: size, color: color);
        return Icon(Icons.star_border, size: size, color: color);
      }),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              widget.vendor.mainImage,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: Colors.grey.shade300),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4)],
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorInfo() {
    final tags = _inferTags(widget.vendor.name);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10)],
            ),
            child: ClipOval(
              child: Image.asset(widget.vendor.mainImage, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: Colors.grey.shade200)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.vendor.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.location_on, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(widget.vendor.location, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  _buildStars(widget.vendor.rating, size: 14),
                  const SizedBox(width: 6),
                  Text('${widget.vendor.rating}',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(width: 4),
                  Text('(${widget.vendor.reviews} reviews)',
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ]),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: tags.map((t) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryPink.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(t, style: const TextStyle(fontSize: 10, color: primaryPink, fontWeight: FontWeight.w600)),
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> _inferTags(String name) {
    final l = name.toLowerCase();
    if (l.contains('sakura')) return ['Japanese Style', 'Minimalis'];
    if (l.contains('bella')) return ['Luxury Events', 'Modern Style'];
    if (l.contains('arjuna')) return ['Wedding Planner', 'Pre-Wedding'];
    return ['Wedding', 'Events'];
  }

  Widget _buildStats() {
    final stats = _inferStats(widget.vendor.name);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: stats.entries.map((e) => Expanded(
          child: Column(children: [
            Icon(e.value['icon'] as IconData, size: 24, color: primaryPink),
            const SizedBox(height: 6),
            Text(e.value['value'] as String,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 2),
            Text(e.key, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ]),
        )).toList(),
      ),
    );
  }

  Map<String, Map<String, dynamic>> _inferStats(String name) {
    final l = name.toLowerCase();
    if (l.contains('sakura')) return {
      'Events': {'icon': Icons.calendar_today_outlined, 'value': '600+'},
      'Clients': {'icon': Icons.people_outline, 'value': '1.8K'},
      'Awards': {'icon': Icons.emoji_events_outlined, 'value': '18+'},
    };
    if (l.contains('bella')) return {
      'Events': {'icon': Icons.calendar_today_outlined, 'value': '800+'},
      'Clients': {'icon': Icons.people_outline, 'value': '2.5K'},
      'Awards': {'icon': Icons.emoji_events_outlined, 'value': '25+'},
    };
    return {
      'Events': {'icon': Icons.calendar_today_outlined, 'value': '200+'},
      'Clients': {'icon': Icons.people_outline, 'value': '500'},
      'Awards': {'icon': Icons.emoji_events_outlined, 'value': '10+'},
    };
  }

  Widget _buildPortfolio() {
    final List<String> portfolioImages = widget.vendor.portfolioImages.isNotEmpty
        ? widget.vendor.portfolioImages : [widget.vendor.mainImage];
    final List<String> display = portfolioImages.length < 5
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
              const Text('Portfolio', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
              Text('See All', style: TextStyle(fontSize: 12, color: primaryPink, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Row(children: [
              Expanded(flex: 2, child: _pImg(display[0], height: 160)),
              const SizedBox(width: 8),
              Expanded(child: Column(children: [
                _pImg(display.length > 1 ? display[1] : display[0], height: 76),
                const SizedBox(height: 8),
                _pImg(display.length > 2 ? display[2] : display[0], height: 76),
              ])),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: _pImg(display.length > 3 ? display[3] : display[0], height: 110)),
              const SizedBox(width: 8),
              Expanded(child: _pImg(display.length > 4 ? display[4] : display[0], height: 110)),
            ]),
            const SizedBox(height: 8),
            _pImg(display.length > 5 ? display[5] : display[0], height: 120, fullWidth: true),
          ]),
        ),
      ],
    );
  }

  Widget _pImg(String path, {required double height, bool fullWidth = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: fullWidth ? double.infinity : null,
        height: height,
        child: Image.asset(path, fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: height, color: Colors.grey.shade200,
              child: const Icon(Icons.image, color: Colors.grey))),
      ),
    );
  }

  Widget _buildServices() {
    final services = [
      {'icon': Icons.favorite_outline, 'label': 'Wedding\nVenue', 'color': const Color(0xFFF43F8B)},
      {'icon': Icons.camera_alt_outlined, 'label': 'Photography', 'color': const Color(0xFF3B82F6)},
      {'icon': Icons.restaurant_menu_outlined, 'label': 'Catering', 'color': const Color(0xFFFF8C42)},
      {'icon': Icons.auto_awesome_outlined, 'label': 'Decoration', 'color': const Color(0xFF10B981)},
      {'icon': Icons.music_note_outlined, 'label': 'Entertainment', 'color': const Color(0xFF8B5CF6)},
      {'icon': Icons.face_retouching_natural_outlined, 'label': 'Makeup', 'color': const Color(0xFFEC4899)},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Our Services', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.1,
            ),
            itemCount: services.length,
            itemBuilder: (_, i) {
              final s = services[i];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 6)],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: (s['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(s['icon'] as IconData, color: s['color'] as Color, size: 22),
                    ),
                    const SizedBox(height: 8),
                    Text(s['label'] as String, textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 10, color: Colors.black87, fontWeight: FontWeight.w500)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPricingPackages() {
    final prices = _inferPrices(widget.vendor.name);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Pricing Packages', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
        ),
        const SizedBox(height: 16),
        _buildBasicPackageCard(prices['basic']!),
        const SizedBox(height: 16),
        _buildPremiumPackageCard(prices['premium']!),
        const SizedBox(height: 8),
        Center(child: Text('Need custom packages? Contact us.',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500))),
      ],
    );
  }

  Map<String, String> _inferPrices(String name) {
    final l = name.toLowerCase();
    if (l.contains('sakura')) return {'basic': 'IDR 700.000', 'premium': 'IDR 2.000.000'};
    if (l.contains('bella')) return {'basic': 'IDR 1.000.000', 'premium': 'IDR 3.000.000'};
    if (l.contains('arjuna')) return {'basic': 'IDR 500.000', 'premium': 'IDR 1.500.000'};
    return {'basic': 'IDR 500.000', 'premium': 'IDR 1.500.000'};
  }

  Widget _buildBasicPackageCard(String price) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [primaryPink, Color(0xFFFF6DAF)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: primaryPink.withValues(alpha: 0.25), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Basic Package', style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [
                  Icon(Icons.star, color: Colors.white, size: 10),
                  SizedBox(width: 4),
                  Text('Popular', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(price, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Perfect for intimate celebrations.', style: TextStyle(color: Colors.white70, fontSize: 12)),
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryPink.withValues(alpha: 0.1)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Premium Package', style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(price, style: const TextStyle(color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('All-inclusive luxury experience.', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 12),
          _checkItem('Venue coordination', Colors.black87),
          _checkItem('Vendor management', Colors.black87),
          _checkItem('Day-of coordination', Colors.black87),
          _checkItem('Photography', Colors.black87),
          _checkItem('Decoration', Colors.black87),
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
      child: Row(children: [
        Icon(Icons.check_circle, size: 16,
            color: textColor == Colors.white ? Colors.white70 : primaryPink),
        const SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 12,
            color: textColor == Colors.white ? Colors.white : Colors.black54)),
      ]),
    );
  }

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
              const Text('Client Reviews', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryPink.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8),
                ),
                child: Row(children: [
                  const Icon(Icons.star, color: primaryPink, size: 12),
                  const SizedBox(width: 4),
                  Text('${widget.vendor.rating}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryPink)),
                ]),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...reviews.map((r) => _buildReviewCard(r['name']!, r['date']!, r['review']!, r['rating']!)),
      ],
    );
  }

  Widget _buildReviewCard(String name, String date, String review, String rating) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 6)],
        border: Border(left: BorderSide(color: primaryPink.withValues(alpha: 0.3), width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
              _buildStars(double.tryParse(rating) ?? 5.0, size: 12),
            ],
          ),
          const SizedBox(height: 4),
          Text(date, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
          const SizedBox(height: 10),
          Text(review, style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.5)),
        ],
      ),
    );
  }

  List<Map<String, String>> _inferReviews(String name) {
    final l = name.toLowerCase();
    if (l.contains('sakura')) return [
      {'name': 'Yuki & Tanaka', 'date': 'Oct 2024', 'rating': '4.5', 'review': 'Beautiful fusion of Japanese and Indonesian traditions. The cherry blossom decorations were breathtaking!'},
      {'name': 'Sari & Hiro', 'date': 'Sep 2024', 'rating': '4.5', 'review': 'Elegant, and perfectly executed. Sakura Events made our dream wedding come true.'},
    ];
    if (l.contains('bella')) return [
      {'name': 'Jessica & Ryan', 'date': 'Dec 2024', 'rating': '4.5', 'review': 'Absolutely stunning! Bella Moments transformed our vision into reality with such grace and professionalism.'},
      {'name': 'Dian & Kevin', 'date': 'Nov 2024', 'rating': '4.0', 'review': 'The attention to detail was impeccable. Our luxury wedding exceeded all expectations!'},
    ];
    return [
      {'name': 'Sarah & Michael', 'date': 'Nov 2024', 'rating': '5.0', 'review': 'Arjuna Wedding made our special day absolutely perfect! Every detail was handled with care and professionalism.'},
      {'name': 'Anisa & Budi', 'date': 'Oct 2024', 'rating': '4.5', 'review': 'Best wedding planner in Cilacap! They understood our vision and brought it to life beautifully.'},
    ];
  }

  Widget _buildAboutUs() {
    final about = _inferAbout(widget.vendor.name);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(widget.vendor.mainImage, width: 50, height: 50, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(width: 50, height: 50, color: Colors.grey.shade200)),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.vendor.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                Text(about['tagline']!, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            )),
          ]),
          const SizedBox(height: 16),
          Text(about['description']!, style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.5)),
          const SizedBox(height: 16),
          ...about['points']!.split('|').map((p) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(children: [
              Container(width: 6, height: 6,
                  decoration: const BoxDecoration(color: primaryPink, shape: BoxShape.circle)),
              const SizedBox(width: 10),
              Expanded(child: Text(p, style: const TextStyle(fontSize: 12, color: Colors.black87))),
            ]),
          )),
        ],
      ),
    );
  }

  Map<String, String> _inferAbout(String name) {
    final l = name.toLowerCase();
    if (l.contains('sakura')) return {
      'tagline': 'Japanese-inspired elegance',
      'description': 'Sakura Events brings the beauty of Japanese aesthetics to Indonesian weddings. We create serene, elegant celebrations that blend tradition with modern sophistication.',
      'points': 'Certified Japanese wedding specialist|Zen-inspired designs|Cherry Blossom season specials',
    };
    if (l.contains('bella')) return {
      'tagline': 'Jakarta\'s premier luxury planner',
      'description': 'Bella Moments is Jakarta\'s premier luxury wedding planner, specialising in contemporary and sophisticated celebrations.',
      'points': '10+ years of expertise|Featured in Vogue Weddings|International vendor network',
    };
    return {
      'tagline': 'Cilacap\'s trusted event team',
      'description': 'We are an experienced wedding and event planning service. Our team specialises in creating unforgettable moments that reflect your unique love story.',
      'points': '7+ years of experience|Professional certified team|Customised packages available',
    };
  }

  Widget _buildGetInTouch() {
    // Nomor & email berdasarkan vendor
    final phone = _inferPhone(widget.vendor.name);
    final email = _inferEmail(widget.vendor.name);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Get In Touch', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingKonsultasiPage(vendorName: widget.vendor.name),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPink,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
              ),
              child: const Text('Booking Sekarang',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            ),
          ),
        ),
        const SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  HubungiVendorSheet.show(
                    context,
                    phone: phone,
                    email: email,
                    vendorName: widget.vendor.name,
                  );
                },
                icon: const Icon(Icons.call_outlined, size: 16, color: Colors.black54),
                label: const Text('Call', style: TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w500)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  HubungiVendorSheet.show(
                    context,
                    phone: phone,
                    email: email,
                    vendorName: widget.vendor.name,
                  );
                },
                icon: const Icon(Icons.chat_outlined, size: 16, color: Colors.black54),
                label: const Text('Chat', style: TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w500)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(child: Text(_inferAddress(widget.vendor.name),
                    style: const TextStyle(fontSize: 12, color: Colors.grey))),
              ]),
              const SizedBox(height: 6),
              const Row(children: [
                Icon(Icons.access_time, size: 14, color: Colors.grey),
                SizedBox(width: 6),
                Text('Open: Mon – Sun  9:00 AM – 7:00 PM',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  String _inferPhone(String name) {
    final l = name.toLowerCase();
    if (l.contains('sakura')) return '+62 811 2233 4455';
    if (l.contains('bella')) return '+62 821 5566 7788';
    return '+62 812 9876 5432';
  }

  String _inferEmail(String name) {
    final l = name.toLowerCase();
    if (l.contains('sakura')) return 'hello@sakuraevent.com';
    if (l.contains('bella')) return 'info@bellamoments.com';
    return 'contact@arjunawedding.com';
  }

  String _inferAddress(String name) {
    final l = name.toLowerCase();
    if (l.contains('sakura')) return 'Jl. Dirgja No. 36, Bandung, Jawa Barat';
    if (l.contains('bella')) return 'Jl. Sudirman Kav. 52, Jakarta Selatan';
    return 'Jl. Ahmad Yani No. 221, Cilacap Street';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -25),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25),
                        _buildVendorInfo(),
                        _buildStats(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(height: 1, color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
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
                          child: Text('About Us', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
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