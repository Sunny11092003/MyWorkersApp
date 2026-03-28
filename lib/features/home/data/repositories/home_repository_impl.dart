import '../../../../core/network/api_client.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/category_model.dart';
import '../models/service_model.dart';

/// Concrete implementation of [HomeRepository].
///
/// Fetches data from [ApiClient] and maps API responses (DTOs) to domain
/// entities before returning them to the presentation layer.
class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  @override
  Future<List<ServiceEntity>> getPopularServices() async {
    final response = await _apiClient.get('/services/popular');
    final data = response['data'] as List<dynamic>;
    return data
        .cast<Map<String, dynamic>>()
        .map((json) => ServiceModel.fromJson(json).toEntity())
        .toList();
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final response = await _apiClient.get('/categories');
    final data = response['data'] as List<dynamic>;
    return data
        .cast<Map<String, dynamic>>()
        .map((json) => CategoryModel.fromJson(json).toEntity())
        .toList();
  }
}
