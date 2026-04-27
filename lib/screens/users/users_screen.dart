import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'repository/user_repository.dart';

class UsersScreen extends StatefulWidget {
  final UserRepository userRepository;

  const UsersScreen({super.key, required this.userRepository});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  User? _user;
  bool _isLoading = false;
  String? _error;

  Future<void> _fetchUser() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final user = await widget.userRepository.getUser(1);
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading user';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users API'),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red))
              else if (_user != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('ID: ${_user!.id}'),
                        const SizedBox(height: 8),
                        Text(
                          _user!.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                )
              else
                const Text('No user loaded'),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _fetchUser,
                icon: const Icon(Icons.download),
                label: const Text('Fetch User (ID: 1)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
