/// Data Transfer Object for a service received from the API.
///
/// [ServiceDto] is the raw representation of a service as it arrives from the
/// network layer. Use [ServiceMapper] to convert it to a [ServiceEntity].
class ServiceDto {
  final String id;
  final String title;
  final String rating;
  final String duration;
  final String price;
  final String imageAsset;
  final String? description;
  final bool? isPremium;

  const ServiceDto({
    required this.id,
    required this.title,
    required this.rating,
    required this.duration,
    required this.price,
    required this.imageAsset,
    this.description,
    this.isPremium,
  });

  factory ServiceDto.fromJson(Map<String, dynamic> json) {
    return ServiceDto(
      id: json['id'] as String,
      title: json['title'] as String,
      rating: json['rating'] as String,
      duration: json['duration'] as String,
      price: json['price'] as String,
      imageAsset: json['imageAsset'] as String,
      description: json['description'] as String?,
      isPremium: json['isPremium'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'rating': rating,
        'duration': duration,
        'price': price,
        'imageAsset': imageAsset,
        if (description != null) 'description': description,
        if (isPremium != null) 'isPremium': isPremium,
      };
}
