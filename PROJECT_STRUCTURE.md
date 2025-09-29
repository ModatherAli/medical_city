# Project Structure Documentation

This document provides a high-level overview of the project's folder structure. It is intended to help new developers, including those unfamiliar with Flutter, to quickly understand the layout of the codebase.

## Root Directories

### `android/`

This directory holds a complete Android project. When you build your Flutter application for Android, it builds upon this project. You would typically edit files in this directory if you need to add Android-specific functionality that isn't available through Flutter's APIs, such as integrating a native Android library or configuring permissions.

- **`app/`**: Contains the application-level configuration and source code for the Android part of the app.
- **`build.gradle.kts`**: This is the main configuration file for the Android project, where you can specify dependencies and build settings.
- **`settings.gradle.kts`**: This file is used to specify which modules to include when building the app.

### `assets/`

This directory is for static assets that are bundled with the application at build time.

- **`fonts/`**: Custom fonts used throughout the application are stored here.
- **`icons/`**: Contains icon files, likely in SVG or PNG format, used in the UI.
- **`images/`**: Holds images that are displayed within the application, such as logos, banners, or illustrations.

### `ios/`

Similar to the `android/` directory, this folder contains a complete Xcode project for iOS. It's the foundation for the iOS version of your app. You would modify its contents to add iOS-specific features, such as integrating with Apple's HealthKit or setting up push notifications.

- **`Runner/`**: The main application folder for the iOS project.
- **`Runner.xcodeproj/`**: The Xcode project file. You would open this in Xcode to work on the native iOS part.

### `lib/`

This is the heart of your Flutter application. All the Dart code for your app resides here. The following subdirectories organize the codebase.

#### `lib/app/`

This directory contains the core application setup and configuration.

- **`router/`**: This likely contains the application's navigation and routing logic, defining how users move between different screens.
- **`medical_city_app.dart`**: This is probably the main application widget, where the app's theme, localization, and other top-level configurations are set up.

#### `lib/controllers/`

In a typical Flutter architecture (like MVC or GetX), controllers handle the application's business logic. They process user input, interact with services and models, and manage the state of the UI.

- **`binding_controller.dart`**: This file might be responsible for setting up dependencies for different screens or modules.
- **`user_controller.dart`**: Manages user-related state and logic, such as authentication, user profiles, etc.

#### `lib/core/`

This directory usually contains shared code that is used across the entire application and is not specific to any feature.

- **`constants/`**: Holds constant values like API keys, color codes, or string literals.
- **`di/`**: Stands for Dependency Injection. This folder likely contains code for managing how different parts of the app get the dependencies they need to function.
- **`errors/`**: Defines custom error and exception classes for handling failures gracefully.
- **`localization/`**: Contains code for internationalization (i18n) and localization (l10n), allowing the app to support multiple languages.
- **`network/`**: Manages network requests, such as fetching data from a remote API.
- **`usecases/`**: Represents specific business actions or user flows (e.g., `LoginUser`, `FetchAppointments`).
- **`utils/`**: A collection of utility functions and helper classes.

#### `lib/models/`

Models define the data structure of the application. They represent the objects your app works with, like a `User` or a `Product`.

- **`json/`**: May contain raw JSON files for testing or default data.
- **`user_model.dart`**: Defines the `User` data model, including how to serialize it from/to JSON.

#### `lib/screens/`

This directory contains the UI for the different screens of the application. Each subdirectory or file typically corresponds to a specific page or a major UI component.

#### `lib/services/`

Services are responsible for handling external interactions, such as calling a remote API, accessing a local database, or using device hardware (like GPS or camera).

#### `lib/shared/`

This directory is for widgets, components, and functions that are shared across multiple screens or features but are not as foundational as the code in `lib/core/`. This could include things like custom buttons, text fields, or dialogs.