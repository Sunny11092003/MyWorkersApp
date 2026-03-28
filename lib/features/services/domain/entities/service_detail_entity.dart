import 'package:flutter/foundation.dart';

/// Domain entity representing the detailed view of a service.
@immutable
class ServiceDetailEntity {
  final String id;
  final String title;
  final String rating;
  final String duration;
  final String price;
  final String imageAsset;
  final String description;
  final bool isPremium;

  const ServiceDetailEntity({
    required this.id,
    required this.title,
    required this.rating,
    required this.duration,
    required this.price,
    required this.imageAsset,
    required this.description,
    this.isPremium = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceDetailEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
