import 'package:flutter/material.dart';

class Vendor {
  final String id;
  final String name;
  final String location;
  final double rating;
  final int reviews;
  final String mainImage;
  final List<String> portfolioImages;
  final String description;
  final List<Map<String, dynamic>> services;
  final List<Map<String, dynamic>> packages;
  
  // Fields tambahan dari database
  final String price;
  final String phone;
  final String experience;
  final String servicesText;
  final String reasonsText;
  final String notesText;
  final String category;
  final int isTrend;
  final int isWeddingReference;
  final String weddingReferenceTitle;
  final String weddingReferenceFoto;
  final String weddingReferenceDescription;
  final String trendFoto;

  Vendor({
    this.id = '',
    required this.name,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.mainImage,
    required this.portfolioImages,
    required this.description,
    required this.services,
    required this.packages,
    this.price = '0',
    this.phone = '',
    this.experience = '',
    this.servicesText = '',
    this.reasonsText = '',
    this.notesText = '',
    this.category = '',
    this.isTrend = 0,
    this.isWeddingReference = 0,
    this.weddingReferenceTitle = '',
    this.weddingReferenceFoto = '',
    this.weddingReferenceDescription = '',
    this.trendFoto = '',
  });
}