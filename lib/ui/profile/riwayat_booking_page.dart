import 'package:flutter/material.dart';
import 'profile_page.dart' show ProfileAvatar;
import 'detail_booking_page.dart';

class RiwayatBookingPage extends StatelessWidget {
  final String? photoPath;
  final String initials;

  const RiwayatBookingPage({
    super.key,
    this.photoPath,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    // Data dummy booking ini, nanti ganti dengan data dari API 
    final bookings = [
      {
        'kategori': 'Dream Decoration',
        'vendorName': 'Love wedding',
        'tanggal': '15 Oktober 2025',
        'lokasi': 'Jakarta',
        'status': 'Selesai',
        'catatan': 'Paket dekorasi penuh',
        'imageUrl': '',
      },
      {
        'kategori': 'Photography',
        'vendorName': 'Moments Photography',
        'tanggal': '20 November 2025',
        'lokasi': 'Bali',
        'status': 'Selesai',
        'catatan': 'Paket foto pre-wedding',
        'imageUrl': '',
      },
      {
        'kategori': 'Make Up',
        'vendorName': 'Elegant makeup studio',
        'tanggal': '20 November 2025',
        'lokasi': 'Surabaya',
        'status': 'Selesai',
        'catatan': 'Paket makeup pengantin',
        'imageUrl': '',
      },
    ];

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
          'Detail Booking',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: photoPath != null && photoPath!.isNotEmpty
                  ? Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ProfileAvatar(
                          photoPath: photoPath,
                          initials: initials,
                          size: 80,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE53935),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 13,
                            ),
                          ),
                        ),
                      ],
                    )
                  : ProfileAvatar(
                      photoPath: null,
                      initials: initials,
                      size: 80,
                    ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Riwayat Booking',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),

            const SizedBox(height: 16),

  
            ...bookings.map((booking) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _BookingCard(
                  kategori: booking['kategori']!,
                  vendorName: booking['vendorName']!,
                  onDetailTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailBookingPage(
                          vendorName: booking['vendorName']!,
                          vendorKategori: booking['kategori']!,
                          imageUrl: booking['imageUrl']!,
                          tanggal: booking['tanggal']!,
                          lokasi: booking['lokasi']!,
                          status: booking['status']!,
                          catatan: booking['catatan']!,
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final String kategori;
  final String vendorName;
  final VoidCallback onDetailTap;

  const _BookingCard({
    required this.kategori,
    required this.vendorName,
    required this.onDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kategori,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            vendorName,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF888888),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onDetailTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4D8D),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Detail',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}