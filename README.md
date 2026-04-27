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

### ⚡️ Automated Scripts
To simplify the process, we have added automation scripts:
- **`scripts/test_coverage.sh`**: This script cleans old reports, runs tests with coverage, filters unnecessary files, and generates the HTML report in one go.
  
  **How to use:**
  ```bash
  chmod +x scripts/test_coverage.sh  # Only first time
  ./scripts/test_coverage.sh
  ```

### 🛠 Visual Tools (VS Code)

#### **Coverage Gutters**
For a better developer experience, we recommend the **Coverage Gutters** extension.
- **What it does**: Displays color-coded gutters in the editor to show which lines are covered by tests.
- **How to use**:
  1. Install "Coverage Gutters" from the VS Code Marketplace.
  2. Ensure you have generated the `lcov.info` file (run the script or `flutter test --coverage`).
  3. Click the **"Watch"** button in the bottom status bar or press `Shift + Cmd + 7` (Mac).
  4. **Green** marks covered lines, **Red** marks uncovered ones.

---

## 🚀 Key Learning Points
- **Isolation**: Keep your logic in separate classes to make them 100% testable.
- **Mocking**: Use `mocktail` to simulate external dependencies (APIs, DBs) and test edge cases like 404s or network errors.
- **Dependency Injection**: Inject your services/clients into repositories to make them swappable for testing.
- **Asynchronous Testing**: Use `await` and `expectLater` to verify code that returns `Future` or `Stream`.
