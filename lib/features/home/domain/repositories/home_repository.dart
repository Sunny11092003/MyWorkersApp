import '../entities/service_entity.dart';
import '../entities/category_entity.dart';

/// Abstract contract for the home feature's data operations.
///
/// The data layer ([HomeRepositoryImpl]) implements this interface so that
/// the presentation layer depends only on the abstraction, not the
/// concrete implementation.
abstract class HomeRepository {
  /// Returns a list of popular services to display on the home screen.
  Future<List<ServiceEntity>> getPopularServices();

  /// Returns a list of service categories.
  Future<List<CategoryEntity>> getCategories();
}
