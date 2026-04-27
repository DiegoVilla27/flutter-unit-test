# Flutter Unit Test Demo

A specialized Flutter project designed to demonstrate best practices in **Unit Testing** and **Widget Testing**. This project follows a clean separation of concerns between business logic and UI components.

## 🏗 Project Structure

- **`lib/counter.dart`**: Contains the `Counter` class (Business Logic).
- **`lib/user_repository.dart`**: Repository pattern for data fetching.
- **`lib/api_client.dart`**: Abstract API client for dependency injection.
- **`lib/main.dart`**: Contains the `HomeScreen` (UI Layer).
- **`test/counter_test.dart`**: Unit tests for the logic layer.
- **`test/user_repository_test.dart`**: Advanced tests with **Mocking**.
- **`test/widget_test.dart`**: Widget tests for the UI layer.

---

## 🧪 Testing Guide

### 1. Run All Tests
To run all tests in the project:
```bash
flutter test
```

### 2. Run a Specific Test File
```bash
flutter test test/counter_test.dart
```

---

## 📊 Code Coverage

### Prerequisites (MacOS)
To generate visual reports, you need `lcov` installed:
```bash
brew install lcov
```

### Generate Coverage Report
1. **Run tests with coverage flag**:
   ```bash
   flutter test --coverage
   ```
   This generates a `coverage/lcov.info` file.

2. **Generate HTML Report**:
   ```bash
   genhtml coverage/lcov.info -o coverage/html
   ```

3. **Open the Report**:
   ```bash
   open coverage/html/index.html
   ```

### Quick Visual Guide (VS Code)
For an integrated experience, install the **"Flutter Coverage"** extension. 
- It highlights covered lines in **green** and uncovered lines in **red** directly in the editor.
- Click the **"Watch"** button in the bottom status bar to activate.

---

## 🚀 Key Learning Points
- **Isolation**: Keep your logic in separate classes to make them 100% testable.
- **Mocking**: Use `mocktail` to simulate external dependencies (APIs, DBs) and test edge cases like 404s or network errors.
- **Dependency Injection**: Inject your services/clients into repositories to make them swappable for testing.
- **Asynchronous Testing**: Use `await` and `expectLater` to verify code that returns `Future` or `Stream`.
