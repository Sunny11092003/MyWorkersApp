import '../../domain/entities/service_entity.dart';

/// Data Transfer Object (DTO) for a service.
///
/// [ServiceModel] is responsible for JSON serialization/deserialization and
/// maps to the [ServiceEntity] domain object via [toEntity].
class ServiceModel {
  final String id;
  final String title;
  final String rating;
  final String duration;
  final String price;
  final String imageAsset;

  const ServiceModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.duration,
    required this.price,
    required this.imageAsset,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as String,
      title: json['title'] as String,
      rating: json['rating'] as String,
      duration: json['duration'] as String,
      price: json['price'] as String,
      imageAsset: json['imageAsset'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'rating': rating,
        'duration': duration,
        'price': price,
        'imageAsset': imageAsset,
      };

  /// Converts this DTO to a domain [ServiceEntity].
  ServiceEntity toEntity() => ServiceEntity(
        id: id,
        title: title,
        rating: rating,
        duration: duration,
        price: price,
        imageAsset: imageAsset,
      );
}
