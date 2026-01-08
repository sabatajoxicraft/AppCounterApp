# App Counter App

A React Native Android app that tracks the number of times you've opened it and remembers your name.

## Features
- SQLite database to store user data
- Tracks app open count
- Remembers your name for personalized welcome screen
- First-time setup screen vs returning user screen

## Setup & Run

### Prerequisites
- Node.js installed
- Android SDK installed
- Android device or emulator running

### Installation
```bash
cd AppCounterApp
npm install
```

### Build & Run on Android
```bash
# Start the Metro bundler in one terminal
npm start

# In another terminal, build and install on your device
npm run android

# Or use React Native CLI directly
npx react-native run-android
```

### Build APK for Manual Installation
```bash
cd android
./gradlew assembleRelease

# The APK will be in: android/app/build/outputs/apk/release/app-release.apk
```

### Install APK on Phone
```bash
adb install android/app/build/outputs/apk/release/app-release.apk
```

## How It Works
1. **First Launch**: App shows a welcome screen asking for your name with an input field
2. **Subsequent Launches**: App shows "Welcome back, [Your Name]!" with the count of how many times you've opened it
3. All data is stored in SQLite database and persists across app restarts
