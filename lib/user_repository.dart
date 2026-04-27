import 'dart:convert';
import 'user_model.dart';
import 'api_client.dart';

class UserRepository {
  final ApiClient apiClient;

  UserRepository({required this.apiClient});

  Future<User> getUser(int id) async {
    final response = await apiClient.getRequest('/users/$id');

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }
}
