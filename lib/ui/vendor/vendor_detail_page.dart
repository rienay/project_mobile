import 'package:flutter/material.dart';
import '../../model/vendor_model.dart';
import '../../helpers/api_helper.dart';
import 'booking_konsultasi_page.dart';
import 'hubungi_vendor_sheet.dart';

class VendorDetailPage extends StatefulWidget {
  final Vendor vendor;

  const VendorDetailPage({super.key, required this.vendor});

  @override
  State<VendorDetailPage> createState() => _VendorDetailPageState();
}

class _VendorDetailPageState extends State<VendorDetailPage> {
  static const Color primaryPink = Color(0xFFFF4D6D);
  static const Color bgColor = Color(0xFFFFF6F8);

  List<dynamic> additionalPackages = [];
  bool isLoadingPackages = true;

  @override
  void initState() {
    super.initState();
    _fetchAdditionalPackages();
  }

  Future<void> _fetchAdditionalPackages() async {
    try {
      final data = await ApiHelper.getPaketVendor();
      final List<dynamic> filtered = data.where((p) {
        final pVendorId = p['vendor_id']?.toString() ?? '';
        return pVendorId == widget.vendor.id;
      }).toList();

      setState(() {
        additionalPackages = filtered;
        isLoadingPackages = false;
      });
    } catch (e) {
      debugPrint("Gagal mengambil paket tambahan: $e");
      setState(() {
        isLoadingPackages = false;
      });
    }
  }

  Widget _buildStars(double rating, {double size = 16, Color color = primaryPink}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < rating.floor()) {
          return Icon(Icons.star_rounded, size: size, color: color);
        }
        if (i < rating && rating - i >= 0.5) {
          return Icon(Icons.star_half_rounded, size: size, color: color);
        }
        return Icon(Icons.star_border_rounded, size: size, color: color);
      }),
    );
  }

  String _formatCurrency(String priceStr) {
    final value = double.tryParse(priceStr) ?? 0.0;
    String res = value.toStringAsFixed(0);
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    res = res.replaceAllMapped(reg, (Match m) => '${m[1]}.');
    return 'Rp $res';
  }

  Widget _sectionTitle(String title, {String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (subtitle != null) ...[
            Text(
              subtitle.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
                color: Color(0xFFF48C96),
              ),
            ),
            const SizedBox(height: 6),
          ],
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 32,
            height: 3,
            decoration: BoxDecoration(
              color: primaryPink,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    final tags = _inferTags(widget.vendor.name);
    final priceStr = _formatCurrency(widget.vendor.price);
    final address = widget.vendor.location.isNotEmpty ? widget.vendor.location : _inferAddress(widget.vendor.name);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side: Square Photo with rounded corners, dark border and ribbon badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF1E1E1E), width: 2.5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: widget.vendor.mainImage.startsWith('http')
                      ? Image.network(
                          widget.vendor.mainImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade200, child: const Icon(Icons.broken_image, color: Colors.grey)),
                        )
                      : Image.asset(
                          widget.vendor.mainImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade200, child: const Icon(Icons.broken_image, color: Colors.grey)),
                        ),
                ),
              ),
              Positioned(
                bottom: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: primaryPink,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.workspace_premium_rounded,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Right side: Info column next to photo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Vendor Name
                Text(
                  widget.vendor.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E1E1E),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),

                // 1. Lokasi
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        address,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF4B5563),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // 2. Pricing
                Row(
                  children: [
                    const Icon(Icons.sell_outlined, size: 14, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      'Mulai $priceStr',
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFFD90429),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // 3. Client Reviews (Yellow/Amber Stars)
                Row(
                  children: [
                    _buildStars(widget.vendor.rating, size: 14, color: const Color(0xFFFCD34D)),
                    const SizedBox(width: 6),
                    Text(
                      '${widget.vendor.rating} • ${widget.vendor.reviews} reviews',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                  ],
                ),

                // 4. Catatan
                if (widget.vendor.notesText.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Icon(Icons.info_outline_rounded, size: 14, color: Colors.grey),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          widget.vendor.notesText,
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: Color(0xFF4B5563),
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 10),

                // Category Tags (Plain text labels, space-separated)
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  children: tags.map((t) => Text(
                    t,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF1E1E1E),
                      fontWeight: FontWeight.w600,
                    ),
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
    if (l.contains('sakura')) {
      return ['Japanese Style', 'Minimalis'];
    }
    if (l.contains('bella')) {
      return ['Luxury Events', 'Modern Style'];
    }
    if (l.contains('arjuna')) {
      return ['Wedding Planner', 'Pre-Wedding'];
    }
    return ['Wedding', 'Events'];
  }

  Widget _buildStats() {
    final stats = _inferStats(widget.vendor.name);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          )
        ],
        border: Border.all(color: primaryPink.withValues(alpha: 0.05), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: stats.entries.map((e) => Expanded(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primaryPink.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(e.value['icon'] as IconData, size: 20, color: primaryPink),
            ),
            const SizedBox(height: 10),
            Text(e.value['value'] as String,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E1E1E))),
            const SizedBox(height: 2),
            Text(e.key.toUpperCase(), style: TextStyle(fontSize: 10, color: Colors.grey.shade500, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
          ]),
        )).toList(),
      ),
    );
  }

  Map<String, Map<String, dynamic>> _inferStats(String name) {
    final l = name.toLowerCase();
    if (l.contains('sakura')) {
      return {
        'Events': {'icon': Icons.calendar_today_outlined, 'value': '600+'},
        'Clients': {'icon': Icons.people_outline, 'value': '1.8K'},
        'Awards': {'icon': Icons.emoji_events_outlined, 'value': '18+'},
      };
    }
    if (l.contains('bella')) {
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

  Widget _buildPortfolio() {
    final List<String> rawPortfolio = widget.vendor.portfolioImages.isNotEmpty
        ? widget.vendor.portfolioImages
        : [widget.vendor.mainImage];
    final List<String> uniquePortfolio = rawPortfolio.where((img) => img.isNotEmpty).toSet().toList();

    if (uniquePortfolio.isEmpty) {
      return const SizedBox.shrink();
    }

    final bool isSingle = uniquePortfolio.length <= 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Our Portfolio', subtitle: 'GALLERY'),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: isSingle
              ? Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _pImg(uniquePortfolio[0], height: 200, fullWidth: true),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.55),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.vendor.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Featured work and project gallery',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    Row(children: [
                      Expanded(flex: 2, child: _pImg(uniquePortfolio[0], height: 160)),
                      const SizedBox(width: 8),
                      Expanded(child: Column(children: [
                        _pImg(uniquePortfolio.length > 1 ? uniquePortfolio[1] : uniquePortfolio[0], height: 76),
                        const SizedBox(height: 8),
                        _pImg(uniquePortfolio.length > 2 ? uniquePortfolio[2] : uniquePortfolio[0], height: 76),
                      ])),
                    ]),
                    if (uniquePortfolio.length > 3) ...[
                      const SizedBox(height: 8),
                      Row(children: [
                        Expanded(child: _pImg(uniquePortfolio[3], height: 110)),
                        if (uniquePortfolio.length > 4) ...[
                          const SizedBox(width: 8),
                          Expanded(child: _pImg(uniquePortfolio[4], height: 110)),
                        ],
                      ]),
                    ],
                    if (uniquePortfolio.length > 5) ...[
                      const SizedBox(height: 8),
                      _pImg(uniquePortfolio[5], height: 120, fullWidth: true),
                    ],
                  ],
                ),
        ),
      ],
    );
  }

  Widget _pImg(String path, {required double height, bool fullWidth = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: fullWidth ? double.infinity : null,
        height: height,
        child: path.startsWith('http')
            ? Image.network(path, fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: height, color: Colors.grey.shade200,
                  child: const Icon(Icons.image, color: Colors.grey)))
            : Image.asset(path, fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: height, color: Colors.grey.shade200,
                  child: const Icon(Icons.image, color: Colors.grey))),
      ),
    );
  }

  Widget _buildServices() {
    final String text = widget.vendor.servicesText.trim();
    if (text.isEmpty) {
      return const SizedBox.shrink();
    }

    List<String> dbServices = text
        .split(RegExp(r'[\r\n]+'))
        .map((s) => s.replaceAll(RegExp(r'^[•\-\*\s]+'), '').trim())
        .where((s) => s.isNotEmpty)
        .toList();

    if (dbServices.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Layanan Kami', subtitle: 'OUR SERVICES'),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 20, offset: const Offset(0, 4))],
            ),
            child: Column(
              children: dbServices.map((service) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle_rounded, color: primaryPink, size: 18),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          service,
                          style: const TextStyle(fontSize: 13.5, color: Color(0xFF4A4A4A), height: 1.45),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutUs() {
    List<String> reasons = widget.vendor.reasonsText
        .split(RegExp(r'[\r\n]+'))
        .map((s) => s.replaceAll(RegExp(r'^[•\-\*\s]+'), '').trim())
        .where((s) => s.isNotEmpty)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Tentang Vendor', subtitle: 'ABOUT US'),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 20, offset: const Offset(0, 4))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Experience Badge / Tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: primaryPink.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.vendor.experience.isNotEmpty
                        ? widget.vendor.experience
                        : 'Lebih dari 5 Tahun Pengalaman',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryPink,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                // Description
                Text(
                  widget.vendor.description.isNotEmpty
                      ? widget.vendor.description
                      : 'Deskripsi vendor tidak tersedia.',
                  style: const TextStyle(fontSize: 13.5, color: Color(0xFF4A4A4A), height: 1.5),
                ),
                if (reasons.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  const Text('Kenapa Memilih Kami:', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13.5, color: Color(0xFF1E1E1E))),
                  const SizedBox(height: 12),
                  ...reasons.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(color: primaryPink, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(p, style: const TextStyle(fontSize: 13, color: Color(0xFF4A4A4A), height: 1.4))),
                      ],
                    ),
                  )),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalPackages() {
    if (isLoadingPackages) {
      return const Center(child: CircularProgressIndicator(color: primaryPink));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Paket Tambahan', subtitle: 'OPSIONAL'),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: additionalPackages.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Text(
                    'Vendor ini belum menambahkan paket layanan tambahan.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: additionalPackages.length,
                  itemBuilder: (context, index) {
                    final item = additionalPackages[index];
                    final name = item['nama_paket'] ?? '';
                    final hargaVal = item['harga']?.toString() ?? '0';
                    final price = _formatCurrency(hargaVal);

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: primaryPink.withValues(alpha: 0.15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E1E1E),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '+ $price',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: primaryPink,
                            ),
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

  String _inferPhone(String name) {
    final l = name.toLowerCase();
    if (l.contains('sakura')) {
      return '+62 811 2233 4455';
    }
    if (l.contains('bella')) {
      return '+62 821 5566 7788';
    }
    return '+62 812 9876 5432';
  }

  String _inferEmail(String name) {
    final l = name.toLowerCase();
    if (l.contains('sakura')) {
      return 'hello@sakuraevent.com';
    }
    if (l.contains('bella')) {
      return 'info@bellamoments.com';
    }
    return 'contact@arjunawedding.com';
  }

  String _inferAddress(String name) {
    final l = name.toLowerCase();
    if (l.contains('sakura')) {
      return 'Jl. Dirgantara No. 36, Bandung, Jawa Barat';
    }
    if (l.contains('bella')) {
      return 'Jl. Jenderal Sudirman Kav. 52, SCBD, Jakarta Selatan';
    }
    return 'Jl. Ahmad Yani No. 221, Cilacap, Jawa Tengah';
  }

  Widget _buildBottomActionBar() {
    final price = _formatCurrency(widget.vendor.price);
    final phone = widget.vendor.phone.isNotEmpty ? widget.vendor.phone : _inferPhone(widget.vendor.name);
    final email = _inferEmail(widget.vendor.name);

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).padding.bottom + 12,
        top: 12
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'INVESTASI MULAI',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFD90429),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {
              HubungiVendorSheet.show(
                context,
                phone: phone,
                email: email,
                vendorName: widget.vendor.name,
              );
            },
            icon: const Icon(Icons.chat_outlined, color: primaryPink),
            style: IconButton.styleFrom(
              backgroundColor: primaryPink.withValues(alpha: 0.08),
              padding: const EdgeInsets.all(14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 48,
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
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Booking',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: _buildBottomActionBar(),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // 1. Banner Image (SizedBox 280)
                    SizedBox(
                      height: 280,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          widget.vendor.mainImage.startsWith('http')
                              ? Image.network(
                                  widget.vendor.mainImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade300),
                                )
                              : Image.asset(
                                  widget.vendor.mainImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade300),
                                ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.05),
                                  Colors.black.withValues(alpha: 0.6),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 2. Overlapping Content Container placed below banner with Stack padding logic
                    Padding(
                      padding: const EdgeInsets.only(top: 240),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeaderCard(),
                              _buildStats(),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Divider(height: 1, color: Color(0xFFFFD1DC)),
                              ),
                              const SizedBox(height: 24),
                              _buildAboutUs(), // Deskripsi & Pengalaman
                              const SizedBox(height: 28),
                              _buildServices(), // Layanan
                              const SizedBox(height: 28),
                              _buildPortfolio(), // Portofolio
                              const SizedBox(height: 28),
                              _buildAdditionalPackages(), // Paket Tambahan d bawah sendiri
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Pinned Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white.withValues(alpha: 0.9),
              child: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Colors.black87, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}