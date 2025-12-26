# Widget Troubleshooting Guide

If the widget is not appearing in the "Add Widget" screen, follow these steps:

## Quick Checklist

- [ ] Widget Extension target created in Xcode
- [ ] All Swift files added to Widget Extension target
- [ ] App Group configured in both Runner and Widget Extension
- [ ] App Group IDs match exactly
- [ ] Deployment target is iOS 14.0+
- [ ] Info.plist has `NSExtensionPointIdentifier`
- [ ] Widget Extension builds successfully
- [ ] App Group entitlements file exists for Widget Extension

## Step-by-Step Verification

### 1. Verify Widget Extension Builds

In Xcode:
1. Select **SuperHomeWidgetExtension** from scheme dropdown
2. **Product > Build** (⌘B)
3. Check for any build errors

**Common errors:**
- "No such module 'WidgetKit'" → Deployment target must be iOS 14.0+
- "Use of unresolved identifier" → Swift files not added to target
- "App Group not found" → Entitlements not configured

### 2. Verify App Group Configuration

**Runner target:**
- Go to **Signing & Capabilities**
- Check **App Groups** capability exists
- App Group ID: `group.com.example.superhomewidget`

**Widget Extension target:**
- Go to **Signing & Capabilities**
- Check **App Groups** capability exists
- Same App Group ID: `group.com.example.superhomewidget`

**Important:** Both must have the EXACT same App Group ID!

### 3. Verify Files Are Correct

Check `SuperHomeWidget` folder contains:
- ✅ `SuperHomeWidgetBundle.swift` (with `@main` and correct widget definition)
- ✅ `WidgetTimelineProvider.swift` (from package)
- ✅ `WidgetView.swift` (from package)
- ✅ `StyleRenderer.swift` (from package)
- ✅ `Info.plist` (with `NSExtensionPointIdentifier`)
- ✅ `SuperHomeWidget.entitlements` (with App Group)

**Delete these if they exist:**
- ❌ `SuperHomeWidget.swift` (Xcode template)
- ❌ `AppIntent.swift` (Xcode template)
- ❌ `SuperHomeWidgetControl.swift` (Xcode template)
- ❌ `SuperHomeWidgetLiveActivity.swift` (Xcode template)

### 4. Verify Deployment Target

**Widget Extension target:**
- **General** tab
- **Minimum Deployments** > **iOS**: `14.0` (NOT 26.2 or higher!)

### 5. Clean and Rebuild

```bash
cd example
flutter clean
cd ios
pod install
cd ..
flutter run
```

Or in Xcode:
1. **Product > Clean Build Folder** (⇧⌘K)
2. **Product > Build** (⌘B) for Widget Extension
3. **Product > Build** (⌘B) for Runner
4. **Product > Run** (⌘R)

### 6. Check Console Logs

When running the app, check Xcode console for:
- Widget Extension build errors
- App Group access errors
- Widget registration errors

### 7. Verify Widget Bundle

In `SuperHomeWidgetBundle.swift`, ensure:
- `@main` attribute is present
- `SuperHomeWidget()` is in the bundle body
- `configurationDisplayName` is set
- `supportedFamilies` includes desired sizes

### 8. Test Widget Extension Directly

1. In Xcode, select **SuperHomeWidgetExtension** scheme
2. **Product > Run** (⌘R)
3. This will install the widget extension
4. Then switch back to **Runner** scheme and run the main app

### 9. Check Simulator/Device

**On Simulator:**
- Make sure you're using iOS 14.0+ simulator
- Try deleting the app and reinstalling
- Restart the simulator

**On Real Device:**
- Make sure device is iOS 14.0+
- Check device logs in Xcode
- Try deleting the app and reinstalling

### 10. Verify Widget Appears in System

After building and running:
1. Go to home screen
2. Long press empty area
3. Tap **+** button
4. Search for **"Super Home Widget"**

If it still doesn't appear:
- Check Xcode build logs for Widget Extension
- Verify Widget Extension was embedded in the app bundle
- Check that Widget Extension has valid code signing

## Common Issues and Solutions

### Issue: "Widget not found in Add Widget screen"

**Solution:**
1. Make sure Widget Extension builds successfully
2. Verify `@main` attribute in `SuperHomeWidgetBundle.swift`
3. Check `NSExtensionPointIdentifier` in Info.plist
4. Ensure deployment target is iOS 14.0+

### Issue: "App Group mismatch"

**Solution:**
1. Check `Runner.entitlements` has: `group.com.example.superhomewidget`
2. Check `SuperHomeWidget.entitlements` has: `group.com.example.superhomewidget`
3. Check `SuperHomeWidgetBundle.swift` uses: `group.com.example.superhomewidget`
4. Check Flutter code uses: `group.com.example.superhomewidget`
5. All must match EXACTLY!

### Issue: "Build cycle error"

**Solution:**
- Build phases order should be:
  1. Sources
  2. Frameworks
  3. Resources
  4. Embed Foundation Extensions (Widget Extension)
  5. Thin Binary

### Issue: "Widget shows but no data"

**Solution:**
1. Verify `SuperHomeWidget.initialize()` was called
2. Check App Group IDs match
3. Verify `SuperHomeWidget.updateData()` was called
4. Check Widget Extension can read from App Group

## Still Not Working?

1. **Check Xcode build logs** for Widget Extension errors
2. **Verify Widget Extension scheme** builds successfully
3. **Check device/simulator logs** for runtime errors
4. **Try creating a new Widget Extension target** from scratch
5. **Verify all files are in the correct target** in Xcode

## Debug Commands

```bash
# Clean everything
cd example
flutter clean
cd ios
rm -rf Pods Podfile.lock
pod install
cd ../..
flutter pub get

# Check Widget Extension exists
find example/build/ios -name "*.appex" -type d

# Check entitlements
plutil -p example/ios/Runner/Runner.entitlements
plutil -p example/ios/SuperHomeWidget/SuperHomeWidget.entitlements
```

