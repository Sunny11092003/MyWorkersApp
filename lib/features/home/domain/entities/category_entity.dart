import 'package:flutter/foundation.dart';

/// Domain entity representing a service category.
@immutable
class CategoryEntity {
  final String id;
  final String name;

  const CategoryEntity({required this.id, required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
