import 'package:flutter/foundation.dart';

/// Domain entity representing a service in the data layer.
///
/// This is a pure Dart object with no framework dependencies. It is produced
/// by mapping a [ServiceDto] via [ServiceMapper].
@immutable
class ServiceEntity {
  final String id;
  final String title;
  final String rating;
  final String duration;
  final String price;
  final String imageAsset;
  final String description;
  final bool isPremium;

  const ServiceEntity({
    required this.id,
    required this.title,
    required this.rating,
    required this.duration,
    required this.price,
    required this.imageAsset,
    this.description = '',
    this.isPremium = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ServiceEntity(id: $id, title: $title)';
}
