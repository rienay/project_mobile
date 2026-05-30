import 'package:flutter/material.dart';

class InvoicePage extends StatelessWidget {
  final String mempelaiWanita;
  final String mempelaiPria;
  final String tanggalPernikahan;
  final String jumlahTamu;
  final String lokasi;
  final String paket;
  final String hargaPaket;
  final String metodePembayaran;

  const InvoicePage({
    super.key,
    required this.mempelaiWanita,
    required this.mempelaiPria,
    required this.tanggalPernikahan,
    required this.jumlahTamu,
    required this.lokasi,
    required this.paket,
    required this.hargaPaket,
    required this.metodePembayaran,
  });

  static const Color primaryPink = Color(0xFFF43F8B);

  String get _nomorBooking {
    return '#WP${DateTime.now().millisecondsSinceEpoch % 100000}';
  }

  String get _tanggalInvoice {
    final now = DateTime.now();
    return '${now.day}/${now.month}/${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: primaryPink,
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 28),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close,
                          color: Colors.white, size: 22),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.description_outlined,
                      color: Colors.white, size: 32),
                ),
                const SizedBox(height: 10),
                const Text('INVOICE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2)),
                const SizedBox(height: 4),
                const Text('Wedding Planner Services',
                    style:
                        TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nomor Booking',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade500)),
                          const SizedBox(height: 4),
                          Text(_nomorBooking,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Tanggal',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade500)),
                          const SizedBox(height: 4),
                          Text(_tanggalInvoice,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 28, color: Color(0xFFEEEEEE)),
                  _sectionTitle('Data Pengantin'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _invoiceRow(
                            'Mempelai Wanita:', mempelaiWanita),
                        const SizedBox(height: 8),
                        _invoiceRow('Mempelai Pria:', mempelaiPria),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _sectionTitle('Detail Acara'),
                  const SizedBox(height: 10),
                  _detailItem('Tanggal Pernikahan:', tanggalPernikahan),
                  _detailItem('Jumlah Tamu', ': $jumlahTamu'),
                  _detailItem('Lokasi', ': $lokasi'),
                  const SizedBox(height: 20),
                  _sectionTitle('Paket & Layanan'),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$paket - Rp $hargaPaket',
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _sectionTitle('Informasi Pembayaran'),
                  const SizedBox(height: 10),
                  _detailItem('Metode:', metodePembayaran),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryPink));
  }

  Widget _invoiceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87)),
      ],
    );
  }

  Widget _detailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 12, color: Colors.grey)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}