import '../models/user_model.dart';
import '../services/api_client.dart';

class UserRepository {
  final ApiClient apiClient;

  UserRepository({required this.apiClient});

  Future<User> getUser(int id) async {
    final response = await apiClient.getRequest('/users/$id');

    if (response.statusCode == 200) {
      // Dio automatically decodes JSON if the response is JSON
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return User.fromJson(data);
      }
      throw Exception('Invalid data format');
    } else {
      throw Exception('Failed to load user');
    }
  }
}
