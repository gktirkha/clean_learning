# Clean Learning - Flutter Clean Architecture

A comprehensive Flutter project designed for learning and demonstrating **Clean Architecture** principles. This project showcases a robust, scalable, and testable application structure, integrating modern Flutter development practices.

## 🚀 Features

Currently, the project implements a complete Authentication feature set:

-   **User Sign Up**: Register new users with email and password.
-   **User Login**: Authenticate existing users.
-   **User Logout**: Securely end user sessions.
-   **State Management**: robust state handling using BLoC pattern.

## 🛠 Tech Stack

This project uses a curated list of libraries and tools to ensure high quality and maintainability:

-   **[Flutter](https://flutter.dev/)**: Google's UI toolkit for building natively compiled applications.
-   **[FVM (Flutter Version Management)](https://fvm.app/)**: Consistent Flutter SDK versioning per project.
-   **Clean Architecture**: Separation of concerns into Domain, Data, and Presentation layers.
-   **[flutter_bloc](https://pub.dev/packages/flutter_bloc)**: Predictable state management.
-   **[freezed](https://pub.dev/packages/freezed)**: Code generation for immutable classes and unions.
-   **[get_it](https://pub.dev/packages/get_it)** & **[injectable](https://pub.dev/packages/injectable)**: Dependency injection and service location.
-   **[fpdart](https://pub.dev/packages/fpdart)**: Functional programming in Dart (Option, Either, etc.).
-   **[Supabase](https://supabase.com/)**: Open Source Firebase alternative for backend services (Auth, Database).

## 📂 Project Structure

The project follows a feature-first Clean Architecture approach:

```text
lib/
├── core/                   # Core functionality shared across features
│   ├── di/                 # Dependency Injection setup
│   ├── error/              # Error handling (Failures, Exceptions)
│   ├── network/            # Network checks etc.
│   ├── secrets/            # App secrets (Not checked into git)
│   ├── theme/              # App theme and UI config
│   ├── use_case/           # Base UseCase interface
│   └── utils/              # Utility functions
|
├── features/               # Feature-specific code
│   └── auth/               # Authentication Feature
│       ├── data/           # Data Layer (Repositories, Data Sources, Models)
│       ├── domain/         # Domain Layer (Entities, Repositories Interfaces, Use Cases)
│       └── presentation/   # Presentation Layer (BLoC, Pages, Widgets)
|
└── main.dart               # Entry point
```

## 🏁 Getting Started

### Prerequisites

-   **Flutter SDK**: Ensure you have Flutter installed.
-   **FVM**: This project uses FVM to manage the Flutter version.
    ```bash
    dart pub global activate fvm
    ```

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/clean_learning.git
    cd clean_learning
    ```

2.  **Install Flutter SDK version using FVM:**
    ```bash
    fvm install
    ```

3.  **Install dependencies:**
    ```bash
    fvm flutter pub get
    ```

4.  **Run Code Generation:**
    This project uses `build_runner` for generating code (for `freezed`, `json_serializable`, `injectable`, etc.).
    ```bash
    fvm dart run build_runner build --delete-conflicting-outputs
    ```

### Running the App

To run the application on a connected device or emulator:

```bash
fvm flutter run
```

## 📝 Usage

The application currently boots into the Authentication flow. You can sign up for a new account or log in with existing credentials. The backend is powered by Supabase.

> **Note:** Ensure you have the necessary helper files (like `app_secrets.dart`) configured with your Supabase credentials if you are building this from scratch, as they are excluded from version control.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

*This project is for learning purposes.*
