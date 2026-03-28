import '../../domain/entities/service_detail_entity.dart';

/// Data Transfer Object (DTO) for a service detail.
class ServiceDetailModel {
  final String id;
  final String title;
  final String rating;
  final String duration;
  final String price;
  final String imageAsset;
  final String description;
  final bool isPremium;

  const ServiceDetailModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.duration,
    required this.price,
    required this.imageAsset,
    required this.description,
    this.isPremium = false,
  });

  factory ServiceDetailModel.fromJson(Map<String, dynamic> json) {
    return ServiceDetailModel(
      id: json['id'] as String,
      title: json['title'] as String,
      rating: json['rating'] as String,
      duration: json['duration'] as String,
      price: json['price'] as String,
      imageAsset: json['imageAsset'] as String,
      description: json['description'] as String? ?? '',
      isPremium: json['isPremium'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'rating': rating,
        'duration': duration,
        'price': price,
        'imageAsset': imageAsset,
        'description': description,
        'isPremium': isPremium,
      };

  /// Converts this DTO to a domain [ServiceDetailEntity].
  ServiceDetailEntity toEntity() => ServiceDetailEntity(
        id: id,
        title: title,
        rating: rating,
        duration: duration,
        price: price,
        imageAsset: imageAsset,
        description: description,
        isPremium: isPremium,
      );
}
