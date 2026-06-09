import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LayananDetailPage extends StatelessWidget {
  final Map<String, dynamic> layanan;

  const LayananDetailPage({
    super.key,
    required this.layanan,
  });

  String _formatCurrency(dynamic priceVal) {
    if (priceVal == null) return 'Rp 0';
    final value = double.tryParse(priceVal.toString()) ?? 0.0;
    String res = value.toStringAsFixed(0);
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    res = res.replaceAllMapped(reg, (Match m) => '${m[1]}.');
    return 'Rp $res';
  }

  Future<void> _launchWhatsApp(BuildContext context, String name, String priceStr) async {
    final message = "Halo, saya tertarik dengan layanan:\n\n"
        "• $name\n"
        "• Harga mulai $priceStr\n\n"
        "Mohon info lebih lanjut. Terima kasih.";
    
    final uri = Uri.parse("https://wa.me/6281234567890?text=${Uri.encodeComponent(message)}");
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $uri';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal membuka WhatsApp: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPink = Color(0xFFFF4D6D);
    const Color bgPink = Color(0xFFFFF6F8);

    final String name = layanan['nama'] ?? '';
    final String desc = layanan['deskripsi'] ?? '';
    final String awalan = layanan['awalan'] ?? '';
    final String priceStr = _formatCurrency(layanan['harga']);
    final String gambar = layanan['gambar'] ?? '';

    final imageUrl = gambar.isNotEmpty
        ? (gambar.startsWith('http')
            ? gambar
            : 'http://10.78.162.176/ci/lovewedding/public/uploads/layanan/$gambar')
        : '';

    // Split description by newlines to match the foreach explode view in CI4
    final List<String> points = desc
        .split('\n')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    return Scaffold(
      backgroundColor: bgPink,
      body: CustomScrollView(
        slivers: [
          // 1. Image Header using SliverAppBar
          SliverAppBar(
            backgroundColor: bgPink,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.white.withValues(alpha: 0.9),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.black87, size: 16),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade300),
                        )
                      : Container(color: Colors.grey.shade200),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.05),
                          Colors.black.withValues(alpha: 0.55),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // 2. Services Content Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label "EXCLUSIVE SERVICE"
                  const Text(
                    'EXCLUSIVE SERVICE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3.0,
                      color: Color(0xFFF48C96),
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Service Title
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF1E1E1E),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Accent line matching the my-6 height-[2px] bg-pink-400
                  Container(
                    width: 48,
                    height: 2.5,
                    color: const Color(0xFFF48C96),
                  ),
                  const SizedBox(height: 24),
                  
                  // Keunggulan Paket white Card Box
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'KEUNGGULAN PAKET',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 14),
                        
                        // Awalan subtitle if not empty
                        if (awalan.isNotEmpty) ...[
                          Text(
                            awalan,
                            style: const TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        
                        // Description Points
                        ...points.map((point) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '✓ ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: primaryPink,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    point,
                                    style: const TextStyle(
                                      fontSize: 13.5,
                                      color: Color(0xFF4A4A4A),
                                      height: 1.45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        
                        const SizedBox(height: 20),
                        
                        // Investasi inner box
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEEF2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'INVESTASI',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  color: primaryPink,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                priceStr,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFFD90429),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '*Harga dapat disesuaikan kebutuhan',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Buttons Row: Kembali & Hubungi WhatsApp
                  Row(
                    children: [
                      // Kembali Button
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          height: 52,
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back, size: 14, color: primaryPink),
                            label: const Text(
                              'KEMBALI',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                                color: primaryPink,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: Color(0xFFFFD1DC)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // WhatsApp Button
                      Expanded(
                        flex: 6,
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton.icon(
                            onPressed: () => _launchWhatsApp(context, name, priceStr),
                            icon: const Icon(Icons.chat, size: 16, color: Colors.white),
                            label: const Text(
                              'WHATSAPP',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF25D366),
                              elevation: 2,
                              shadowColor: const Color(0xFF25D366).withValues(alpha: 0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
