# Shopping App Demo - Flutter with Firebase & Hive

A shopping list application built with Flutter, Firebase Authentication, Hive local storage, and Provider state management.

## Features

**Authentication**
- Sign up with username, email, password, and confirm password
- Login with email and password
- Firebase Authentication integration
- Form validation

**Shopping List Management**
- View all shopping items in a list
- Add new items with name, description, and quantity
- Edit existing items
- Delete items with swipe-to-delete gesture
- Mark items as completed with checkbox
- Undo delete functionality

**State Management**
- Provider pattern for clean architecture
- Separate providers for Auth, Theme, and Shopping data

**Local Storage**
- Hive database for offline data persistence
- Items persist across app restarts

**Theme Support**
- Light and Dark mode toggle
- Theme preference persisted locally
- Material Design 3

## Project Structure

```
lib/
├── core/
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   └── theme_provider.dart
│   └── theme/
│       └── app_theme.dart
├── features/
│   ├── auth/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── login_screen.dart
│   │   │   │   └── signup_screen.dart
│   │   │   └── widgets/
│   │   │       ├── custom_button.dart
│   │   │       └── custom_text_field.dart
│   └── home/
│       ├── data/
│       │   └── models/
│       │       ├── shopping_item_model.dart
│       │       └── shopping_item_model.g.dart
│       └── presentation/
│           ├── providers/
│           │   └── shopping_provider.dart
│           ├── screens/
│           │   ├── add_item_screen.dart
│           │   └── home_screen.dart
│           └── widgets/
│               └── shopping_item_card.dart
├── firebase_options.dart
└── main.dart
```