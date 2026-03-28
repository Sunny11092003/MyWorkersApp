import '../entities/service_detail_entity.dart';

/// Abstract contract for the services feature's data operations.
abstract class ServicesRepository {
  /// Returns the full details of a service identified by [serviceId].
  Future<ServiceDetailEntity> getServiceDetail(String serviceId);

  /// Returns a list of services for a given [categoryId].
  Future<List<ServiceDetailEntity>> getServicesByCategory(String categoryId);
}
