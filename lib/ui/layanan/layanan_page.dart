import 'package:flutter/material.dart';
import 'package:project_mobile/helpers/api_helper.dart';
import 'package:project_mobile/ui/layanan/layanan_detail_page.dart';

class LayananPage extends StatefulWidget {
  const LayananPage({Key? key}) : super(key: key);

  @override
  State<LayananPage> createState() => _LayananPageState();
}

class _LayananPageState extends State<LayananPage> {
  bool isLoading = true;
  List<dynamic> layananList = [];

  @override
  void initState() {
    super.initState();
    _fetchLayanan();
  }

  Future<void> _fetchLayanan() async {
    try {
      final data = await ApiHelper.getLayanan();
      setState(() {
        layananList = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Gagal mengambil data layanan: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  String _formatCurrency(dynamic priceVal) {
    if (priceVal == null) return 'IDR 0';
    final value = double.tryParse(priceVal.toString()) ?? 0.0;
    String res = value.toStringAsFixed(0);
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    res = res.replaceAllMapped(reg, (Match m) => '${m[1]}.');
    return 'IDR $res';
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPink = Color(0xFFF43F8B);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryPink),
                ),
              )
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Layanan & Paket',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Temukan paket pernikahan terbaik untuk hari spesialmu',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: layananList.isEmpty
                        ? const SliverToBoxAdapter(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 80.0),
                                child: Text(
                                  'Tidak ada layanan tersedia saat ini.',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final item = layananList[index];
                                final name = item['nama'] ?? '';
                                final desc = item['deskripsi'] ?? '';
                                final category = item['awalan'] ?? 'Paket Pernikahan';
                                final price = _formatCurrency(item['harga']);
                                final gambar = item['gambar'] ?? '';
                                
                                final imageUrl = ApiHelper.formatLayananImageUrl(gambar);

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LayananDetailPage(layanan: item),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 24),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.04),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        // Image section with a badge
                                        Stack(
                                          children: [
                                            SizedBox(
                                              height: 180,
                                              width: double.infinity,
                                              child: imageUrl.isNotEmpty
                                                  ? Image.network(
                                                      imageUrl,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context, error, stackTrace) {
                                                        return Container(
                                                          color: Colors.grey.shade200,
                                                          child: const Icon(
                                                            Icons.broken_image,
                                                            color: Colors.grey,
                                                            size: 40,
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : Container(
                                                      color: Colors.grey.shade200,
                                                      child: const Icon(
                                                        Icons.favorite_outline,
                                                        color: Colors.grey,
                                                        size: 40,
                                                      ),
                                                    ),
                                            ),
                                            Positioned(
                                              top: 16,
                                              left: 16,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                decoration: BoxDecoration(
                                                  color: primaryPink.withOpacity(0.9),
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  category,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Text Details
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      name,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color(0xFF1E1E1E),
                                                        letterSpacing: -0.2,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    price,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: primaryPink,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                              Text(
                                                desc,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey.shade600,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ),
                                );
                              },
                              childCount: layananList.length,
                            ),
                          ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 30)),
                ],
              ),
      ),
    );
  }
}
