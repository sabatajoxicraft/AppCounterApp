# 🚀 Quick Start Guide

Get your React Native app running in minutes!

## Step 1: Use This Template

1. Click **"Use this template"** button on GitHub
2. Name your repository (e.g., `my-awesome-app`)
3. Create the repository

## Step 2: Clone & Customize

```bash
# Clone your new repo
git clone https://github.com/YOUR_USERNAME/my-awesome-app.git
cd my-awesome-app

# Install dependencies
npm install
```

## Step 3: Customize App Identity

### Change App Name

Edit `android/app/src/main/res/values/strings.xml`:
```xml
<string name="app_name">My Awesome App</string>
```

Edit `app.json`:
```json
{
  "name": "MyAwesomeApp",
  "displayName": "My Awesome App"
}
```

### Change Package ID (Optional)

Edit `android/app/build.gradle`:
```groovy
namespace "com.mycompany.myapp"
applicationId "com.mycompany.myapp"
```

Then rename Java package directories and update imports.

## Step 4: Make Your First Change

Edit `App.js` to customize the UI:
```javascript
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

export default function App() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>My Awesome App</Text>
      <Text style={styles.subtitle}>Built with React Native</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 32,
    fontWeight: 'bold',
    color: '#333',
  },
  subtitle: {
    fontSize: 18,
    color: '#666',
    marginTop: 10,
  },
});
```

## Step 5: Build via GitHub Actions

```bash
# Commit and push
git add .
git commit -m "Customize app name and UI"
git push
```

**GitHub Actions will automatically build your APK!**

## Step 6: Download & Install

### Option A: Using deploy script (Termux)

```bash
# Make script executable (first time only)
chmod +x deploy.sh

# Download and deploy APK
./deploy.sh

# Install
termux-open /storage/emulated/0/Download/my-awesome-app.apk
```

### Option B: Manual download

1. Go to your GitHub repository
2. Click **Actions** tab
3. Click the latest workflow run
4. Scroll down to **Artifacts**
5. Download **app-debug**
6. Extract and install the APK

### Option C: Using gh CLI

```bash
# Get latest run ID
gh run list --limit 1

# Download APK
gh run download LATEST_RUN_ID --name app-debug

# Copy to Downloads
cp app-debug.apk /storage/emulated/0/Download/MyApp.apk
```

## Step 7: Verify Installation

1. Open the app on your Android device
2. You should see "My Awesome App" with your custom UI

## 🎉 You're Done!

Your React Native app is now:
- ✅ Built automatically on every push
- ✅ Customized with your branding
- ✅ Installable on Android devices
- ✅ Ready for feature development

## Next Steps

### Add Features

Check [COMPATIBILITY.md](./COMPATIBILITY.md) for tested libraries:

```bash
# Example: Add image picker
npm install react-native-image-picker

# Commit and push to rebuild
git add . && git commit -m "Add image picker" && git push
```

### Add Icons & Splash Screen

1. Replace `android/app/src/main/res/mipmap-*/ic_launcher.png` with your icons
2. Or use `react-native-bootsplash` for animated splash screens

### Setup Navigation

```bash
npm install @react-navigation/native @react-navigation/native-stack
npm install react-native-screens react-native-safe-area-context
```

### Add Database

SQLite is already included! Example usage:

```javascript
import SQLite from 'react-native-sqlite-storage';

const db = await SQLite.openDatabase({name: 'mydb.db'});
await db.executeSql('CREATE TABLE IF NOT EXISTS users (id INT, name TEXT)');
```

## 🐛 Troubleshooting

### Build Failed

1. Check Actions tab for error logs
2. Review [COMPATIBILITY.md](./COMPATIBILITY.md) for known issues
3. Verify dependencies are compatible with RN 0.73.6

### App Won't Install

1. Uninstall previous version first
2. Enable "Install from Unknown Sources" in Android settings
3. Check APK isn't corrupted (should be ~30-150MB)

### Changes Not Showing

1. Ensure you pushed changes: `git push`
2. Wait for build to complete (check Actions tab)
3. Download the **latest** APK artifact

## 📚 Resources

- [README.md](./README.md) - Full documentation
- [COMPATIBILITY.md](./COMPATIBILITY.md) - Library compatibility guide
- [React Native Docs](https://reactnative.dev/docs/getting-started)
- [GitHub Actions Docs](https://docs.github.com/en/actions)

---

**Need help?** Open an issue in your repository or check existing issues in the template repo.
