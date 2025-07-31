# AdMob Configuration for Android

## Steps to configure AdMob:

1. **Create AdMob account**: https://admob.google.com
2. **Add your app** to AdMob console
3. **Create ad units** for different ad types:
   - Banner Ad
   - Interstitial Ad  
   - Rewarded Video Ad

## Configuration files needed:

### 1. Add to android/app/build.gradle.kts:
```kotlin
dependencies {
    implementation("com.google.android.gms:play-services-ads:23.6.0")
}
```

### 2. Add to android/app/src/main/AndroidManifest.xml:
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"/>
```

### 3. Update .env file with your actual AdMob IDs:
- Replace `your_admob_app_id` with your actual App ID
- Replace ad unit IDs with actual ones from AdMob console

## Test IDs (use during development):
- App ID: ca-app-pub-3940256099942544~3347511713
- Banner: ca-app-pub-3940256099942544/6300978111
- Interstitial: ca-app-pub-3940256099942544/1033173712
- Rewarded: ca-app-pub-3940256099942544/5224354917