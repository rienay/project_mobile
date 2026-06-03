class User {
  final String firstName;
  final String lastName;
  final String email;
  final String? profilePhoto;
  final String country;
  final String phoneNumber;

  const User({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profilePhoto,
    required this.country,
    required this.phoneNumber,
  });

  String get fullName => '$firstName $lastName';

  String get initials {
    final firstInitial = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final lastInitial = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$firstInitial$lastInitial';
  }

  factory User.dummy() {
    return const User(
      firstName: 'Amanda',
      lastName: 'Wijaya',
      email: 'amandawijaya@gmail.com',
      profilePhoto: null,
      country: 'Indonesia',
      phoneNumber: '+62 8888001112',
    );
  }

  factory User.dummyWithPhoto() {
    return const User(
      firstName: 'Amanda',
      lastName: 'Wijaya',
      email: 'amandawijaya@gmail.com',
      profilePhoto: 'https://i.pravatar.cc/150?img=5',
      country: 'Indonesia',
      phoneNumber: '+62 8888001112',
    );
  }
}

class Vendor {
  final String name;
  final String category;
  final String? imageUrl;
  final bool isFavorited;

  const Vendor({
    required this.name,
    required this.category,
    this.imageUrl,
    this.isFavorited = true,
  });

  static List<Vendor> dummyList() {
    return [
      Vendor(name: 'Arthana', category: 'Wedding Planner & Organizer', imageUrl: 'https://i.pravatar.cc/150?img=1'),
      Vendor(name: 'Haris', category: 'Fotografi & Videografi', imageUrl: 'https://i.pravatar.cc/150?img=2'),
      Vendor(name: 'GatotKaca', category: 'MUA & Hair Do', imageUrl: 'https://i.pravatar.cc/150?img=3'),
      Vendor(name: 'Bella Moments', category: 'Dekorasi & Lighting', imageUrl: 'https://i.pravatar.cc/150?img=4'),
    ];
  }
}
