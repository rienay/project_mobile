import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String vendorName;

  const ChatPage({super.key, required this.vendorName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _inputCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();

  final List<_ChatMessage> _messages = [
    _ChatMessage(
      text:
          'Halo! Saya sedang mencari dekorasi untuk acara pernikahan. '
          'Mohon info mengenai paket, tema yang tersedia, dan ketersediaan tanggal',
      isMe: true,
      time: '3:53 PM',
      isRead: true,
    ),
    _ChatMessage(
      text:
          'Halo! Terima kasih sudah menghubungi kami.\n'
          'Berikut pilihan paket dekorasi yang tersedia untuk acara pernikahan Anda:\n\n'
          '• Paket Akad – Mulai 3,5 juta\n'
          'Termasuk pelaminan simple/elegant, rangkaian bunga fresh/artificial, backdrop, '
          'meja-kursi akad, serta mini dekor area cincin.\n\n'
          '• Paket Resepsi – Mulai 7 juta\n'
          'Termasuk pelaminan utama, standing flower, jalan dekor, welcome signage, '
          'photobooth simple, serta dekor area tamu.\n\n'
          '• Paket Full Wedding – Mulai 12 juta\n'
          'Termasuk dekor akad + resepsi, pelaminan premium, backdrop foto, welcome area, '
          'dekor panggung, meja tamu lengkap, dan bouquet bride.\n\n'
          'Pilihan Tema: Rustic, Elegant, Modern, Glam, Minimalist, dan Adat (Jawa, Sunda, Minang).\n\n'
          'Tiap paket bisa dikustom sesuai warna favorit atau konsep pernikahan Anda.\n'
          'Silakan pilih paket yang ingin dilihat detail lengkapnya ya! 😊✨',
      isMe: false,
      time: '3:54 PM',
      isRead: false,
    ),
  ];

  void _sendMessage() {
    final text = _inputCtrl.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(
        text: text,
        isMe: true,
        time: _nowTime(),
        isRead: false,
      ));
    });
    _inputCtrl.clear();

    // scroll ke bawah setelah kirim
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _nowTime() {
    final now = DateTime.now();
    final h = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final m = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $period';
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111B21), // dark background WA
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F2C34),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 19,
              backgroundColor: const Color(0xFF3A3A3A),
              child: Text(
                widget.vendorName.isNotEmpty
                    ? widget.vendorName[0].toUpperCase()
                    : 'V',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.vendorName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              itemCount: _messages.length,
              itemBuilder: (_, index) => _BubbleWidget(msg: _messages[index]),
            ),
          ),

          Container(
            color: const Color(0xFF1F2C34),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A3942),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _inputCtrl,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Message',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.grey),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
                  onPressed: () {},
                ),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00A884),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.mic, color: Colors.white, size: 22),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  final bool isRead;

  const _ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    required this.isRead,
  });
}

class _BubbleWidget extends StatelessWidget {
  final _ChatMessage msg;

  const _BubbleWidget({required this.msg});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: msg.isMe
              ? const Color(0xFF005C4B) // hijau WA untuk pesan saya
              : const Color(0xFF1F2C34), // gelap untuk pesan masuk
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(msg.isMe ? 12 : 2),
            bottomRight: Radius.circular(msg.isMe ? 2 : 12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              msg.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  msg.time,
                  style: const TextStyle(
                    color: Color(0xFF8C9A96),
                    fontSize: 10,
                  ),
                ),
                if (msg.isMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.done_all,
                    size: 14,
                    color: msg.isRead
                        ? const Color(0xFF53BDEB) // biru = sudah dibaca
                        : const Color(0xFF8C9A96), // abu = belum
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}