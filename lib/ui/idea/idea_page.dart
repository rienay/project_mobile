import 'package:flutter/material.dart';
import 'idea_detail_page.dart';

class IdeaPage extends StatelessWidget {
  const IdeaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ideas = [
      {
        'title': 'Ambient Accent Lighting',
        'image': 'assets/images/lighting.png',
        'description':
            'Menciptakan suasana yang hangat dan romantis dengan pencahayaan ambient.',
        'whyItMatters': [
          'Creates Atmosphere: Smart LED strips, programmable bulbs, and projection mapping let you customize your decor in real time—from a bright, welcoming glow during the ceremony to a softer, romantic ambiance for the reception.',
          'Enhances Architectural Features: Uplighting to highlight the natural textures of your venue—be it rustic barn beams or sleek modern walls—adding depth and drama to your overall look.',
        ],
        'howToIncorporate': [
          'LED & Smart Bulbs: Install LED strips along the rafters and around the dance floor. Choose smart bulbs that you can control via an app to shift colors and intensities throughout the day.',
          'Projection Mapping: Consider projecting dynamic visuals or a personalized slideshow on a blank barn wall or ceiling. This cutting-edge approach creates an unforgettable visual experience.',
          'Modern Chandeliers: Replace traditional lanterns with minimalist chandeliers or pendant lights made of brushed metal or acrylic. Their clean lines offer a striking contrast to rustic elements.',
        ],
        'conclusion':
            'With innovative lighting solutions, you can make your venue feel both contemporary and magical—setting the perfect tone for your big day.',
      },
      {
        'title': 'Apa Tema Pesta Pernikahan Impian Kamu? Ini Inspirasinya',
        'image': 'assets/images/tema_pernikahan.png',
        'description': 'Temukan tema pernikahan yang sesuai dengan gaya dan kepribadian Anda.',
        'whyItMatters': [
          'Reflects Your Style: Pilih tema yang mencerminkan kepribadian dan cinta kasih Anda sebagai pasangan.',
          'Creates Cohesive Experience: Tema yang konsisten membuat setiap detail acara menjadi berkesan dan terkoordinasi dengan baik.',
        ],
        'howToIncorporate': [
          'Konsultasi dengan Wedding Planner: Diskusikan tema pilihan Anda dan bagaimana mengimplementasikannya di setiap aspek acara.',
          'Pilih Palet Warna: Tentukan warna utama dan pelengkap yang sesuai dengan tema Anda.',
          'Detail Dekorasi: Dari undangan hingga centerpiece, pastikan setiap detail selaras dengan tema.',
        ],
        'conclusion':
            'Tema yang tepat akan membuat hari istimewa Anda sempurna dan tak terlupakan.',
      },
      {
        'title': 'Rekomendasi Terbaik untuk Wedding Organizer dan Venue Pernikahan',
        'image': 'assets/images/venue_organizer.png',
        'description': 'Pilihan terbaik untuk membuat hari spesial Anda sempurna.',
        'whyItMatters': [
          'Professional Coordination: Wedding organizer yang berpengalaman memastikan setiap detail direncanakan dan dieksekusi dengan sempurna.',
          'Venue Selection: Lokasi yang tepat menjadi fondasi kesuksesan pernikahan Anda.',
        ],
        'howToIncorporate': [
          'Research & References: Cari rekomendasi dari teman dan keluarga, atau lihat portofolio di media sosial.',
          'Konsultasi Awal: Bicarakan visi Anda dan pastikan mereka memahami dan dapat mewujudkannya.',
          'Budget Planning: Tentukan budget dan diskusikan dengan organizer untuk mendapatkan paket terbaik.',
        ],
        'conclusion':
            'Dengan tim profesional yang tepat, pernikahan impian Anda akan menjadi kenyataan yang indah.',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ide & Inspirasi',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Dapatkan inspirasi untuk pernikahan impianmu',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final idea = ideas[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: IdeaCard(
                        title: idea['title'] as String,
                        image: idea['image'] as String,
                        description: idea['description'] as String,
                        whyItMatters:
                            (idea['whyItMatters'] as List).cast<String>(),
                        howToIncorporate:
                            (idea['howToIncorporate'] as List).cast<String>(),
                        conclusion: idea['conclusion'] as String,
                      ),
                    );
                  },
                  childCount: ideas.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}

class IdeaCard extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final List<String> whyItMatters;
  final List<String> howToIncorporate;
  final String conclusion;

  const IdeaCard({
    Key? key,
    required this.title,
    required this.image,
    required this.description,
    required this.whyItMatters,
    required this.howToIncorporate,
    required this.conclusion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IdeaDetailPage(
                              title: title,
                              image: image,
                              whyItMattersPoints: whyItMatters,
                              howToIncorporatePoints: howToIncorporate,
                              conclusion: conclusion,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'View',
                        style: TextStyle(
                          color: Color(0xFFFF4081),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
