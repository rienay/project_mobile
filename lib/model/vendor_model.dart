import 'package:flutter/material.dart';

class Vendor {
  final String name;
  final String location;
  final double rating;
  final int reviews;
  final String mainImage;
  final List<String> portfolioImages;
  final String description;
  final List<Map<String, dynamic>> services;
  final List<Map<String, dynamic>> packages;

  Vendor({
    required this.name,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.mainImage,
    required this.portfolioImages,
    required this.description,
    required this.services,
    required this.packages,
  });
}