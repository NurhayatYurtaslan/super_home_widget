# Super Home Widget Example

This is an example Flutter application demonstrating how to use the Super Home Widget package.

## Features

- Initialize Super Home Widget with custom configuration
- Update widget data (title, subtitle, body, icon)
- Select widget size (small, medium, large)
- Refresh all widgets
- Real-time widget updates

## Setup

1. **iOS Configuration**: Make sure you have:
   - iOS 14.0+ deployment target
   - Widget Extension target configured
   - App Group configured with ID: `group.com.example.superhomewidget`

2. **Configuration File**: The example uses a custom configuration file located at:
   - `assets/config/widget_config.json`

3. **Run the App**:
   ```bash
   cd example
   flutter pub get
   flutter run
   ```

## Usage

1. Launch the app
2. Fill in the widget data fields:
   - Title: Main heading text
   - Subtitle: Secondary text
   - Body: Main content text
   - Icon Name: SF Symbol name (e.g., `star.fill`)
3. Select the widget size you want to update
4. Tap "Update Widget" to send data to the widget
5. Go to your iOS home screen and add the widget
6. The widget will display the updated content

## Widget Configuration

The configuration file (`assets/config/widget_config.json`) contains:
- Widget metadata (id, name, version)
- Style configuration (liquid glass with frosted background)
- Widget size configurations (small, medium, large)
- Initial data for the widget

## Notes

- The app uses App Group ID: `group.com.example.superhomewidget`
- Make sure this App Group is configured in your Xcode project
- The widget extension must be properly set up in Xcode
- See the main package README for detailed setup instructions
