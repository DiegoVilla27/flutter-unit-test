import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import '../screens/users/services/api_client.dart';
import '../screens/users/repository/user_repository.dart';
import '../screens/home/home_screen.dart';
import '../screens/users/users_screen.dart';

final _dio = Dio(BaseOptions(
  baseUrl: 'https://jsonplaceholder.typicode.com',
  headers: {
    'Content-Type': 'application/json',
  },
));

final _userRepository = UserRepository(
  apiClient: RealApiClient(dio: _dio),
);

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/users',
      builder: (context, state) => UsersScreen(userRepository: _userRepository),
    ),
  ],
);
