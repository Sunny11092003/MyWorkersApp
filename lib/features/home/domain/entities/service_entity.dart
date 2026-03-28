import 'package:flutter/foundation.dart';

/// Domain entity representing a service listing displayed on the home screen.
///
/// This is a pure domain object — it has no dependency on any framework or
/// data layer. DTOs ([ServiceModel]) are mapped to this entity by the
/// repository layer.
@immutable
class ServiceEntity {
  final String id;
  final String title;
  final String rating;
  final String duration;
  final String price;
  final String imageAsset;

  const ServiceEntity({
    required this.id,
    required this.title,
    required this.rating,
    required this.duration,
    required this.price,
    required this.imageAsset,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
