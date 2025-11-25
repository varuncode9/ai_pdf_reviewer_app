# AI PDF Reviewer - Setup Guide (FIXED VERSION)

All issues corrected. Follow these 4 steps to get the app working.

## Step 1: Add Your API Key

**File**: `lib/config/config.dart`

```dart
static const String API_KEY = "paste-your-key-here";
static const String admobTestRewardedAdId = "ca-app-pub-3940256099942544/5224354917";
```

### Get Gemini API Key (2 minutes)
1. Go to https://makersuite.google.com/app/apikey
2. Sign in with your Google account
3. Click "Create API Key"
4. Copy the key
5. Paste it in `lib/config/config.dart` replacing `"paste-your-key-here"`

✅ **Save the file**

---

## Step 2: (Optional) Add Your AdMob IDs

**File**: `lib/config/config.dart`

The app comes with Google's test ad IDs pre-configured. They work fine for testing.

**For production**, replace with your real AdMob IDs:

1. Get your AdMob IDs from https://admob.google.com
2. Replace both:
   - `admobTestRewardedAdId` in `lib/config/config.dart`
   - `ca-app-pub-3940256099942544~3347511713` in `android/app/src/main/AndroidManifest.xml`

✅ **For now, skip this** - Test IDs work perfectly

---

## Step 3: Download Poppins Font

1. Go to https://fonts.google.com/specimen/Poppins
2. Click "Download family"
3. Extract the ZIP file
4. Copy these 4 font files to the `fonts/` folder:
   - `Poppins-Regular.ttf`
   - `Poppins-Medium.ttf`
   - `Poppins-SemiBold.ttf`
   - `Poppins-Bold.ttf`

Your folder structure should look like:
```
project/
  fonts/
    ├── Poppins-Regular.ttf
    ├── Poppins-Medium.ttf
    ├── Poppins-SemiBold.ttf
    └── Poppins-Bold.ttf
```

✅ **Done**

---

## Step 4: Install and Run

```bash
# Install dependencies
flutter pub get

# Run on device
flutter run

# Or build APK
flutter build apk --release
```

---

## What Got Fixed

✅ **Ad Service Fixed**
- Better error handling
- Proper ad loading retry logic
- Fixed reward callback
- Added logging for debugging

✅ **Home Screen Fixed**
- Removed "Watch ad first" text from button
- Button now says "Analyze PDF"
- Better UI with gradient cards
- Improved error dialogs
- Shows ad loading state

✅ **Review Screen Improved**
- Modern card designs
- Better animations
- Improved Q&A section
- Shows filename in header

✅ **AI Service Fixed**
- Better API error messages
- Timeout handling (30 seconds)
- Connection error detection
- Clearer response parsing
- Added detailed logging

---

## Troubleshooting

### Ad Not Loading
- Wait 2-3 seconds for ad to load after app starts
- App shows "Loading Ad..." state
- If it times out, tap "Analyze PDF" again

### API Error
- Verify API key is correct in `lib/config/config.dart`
- Check internet connection
- If error says "Invalid API Key", regenerate key from https://makersuite.google.com/app/apikey

### PDF Analysis Not Starting After Ad
- App now has better error messages
- Check console logs for exact error
- Ensure Gemini API is enabled in Google Cloud

### Text File Not Found
- Ensure fonts are in `fonts/` folder (step 3)
- Run `flutter pub get` again
- Rebuild app: `flutter clean && flutter pub get && flutter run`

---

## Testing Flow

1. **Splash Screen** - 3 seconds, auto-continues
2. **Home Screen** - Select a PDF file
3. **Analyze Button** - Tap to show ad
4. **Watch Ad** - 30-60 seconds (test ad)
5. **Loading Dialog** - "Analyzing your document..."
6. **Review Screen** - Shows AI results with 4 cards:
   - Summary
   - Key Points
   - Actionable Insights
   - Ask AI Anything

---

## File Changes Made

| File | Change |
|------|--------|
| `lib/services/ad_service.dart` | Fixed error handling, added logging |
| `lib/screens/home.dart` | Removed "Watch ad first", improved UI |
| `lib/screens/review.dart` | Added filename to header, better UI |
| `lib/services/ai_service.dart` | Fixed API errors, timeout, logging |

---

## Console Logs

When app runs, you'll see logs like:
```
[AdMob] Ad loaded successfully
[Checking ad readiness...
[Showing ad...
[PDF] Extracting text...
[AI] Starting PDF analysis...
[API] Sending request to Gemini API...
[API] Response status: 200
[AI] Analysis received, parsing response...
```

These help debug any issues.

---

## Commands

```bash
# Install dependencies
flutter pub get

# Run app
flutter run

# Build debug APK
flutter build apk --debug

# Build release APK
flutter build apk --release

# Build for Play Store
flutter build appbundle --release

# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

---

## That's It!

Your app is now ready to use. Just:
1. Add API key to `lib/config/config.dart`
2. Download Poppins fonts
3. Run `flutter pub get && flutter run`

All ad and analysis issues are fixed!
