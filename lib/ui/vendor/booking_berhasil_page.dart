import 'package:flutter/material.dart';
import 'pembayaran_page.dart';

class BookingBerhasilPage extends StatelessWidget {
  final String namaLengkap;
  final String tanggalPernikahan;
  final String vendorDipilih;

  const BookingBerhasilPage({
    super.key,
    required this.namaLengkap,
    required this.tanggalPernikahan,
    required this.vendorDipilih,
  });

  static const Color primaryPink = Color(0xFFF43F8B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryPink, width: 2.5),
                ),
                child: const Icon(Icons.check, color: primaryPink, size: 34),
              ),
              const SizedBox(height: 20),
              const Text(
                'Booking Berhasil!',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 14),
              Text(
                'Permintaan konsultasi\nAnda telah berhasil dikirim.\nTim kami akan segera\nmenghubungi Anda untuk\nkonfirmasi selanjutnya.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.6),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detail Booking Anda',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 16),
                    _detailRow('Nama Lengkap', namaLengkap),
                    const Divider(height: 24, color: Color(0xFFF0F0F0)),
                    _detailRow('Tanggal Pernikahan', tanggalPernikahan),
                    const Divider(height: 24, color: Color(0xFFF0F0F0)),
                    _detailRow('Vendor yang\ndipilih', vendorDipilih),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PembayaranPage(
                          namaLengkap: namaLengkap,
                          vendorDipilih: vendorDipilih,
                          tanggalPernikahan: tanggalPernikahan,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Bayar Sekarang',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
        ),
      ],
    );
  }
}