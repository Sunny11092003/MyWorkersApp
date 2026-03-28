import '../mappers/service_mapper.dart';
import '../models/dtos/service_dto.dart';
import '../models/entities/service_entity.dart';

/// Repository that provides access to service data.
///
/// This is a mock implementation. Replace the [_mockServices] list and the
/// [fetchAll] / [fetchById] implementations with real API calls when a backend
/// is available.
class ServiceRepository {
  const ServiceRepository();

  static final List<ServiceDto> _mockServices = [
    const ServiceDto(
      id: '1',
      title: 'Full Home Deep Cleaning',
      rating: '4.9',
      duration: '4-6 hrs',
      price: '149',
      imageAsset: 'assets/images/deep_cleaning.jpg',
      description:
          'Our signature deep cleaning service goes beyond the surface. '
          'We target hidden dust, stubborn stains, and allergens in every '
          'corner of your home using eco-friendly, hospital-grade disinfectants.',
      isPremium: true,
    ),
    const ServiceDto(
      id: '2',
      title: 'AC Servicing & Repair',
      rating: '4.9',
      duration: '1-2 Hours',
      price: '45',
      imageAsset: 'assets/images/ac_repair.jpg',
      description: 'Full servicing and repair of all AC units.',
      isPremium: false,
    ),
    const ServiceDto(
      id: 'eco',
      title: 'Eco-Friendly Deep Clean',
      rating: '4.8',
      duration: '2-3 HRS',
      price: '89',
      imageAsset: 'assets/images/eco_frndly_clean.webp',
      description: 'A green cleaning solution using only eco-friendly products.',
      isPremium: false,
    ),
    const ServiceDto(
      id: 'quick',
      title: 'Quick Refresh Clean',
      rating: '4.7',
      duration: '1 HR',
      price: '45',
      imageAsset: 'assets/images/quick_clean.webp',
      description: 'A fast refresh clean for busy households.',
      isPremium: false,
    ),
    const ServiceDto(
      id: 'move',
      title: 'Move-in / Move-out',
      rating: '5.0',
      duration: '4-6 HRS',
      price: '150',
      imageAsset: 'assets/images/move_clean.png',
      description: 'Complete deep clean for move-in or move-out.',
      isPremium: false,
    ),
  ];

  /// Returns all available services as domain entities.
  Future<List<ServiceEntity>> fetchAll() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return ServiceMapper.fromDtoList(_mockServices);
  }

  /// Returns a single service by [id], or null if not found.
  Future<ServiceEntity?> fetchById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final dto = _mockServices.cast<ServiceDto?>().firstWhere(
          (s) => s?.id == id,
          orElse: () => null,
        );
    return dto == null ? null : ServiceMapper.fromDto(dto);
  }
}
