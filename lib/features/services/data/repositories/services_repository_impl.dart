import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/service_detail_entity.dart';
import '../../domain/repositories/services_repository.dart';
import '../models/service_detail_model.dart';

/// Concrete implementation of [ServicesRepository].
class ServicesRepositoryImpl implements ServicesRepository {
  ServicesRepositoryImpl({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  @override
  Future<ServiceDetailEntity> getServiceDetail(String serviceId) async {
    await _apiClient.get('/services/$serviceId');
    // Return mocked detailed data.
    return ServiceDetailModel(
      id: serviceId,
      title: AppStrings.detailedServiceTitle,
      rating: '4.9 (1.2k)',
      duration: AppStrings.detailedDurationValue,
      price: '149',
      imageAsset: AppAssets.deepCleaning,
      description: AppStrings.detailedExperienceText,
      isPremium: true,
    ).toEntity();
  }

  @override
  Future<List<ServiceDetailEntity>> getServicesByCategory(
    String categoryId,
  ) async {
    final response = await _apiClient.get('/services?category=$categoryId');
    final data = response['data'];
    if (data is List) {
      return data
          .cast<Map<String, dynamic>>()
          .map((json) => ServiceDetailModel.fromJson(json).toEntity())
          .toList();
    }
    return [];
  }
}
