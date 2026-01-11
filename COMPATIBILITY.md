# 📚 Compatibility Guide

This guide documents tested library compatibility with **React Native 0.73.6**, **AGP 8.x**, and **JDK 17** based on production builds.

## Environment Specs

- **React Native**: 0.73.6
- **React**: 18.2.0
- **Node.js**: 18.x
- **JDK**: 17
- **Gradle**: 8.4
- **Android Gradle Plugin (AGP)**: 8.x
- **Build Environment**: GitHub Actions (ubuntu-latest)

---

## ✅ Tested & Working

### Core Libraries

| Library | Version | Notes |
|---------|---------|-------|
| `react-native` | 0.73.6 | Stable base |
| `react` | 18.2.0 | Required for RN 0.73 |
| `@react-native/babel-preset` | 0.73.21 | Essential |
| `@react-native/metro-config` | 0.73.5 | Essential |

### Database & Storage

| Library | Version | Notes |
|---------|---------|-------|
| `react-native-sqlite-storage` | 6.0.1 | Works perfectly |
| `@react-native-async-storage/async-storage` | 1.24.0+ | Recommended storage |

### Media & Camera

| Library | Version | Notes |
|---------|---------|-------|
| `react-native-vision-camera` | 3.9.0 | Camera preview works, avoid frame processors |
| `react-native-image-picker` | 7.2.3+ | Photo selection |
| `@react-native-camera-roll/camera-roll` | 7.4.0+ | Gallery access |

### Animations

| Library | Version | Notes |
|---------|---------|-------|
| `react-native-reanimated` | **3.6.3** | ✅ Use 3.6.3, NOT 4.x |
| Pure Animated API | Built-in | Always safe fallback |

### File System

| Library | Version | Notes |
|---------|---------|-------|
| `react-native-fs` | 2.20.0+ | File operations |
| `react-native-document-picker` | 9.3.1+ | Document selection |

### UI Components

| Library | Version | Notes |
|---------|---------|-------|
| Pure View components | Built-in | Always works - use instead of SVG |
| `react-native-bootsplash` | 6.3.11+ | Splash screen |

---

## ❌ Known Incompatibilities

### Graphics & SVG

| Library | Issue | Workaround |
|---------|-------|------------|
| `react-native-svg` | "Dynamic cannot be converted to float" with AGP 8.x | Use pure View components with borders, transforms, shadows |
| `react-native-svg-charts` | Depends on react-native-svg | Use alternative charting or custom View-based charts |

### Animation Libraries

| Library | Issue | Workaround |
|---------|-------|------------|
| `react-native-reanimated@4.x` | Requires RN 0.74+ | Downgrade to 3.6.3 |
| `react-native-lottie` | May have SVG dependencies | Test before using, consider animated GIFs |

### Camera Advanced Features

| Library | Issue | Workaround |
|---------|-------|------------|
| `vision-camera-dynamsoft-document-normalizer` | Complex worklets dependencies | Use manual capture + server-side processing |
| `react-native-worklets-core` | Conflicts with Reanimated in RN 0.73 | Avoid or use Reanimated 3.x worklets |
| VisionCamera frame processors | Requires worklets setup incompatible with RN 0.73 | Use camera preview only, process images after capture |

---

## 💡 Best Practices

### 1. Prefer Pure React Native

When possible, use built-in components instead of third-party libraries:

```javascript
// ❌ Requires react-native-svg (incompatible)
import Svg, { Circle, Line } from 'react-native-svg';

// ✅ Use pure View components
<View style={{
  width: 100,
  height: 100,
  borderRadius: 50,
  borderWidth: 2,
  borderColor: '#00FF00',
  backgroundColor: 'transparent'
}} />
```

### 2. Animation Strategy

```javascript
// ✅ Simple animations - use Animated API
import { Animated } from 'react-native';
const fadeAnim = useRef(new Animated.Value(0)).current;

// ✅ Complex animations - use Reanimated 3.6.3
import Animated, { useSharedValue } from 'react-native-reanimated';
// Remember: Add 'react-native-reanimated/plugin' to babel.config.js

// ❌ Avoid Reanimated 4.x (requires RN 0.74+)
```

### 3. Camera Implementation

```javascript
// ✅ Camera preview only
<Camera device={device} isActive={true} />

// ❌ Frame processors (worklets issues)
<Camera
  device={device}
  frameProcessor={frameProcessor} // Avoid in RN 0.73
/>

// ✅ Instead: Capture photo, then process
const photo = await camera.current.takePhoto();
// Process photo in JavaScript or send to backend
```

### 4. Testing New Dependencies

Before committing to a dependency:

1. **Check npm page** for RN version compatibility
2. **Search issues** for "RN 0.73" or "AGP 8"
3. **Test via CI** - Let GitHub Actions build (free, safe)
4. **Have a backup plan** - Pure RN implementation

---

## 🔧 Troubleshooting Common Issues

### Issue: "Dynamic cannot be converted to float"

**Cause**: react-native-svg incompatibility with AGP 8.x

**Solution**: Remove react-native-svg, use View components

```bash
npm uninstall react-native-svg
# Rewrite SVG components with View/Animated
```

### Issue: Reanimated module not found

**Cause**: Missing babel plugin

**Solution**: Add to `babel.config.js`:

```javascript
module.exports = {
  presets: ['module:@react-native/babel-preset'],
  plugins: ['react-native-reanimated/plugin'], // Must be last
};
```

### Issue: Build fails with "requires RN 0.74"

**Cause**: Using Reanimated 4.x or other newer libraries

**Solution**: Downgrade to compatible versions:

```bash
npm install react-native-reanimated@3.6.3
```

### Issue: Frame processor errors

**Cause**: VisionCamera frame processors need worklets

**Solution**: Remove frame processors, use manual capture:

```javascript
// Remove frameProcessor prop
// Use takePhoto() instead
const photo = await camera.current.takePhoto();
```

---

## 📦 Recommended Dependencies for Common Features

### Photo/Receipt Scanning App
```json
{
  "react-native-vision-camera": "^3.9.0",
  "react-native-image-picker": "^7.2.3",
  "@react-native-camera-roll/camera-roll": "^7.4.0",
  "react-native-fs": "^2.20.0",
  "react-native-sqlite-storage": "^6.0.1"
}
```

### Business/Productivity App
```json
{
  "react-native-sqlite-storage": "^6.0.1",
  "@react-native-async-storage/async-storage": "^1.24.0",
  "react-native-fs": "^2.20.0",
  "react-native-document-picker": "^9.3.1",
  "@react-native-community/netinfo": "^11.2.1"
}
```

### Animated UI App
```json
{
  "react-native-reanimated": "^3.6.3",
  "react-native-bootsplash": "^6.3.11",
  "@react-native-async-storage/async-storage": "^1.24.0"
}
```

---

## 🚀 Upgrading This Template

When React Native releases new versions:

1. **Test in separate branch** first
2. **Update dependencies** in this order:
   - React & React Native
   - Babel preset & Metro config
   - Native modules (check compatibility)
3. **Update this guide** with findings
4. **Trigger CI build** to validate
5. **Merge when stable**

---

## 📖 Resources

- [React Native Upgrade Helper](https://react-native-community.github.io/upgrade-helper/)
- [React Native Directory](https://reactnative.directory/) - Check library compatibility
- [AGP Release Notes](https://developer.android.com/studio/releases/gradle-plugin)
- [Reanimated Documentation](https://docs.swmansion.com/react-native-reanimated/)

---

**Last Updated**: January 2026 (Based on ReceiptKeeper production builds)
