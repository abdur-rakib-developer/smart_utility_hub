# Smart Utility Hub

An all-in-one personal utility Flutter application combining authentication, profile management, temperature conversion, and image gallery features into a unified dashboard experience.

## ✨ Features

### 🔐 Supabase Authentication
- **Secure Registration** - Create accounts with email and password validation
- **Simple Login** - Quick email/password authentication
- **Session Management** - Automatic user session handling
- **Email Format Validation** - Basic client-side email checking
- **No Email Confirmation Required** - Instant account activation for development

### � Unified Dashboard
- **Integrated User Profile** - Avatar display with quick profile access
- **Quick Temperature Converter** - Embedded widget for instant conversions
  - Live conversion as you type
  - Dropdown selection for scales (Celsius, Fahrenheit, Kelvin)
  - Clean vertical layout for perfect responsiveness
- **Image Gallery Preview** - Horizontal scrolling preview of 5 images
  - Fetched from Picsum Photos API
  - Smooth loading animations
  - Click "View All" for full gallery
- **Quick Access Buttons** - Compact navigation to all features

### 🌡️ Temperature Converter
- **Multi-Scale Support** - Convert between Celsius, Fahrenheit, and Kelvin
- **Real-Time Conversion** - Instant results as you type
- **Intuitive Interface** - Clear input/output separation
- **Service Layer Logic** - Pure conversion functions for accuracy

### 🖼️ Image Gallery
- **Random Images** - Beautiful photos from Picsum Photos API
- **Grid Layout** - Responsive 2-column grid display
- **Loading Indicators** - Visual feedback while images load
- **Seed-Based URLs** - Consistent images across sessions

### ⚙️ Settings Screen
- **Account Information** - View email and user ID
- **App Details** - Version, build info, app name
- **Feature List** - Overview of integrated functionality
- **Clean Organization** - Categorized sections for easy navigation

### 👤 User Profile
- **Email Display** - View registered email address
- **User ID** - Unique Supabase user identifier
- **Account Creation Date** - Registration timestamp
- **Styled Cards** - Modern material design presentation

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Supabase account (for authentication)

### Installation

1. **Clone or download this project**

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Supabase**
   - Go to [supabase.com](https://supabase.com) and create a new project
   - In **Authentication** → **Settings**, disable "Enable email confirmations"
   - Copy your Supabase URL and Anon Key from **Project Settings** → **API**
   - Open `lib/constants/app_constants.dart`
   - Replace `YOUR_SUPABASE_URL` and `YOUR_SUPABASE_ANON_KEY` with your credentials

4. **Run the app**
   ```bash
   flutter run -d chrome    # For web
   flutter run -d windows   # For Windows desktop
   flutter run -d android   # For Android (with emulator/device)
   ```

## 📁 Project Structure

```
lib/
├── main.dart                              # App entry point with Supabase init
├── auth_gate.dart                         # Authentication router
├── constants/
│   └── app_constants.dart                 # Colors, styles, Supabase config
├── models/
│   └── user_model.dart                    # User data model
├── screens/
│   ├── splash_screen.dart                 # 2-second splash with auto-navigation
│   ├── login_screen.dart                  # Email/password login
│   ├── register_screen.dart               # Registration with password confirmation
│   ├── home_screen.dart                   # Unified dashboard with all features
│   ├── profile_screen.dart                # User account details
│   ├── temperature_converter_screen.dart  # Full temperature converter
│   ├── settings_screen.dart               # App settings and info
│   └── image_gallery_screen.dart          # Image grid from Picsum API
├── services/
│   ├── auth_service.dart                  # Supabase authentication wrapper
│   └── temperature_converter_service.dart # Temperature conversion logic
└── widgets/
    ├── primary_button.dart                # Reusable styled button
    └── custom_text_field.dart             # Reusable input field
```

## 📦 Dependencies

- `supabase_flutter: ^2.9.1` - Backend authentication and database
- `cupertino_icons: ^1.0.8` - iOS-style icons
- `flutter_lints: ^5.0.0` - Code quality and linting (dev)

## 🎯 How to Use

1. **Register** - Create a new account with any email format (e.g., test@test.com) and password (6+ characters)
2. **Login** - Sign in with your credentials (works instantly without email confirmation)
3. **Dashboard** - View unified interface with:
   - Your profile info at the top
   - Quick temperature converter
   - Image gallery preview
   - Quick access buttons
4. **Navigate** - Use the drawer menu or dashboard buttons to access:
   - Full Temperature Converter
   - Complete Image Gallery
   - Settings & App Info
   - Your Profile
5. **Logout** - Sign out via the logout button in the app bar

## 🔧 Features Integration

This app integrates **89 features** from 5 different GitHub repositories into a single, practical application:
- Authentication system with Supabase
- Temperature conversion functionality
- Image browsing with Picsum API
- Profile management
- Material 3 dark theme UI

See [FEATURE_INTEGRATION.md](FEATURE_INTEGRATION.md) for detailed feature mapping.

## 🎨 Design

- **Material 3 Dark Theme** - Modern, eye-friendly design
- **Consistent Color Palette** - Blues, oranges, purples, and greens
- **Responsive Layout** - Works on web, desktop, and mobile
- **Unified Dashboard** - All features accessible from one screen

## 📝 License

MIT License - Feel free to use this project for learning purposes.

