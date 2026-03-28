import '../models/dtos/service_dto.dart';
import '../models/entities/service_entity.dart';

/// Maps between [ServiceDto] (API layer) and [ServiceEntity] (domain layer).
class ServiceMapper {
  const ServiceMapper._();

  /// Converts a single [ServiceDto] to a [ServiceEntity].
  static ServiceEntity fromDto(ServiceDto dto) {
    return ServiceEntity(
      id: dto.id,
      title: dto.title,
      rating: dto.rating,
      duration: dto.duration,
      price: dto.price,
      imageAsset: dto.imageAsset,
      description: dto.description ?? '',
      isPremium: dto.isPremium ?? false,
    );
  }

  /// Converts a list of [ServiceDto] objects to [ServiceEntity] objects.
  static List<ServiceEntity> fromDtoList(List<ServiceDto> dtos) {
    return dtos.map(fromDto).toList();
  }

  /// Converts a [ServiceEntity] back to a [ServiceDto] (e.g. for POST body).
  static ServiceDto toDto(ServiceEntity entity) {
    return ServiceDto(
      id: entity.id,
      title: entity.title,
      rating: entity.rating,
      duration: entity.duration,
      price: entity.price,
      imageAsset: entity.imageAsset,
      description: entity.description,
      isPremium: entity.isPremium,
    );
  }
}
