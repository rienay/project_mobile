import 'package:flutter/material.dart';
import 'vendor_detail_page.dart';

class VendorFavoritPage extends StatefulWidget {
  const VendorFavoritPage({super.key});

  @override
  State<VendorFavoritPage> createState() => _VendorFavoritPageState();
}

class _VendorFavoritPageState extends State<VendorFavoritPage> {
  final List<Map<String, dynamic>> _vendors = [
    {
      'name': 'Arthana',
      'category': 'Wedding Planner & Organizer',
      'imageUrl': '',
      'description':
          'Arthana Wedding Organizer berpengalaman lebih dari 10 tahun '
          'dalam menangani berbagai konsep pernikahan di seluruh Indonesia.',
      'rating': 4.9,
      'totalReview': 128,
      'location': 'Jakarta Selatan',
      'price': 'Mulai Rp 15.000.000',
      'liked': false,
    },
    {
      'name': 'Haris',
      'category': 'Wedding Planner & Organizer',
      'imageUrl': '',
      'description':
          'Haris WO menyediakan layanan lengkap dari dekorasi hingga '
          'koordinasi hari H dengan tim profesional.',
      'rating': 4.7,
      'totalReview': 85,
      'location': 'Bandung',
      'price': 'Mulai Rp 10.000.000',
      'liked': false,
    },
    {
      'name': 'GatotKaca',
      'category': 'Wedding Planner & Organizer',
      'imageUrl': '',
      'description':
          'GatotKaca WO menghadirkan pengalaman pernikahan berkesan '
          'dengan sentuhan tradisional Jawa yang elegan.',
      'rating': 4.8,
      'totalReview': 102,
      'location': 'Yogyakarta',
      'price': 'Mulai Rp 12.000.000',
      'liked': false,
    },
  ];

  void _toggleLike(int index) {
    setState(() {
      _vendors[index]['liked'] = !_vendors[index]['liked'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 48,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF1A1A1A), size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Vendor Favorit',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _vendors.isEmpty
          ? const _EmptyState()
          : ListView.separated(
              itemCount: _vendors.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
              itemBuilder: (context, index) {
                final v = _vendors[index];
                return _VendorRow(
                  name: v['name'],
                  category: v['category'],
                  imageUrl: v['imageUrl'],
                  liked: v['liked'],
                  onLikeTap: () => _toggleLike(index),
                  onViewTap: () {
      
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VendorDetailPage(
                          name: v['name'],
                          category: v['category'],
                          imageUrl: v['imageUrl'],
                          description: v['description'],
                          rating: v['rating'],
                          totalReview: v['totalReview'],
                          location: v['location'],
                          price: v['price'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class _VendorRow extends StatelessWidget {
  final String name;
  final String category;
  final String imageUrl;
  final bool liked;
  final VoidCallback onLikeTap;
  final VoidCallback onViewTap;

  const _VendorRow({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.liked,
    required this.onLikeTap,
    required this.onViewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFFF4D8D), width: 1.5),
              color: const Color(0xFFF5F5F5),
            ),
            child: ClipOval(
              child: imageUrl.isNotEmpty
                  ? Image.network(imageUrl, fit: BoxFit.cover)
                  : const Icon(Icons.store, color: Color(0xFFBBBBBB), size: 30),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF888888),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: onLikeTap,
                  child: Icon(
                    liked ? Icons.favorite : Icons.favorite_border,
                    color: liked
                        ? const Color(0xFFFF4D8D)
                        : const Color(0xFFBBBBBB),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: onViewTap,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Text(
                'View',
                style: TextStyle(
                  color: Color(0xFFFF4D8D),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 64, color: Color(0xFFDDDDDD)),
          SizedBox(height: 16),
          Text(
            'Belum ada vendor favorit',
            style: TextStyle(fontSize: 15, color: Color(0xFF888888)),
          ),
          SizedBox(height: 8),
          Text(
            'Tambahkan vendor ke favorit\ndari halaman Vendor',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Color(0xFFBBBBBB)),
          ),
        ],
      ),
    );
  }
}