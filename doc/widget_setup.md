# iOS Widget Extension Setup Guide

To make the widget appear on the iOS home screen, you need to create a **Widget Extension target**. This guide shows you how to do it step by step.

## ⚠️ Important

The Widget Extension target must be created **manually in Xcode**. This process cannot be done from the Flutter command line.

## Step 1: Open Project in Xcode

```bash
cd example/ios
open Runner.xcworkspace
```

**IMPORTANT:** Open the `.xcworkspace` file, not `.xcodeproj`!

## Step 2: Create Widget Extension Target

1. In Xcode, go to **File > New > Target** menu
2. Select **iOS** tab
3. Select **Widget Extension**
4. Click **Next** button
5. Configure the following settings:
   - **Product Name**: `SuperHomeWidgetExtension`
   - **Organization Identifier**: Same as your existing bundle identifier (e.g., `com.example`)
   - **Language**: **Swift**
   - **Include Configuration Intent**: ❌ **DO NOT CHECK**
6. Click **Finish** button
7. When asked "Activate 'SuperHomeWidgetExtension' scheme?", click **Cancel**

## Step 3: Replace Widget Extension Files

The Widget Extension target uses files in the `SuperHomeWidget` folder. These files need to be replaced with the correct package files.

1. In Xcode's left panel, find the **SuperHomeWidget** folder (inside SuperHomeWidgetExtension target)
2. **DELETE** the following template files:
   - `SuperHomeWidget.swift` (Xcode template - delete this)
   - `SuperHomeWidgetControl.swift` (if exists - delete this)
   - `SuperHomeWidgetLiveActivity.swift` (if exists - delete this)
   - `AppIntent.swift` (if exists - delete this)
3. **REPLACE** `SuperHomeWidgetBundle.swift` with the correct content (already done if you see this guide)
4. **ADD** the following files from the package to the **SuperHomeWidget** folder:
   - From package: `ios/Classes/WidgetTimelineProvider.swift`
   - From package: `ios/Classes/WidgetView.swift`
   - From package: `ios/Classes/StyleRenderer.swift`
   
   To add files:
   - Right-click on **SuperHomeWidget** folder
   - Select **Add Files to "SuperHomeWidgetExtension"...**
   - Navigate to package's `ios/Classes/` folder
   - Select the three Swift files
   - **IMPORTANT:** Check these options:
     - ✅ **Copy items if needed**
     - ✅ **Add to targets: SuperHomeWidgetExtension** (only this should be selected)
   - Click **Add** button

**Alternative:** If files are already in `SuperHomeWidget` folder, make sure they're the correct ones from the package, not Xcode templates.

## Step 4: Add App Group Capability

### For Main App (Runner):

1. In the left panel, select the **Runner** project
2. Select the **Runner** target
3. Go to **Signing & Capabilities** tab
4. Click the **+ Capability** button at the top left
5. Select **App Groups**
6. Click the **+** button
7. Enter App Group ID: `group.com.example.superhomewidget`
8. ✅ Check it

### For Widget Extension:

1. In the left panel, select the **SuperHomeWidgetExtension** target
2. Go to **Signing & Capabilities** tab
3. Click the **+ Capability** button at the top left
4. Select **App Groups**
5. Select the same App Group ID: `group.com.example.superhomewidget`
6. ✅ Check it

**IMPORTANT:** Both targets must have the same App Group ID!

## Step 5: Deployment Target Settings

1. Select the **SuperHomeWidgetExtension** target
2. Go to **General** tab
3. In the **Minimum Deployments** section:
   - Set **iOS** to `14.0`

## Step 6: Info.plist Check

The Widget Extension's `Info.plist` file should have the following settings:

1. In the left panel, find the `Info.plist` file in the **SuperHomeWidgetExtension** folder
2. Make sure it contains the following:

```xml
<key>NSExtension</key>
<dict>
    <key>NSExtensionPointIdentifier</key>
    <string>com.apple.widgetkit-extension</string>
</dict>
```

If it doesn't, open Info.plist in Xcode and add it in **Source Code** view.

## Step 7: Build and Test

1. In Xcode, select **Runner** from the scheme dropdown
2. Select a simulator or real device
3. Build with **Product > Build** (⌘B)
4. Run with **Product > Run** (⌘R)

## Step 8: Add Widget to Home Screen

1. After the app runs, go to the **home screen**
2. **Long press** on an empty area (jiggle mode)
3. Click the **+** button at the top left
4. Type **"Super Home Widget"** in the search box
5. Select the widget and choose its size (Small, Medium, Large)
6. Click **Add Widget** button

## Troubleshooting

### Widget not appearing:

✅ **Checklist:**
- [ ] Was the Widget Extension target created?
- [ ] Was WidgetBundle.swift added to the Widget Extension target?
- [ ] Were all Swift files (WidgetTimelineProvider, WidgetView, StyleRenderer) added?
- [ ] Was App Group configured in both targets?
- [ ] Do App Group IDs match? (`group.com.example.superhomewidget`)
- [ ] Is deployment target iOS 14.0+?
- [ ] Is `NSExtensionPointIdentifier` present in Info.plist?
- [ ] Did the build succeed?

### Build errors:

**"No such module 'WidgetKit'"**
- Make sure deployment target is iOS 14.0+

**"Use of unresolved identifier 'SuperHomeWidgetTimelineProvider'"**
- Make sure WidgetTimelineProvider.swift was added to the Widget Extension target

**"App Group not found"**
- Make sure App Group capability was added to both targets
- Make sure App Group IDs are the same

### Widget not showing data:

✅ **Checklist:**
- [ ] Was `SuperHomeWidget.initialize()` called on Flutter side?
- [ ] Is App Group ID the same in Flutter code and WidgetBundle.swift?
- [ ] Was data sent with `SuperHomeWidget.updateData()`?
- [ ] Was the Widget Extension built?

## Important Notes

1. **Widget Extension is a separate target** - It has its own bundle identifier
2. **App Group is required** - For data sharing between main app and widget extension
3. **iOS 14.0+ is required** - For WidgetKit framework
4. **Widgets update limited** - Due to iOS battery optimization

## Quick Check

To check if the widget is working:

1. In Xcode, select **Product > Scheme > SuperHomeWidgetExtension**
2. **Product > Build** (⌘B)
3. If build succeeds, the widget extension is properly configured
4. Select **Product > Scheme > Runner** again
5. Run the app with **Product > Run** (⌘R)

## Help

If you're still having issues:

1. In Xcode, do **Product > Clean Build Folder** (⇧⌘K)
2. Run `cd example/ios && pod install` in Terminal
3. Close and reopen Xcode
4. Build again
