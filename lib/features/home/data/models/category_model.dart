import '../../domain/entities/category_entity.dart';

/// Data Transfer Object (DTO) for a service category.
class CategoryModel {
  final String id;
  final String name;

  const CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  /// Converts this DTO to a domain [CategoryEntity].
  CategoryEntity toEntity() => CategoryEntity(id: id, name: name);
}
