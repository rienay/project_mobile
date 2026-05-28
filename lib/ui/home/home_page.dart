import 'package:flutter/material.dart';
import 'package:project_mobile/helpers/api_helper.dart';
import 'package:project_mobile/ui/auth/login_page.dart';
import 'package:project_mobile/ui/main_navigator.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wedding Planner Custom App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Plus Jakarta Sans',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE91E63)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Available wedding categories mapped dynamically
  final List<Map<String, dynamic>> categories = [
    {
      'id': '1',
      'title': 'Urban Loft',
      'image': 'assets/wedding_reference/Urban_Loft.png',
    },
    {
      'id': '2',
      'title': 'Tropikal',
      'image': 'assets/wedding_reference/Tropikal.png',
    },
    {
      'id': '3',
      'title': 'Blossom',
      'image': 'assets/wedding_reference/Blossom.png',
    },
    {
      'id': '4',
      'title': 'Beach',
      'image': 'assets/wedding_reference/Beach.png',
    },
    {
      'id': '5',
      'title': 'Bridal',
      'image': 'assets/wedding_reference/Bridal.png',
    },
    {
      'id': '6',
      'title': 'Minimalist',
      'image': 'assets/wedding_reference/Minimalist.png',
    },
    {
      'id': '7',
      'title': 'Javanese',
      'image': 'assets/wedding_reference/Javanese.png',
    },
    {
      'id': '8',
      'title': 'Balines',
      'image': 'assets/wedding_reference/Balines.png',
    },
  ];

  // Active category element ID
  String _selectedCategoryId = '3';

  // Trend Wedding list
  final List<Map<String, dynamic>> trendWeddings = [
    {
      'title': 'Garden Wedding',
      'description': 'konsep pernikahan di luar ruangan',
      'image': 'assets/trend_wedding/Garden_Wedding.png',
      'rating': 4.0,
    },
    {
      'title': 'Opulent Vintage',
      'description': 'Coba konsep mewah dan elegan',
      'image': 'assets/trend_wedding/Opulent_Vintage.png',
      'rating': 4.0,
    },
    {
      'title': 'Garden Romance',
      'description': 'Ditaman yang romantis',
      'image': 'assets/trend_wedding/Garden_Romance.png',
      'rating': 4.0,
    },
    {
      'title': 'Crystal Ballroom',
      'description': 'Mewah dan elegan',
      'image': 'assets/trend_wedding/Crystal_Ballroom.png',
      'rating': 4.0,
    },
    {
      'title': 'Garden Romance',
      'description': 'Romantis',
      'image': 'assets/trend_wedding/Garden_Romance2.png',
      'rating': 4.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Immersive Hero Carousel Header section
            _buildHeroHeader(context),
            
            const SizedBox(height: 24),
            
            // Wedding Reference Section Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Wedding Reference',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[900],
                  letterSpacing: -0.2,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Horizontal scrolling reference circles
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = _selectedCategoryId == cat['id'];
                  return _buildCategoryItem(
                    cat['title'], 
                    cat['image'], 
                    cat['id'], 
                    isSelected
                  );
                },
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Trend Wedding Heading
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Trend Wedding',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[900],
                  letterSpacing: -0.2,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Trend Wedding horizontal cards custom viewport
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: trendWeddings.length,
                itemBuilder: (context, index) {
                  final item = trendWeddings[index];
                  return _buildTrendCard(
                    context,
                    item['title'],
                    item['description'],
                    item['image'],
                    item['rating'],
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // Hero header with background image, custom opacity layers and premium layout titles
  Widget _buildHeroHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/hero.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Dark linear aesthetic overlay gradient
        Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFFE91E63).withOpacity(0.35), // Gradien pink lembut di atas
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.8),
              ],
            ),
          ),
        ),
        // Positioned custom typography texts
        Positioned(
          bottom: 24,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sambut perjalanan cintamu',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Playfair Display',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Biarkan kami menghias hari untuk hari spesialmu!',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Elegant circular reference element with customizable active index tracking
  Widget _buildCategoryItem(String title, String imageUrl, String id, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryId = id;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFFE91E63) : Colors.grey[300]!,
                  width: isSelected ? 2.5 : 1.0,
                ),
              ),
              padding: const EdgeInsets.all(3.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.favorite, color: Colors.grey, size: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? const Color(0xFFE91E63) : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Elegant Trend Wedding cards matching high fidelity custom parameters
  Widget _buildTrendCard(
    BuildContext context,
    String title,
    String description,
    String imageUrl,
    double rating,
  ) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Backdrop photo
            Positioned.fill(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // Bottom vignette layer
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.9),
                    ],
                    stops: const [0.3, 0.6, 1.0],
                  ),
                ),
              ),
            ),
            // Content labels
            Positioned(
              bottom: 16,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Rating Star Row Match
                  Row(
                    children: [
                      _buildStars(rating),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Row helper mapping high-fidelity ratings
  Widget _buildStars(double rating) {
    List<Widget> stars = [];
    int filledStars = rating.floor();
    for (int i = 0; i < 5; i++) {
      if (i < filledStars) {
        stars.add(const Icon(
          Icons.star,
          color: Colors.white,
          size: 14,
        ));
      } else {
        stars.add(Icon(
          Icons.star_border,
          color: Colors.white.withOpacity(0.7),
          size: 14,
        ));
      }
      if (i < 4) {
        stars.add(const SizedBox(width: 2));
      }
    }
    return Row(mainAxisSize: MainAxisSize.min, children: stars);
  }
}
