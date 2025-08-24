                                                            # **Cargo Intern App**
https://cargointernapp.web.app/#/login
https://drive.google.com/file/d/1G9ndOEcgW3wHzNZUl40qFHXjfIp-IMt-/view?usp=drive_link

A cross-platform Flutter app (mobile & web) for managing objects, using Firebase OTP authentication and a REST API for CRUD operations. The app demonstrates real-world mobile and web app development concepts including state management, responsive UI, and secure authentication.

# 1. Project Overview

The Cargo Intern App is designed as an internship project with the following features:

Authentication: Phone-based OTP login using Firebase.

Object Management: Full CRUD (Create, Read, Update, Delete) operations with a public REST API.

State Management & Navigation: Implemented using GetX.

Responsive UI: Works well on both mobile devices and web browsers.

Error Handling & Validation: All API operations, forms, and OTP verification handle errors gracefully.

## 2. Firebase Phone Authentication Setup

For this project, a dummy phone number was used for authentication testing because we did not have access to a paid Firebase Blaze plan to generate real OTPs.

Details:

Dummy Number: +911234567890

Dummy OTP for Verification: 123456

How it works:

The app uses the same Firebase OTP flow.

On entering the dummy number, Firebase allows login using the OTP 123456.

This simulates the real OTP verification flow, so all code and navigation behave exactly as if a real OTP was sent and verified.

Mobile Setup:

Enable Phone Sign-In in Firebase Authentication.

Add SHA-1 & SHA-256 keys for Android apps.

Configure firebase_options.dart via flutterfire configure.

Use the dummy number to login and navigate the app.

Web Setup:

Enable Phone Sign-In in Firebase Authentication.

Add localhost and your deployed Firebase domain to authorized domains.

Login using the dummy number and OTP.

## 3. pubspec.yaml Dependencies

The project uses the following dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.5
  firebase_core: ^2.25.0
  firebase_auth: ^4.8.0
  http: ^1.1.0
  uuid: ^3.1.0
  url_launcher: ^6.2.10

dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.5.0'''


These dependencies handle:

Firebase initialization and authentication.

State management and navigation with GetX.

API communication via HTTP.

Unique ID generation with uuid.

Opening external links (like GitHub) using url_launcher.

## 4. Code Structure & Design Choices
'''
   lib/
   ├─ auth/                  # Screens for login and OTP verification
   ├─ controllers/           # GetX controllers: AuthController, ApiController
   ├─ models/                # ObjectModel.dart
   ├─ services/              # ApiService.dart for REST API calls
   ├─ utils/                 # Helper functions and constants
   ├─ views/                 # Object CRUD screens
   ├─ main.dart              # Entry point and routing
   └─ firebase_options.dart  # Firebase configuration
'''

Key Design Choices:

GetX: Centralized state management, navigation, and dependency injection.

Theme: Indigo primary color, responsive layouts, clean card-based UI for mobile & web.

CRUD Flow:

Fetch objects from API.

Display list with pagination and detail view.

Add/Edit objects using forms with JSON validation.

Optimistic updates with immediate UI feedback.

Error Handling: All API calls and OTP actions show snackbars with meaningful messages.

Dummy OTP Flow: Mimics real OTP verification for testing without a paid Firebase plan.

## 5. Limitations & Future Improvements

Current Limitations:

* OTP flow uses a dummy number; real OTP requires Blaze plan.
* 
* Web layout needs additional fine-tuning for very large screens.
* 
* Partial updates (PATCH) not implemented; only full PUT.
* 
* No offline caching of API data.
* 
* Future Improvements:
* 
* Implement real OTP verification once Blaze plan is available.
* 
* Add dark mode support.
* 
* Enhance web layout with better responsive design for larger screens.
* 
* Add analytics/statistics to dashboard.
* 
* Implement full unit and integration tests for web and mobile.
