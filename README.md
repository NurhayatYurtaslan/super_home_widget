# Super Home Widget

[![Pub Version](https://img.shields.io/pub/v/super_home_widget)](https://pub.dev/packages/super_home_widget)
[![License: BSD-3-Clause](https://img.shields.io/badge/license-BSD--3--Clause-blue.svg)](LICENSE)

A customizable iOS home screen widget package for Flutter using Apple's WidgetKit framework. Supports multiple design styles including default and liquid glass themes.

## Features

- 🎨 **Multiple Design Styles**: Default and Liquid Glass themes
- 📱 **iOS Native**: Built specifically for iOS using WidgetKit (iOS 14+)
- ⚙️ **Fully Configurable**: JSON-based configuration for all styles and behaviors
- 📐 **Multiple Widget Sizes**: Small, Medium, and Large widget support
- 🔄 **Timeline Updates**: Automatic widget refresh with configurable intervals
- 🌊 **Liquid Glass Effect**: Modern glassmorphic design with blur, gradients, and highlights

## Architecture

### High-Level Architecture

```mermaid
graph TB
    A[Flutter App] -->|Widget Configuration| B[Config File<br/>JSON/YAML]
    A -->|Native Bridge| C[iOS Widget Extension]
    C -->|WidgetKit API| D[Widget Timeline Provider]
    D -->|Rendering| E[Widget Views]
    E -->|Style Application| F[Design Style Engine]
    F -->|Liquid Glass| G[Liquid Glass Renderer]
    F -->|Default| H[Default Renderer]
    B -->|Config Values| F
    I[App Group Container] -->|Shared Data| C
    A -->|Write Data| I
```

### Component Architecture

```mermaid
graph TB
    A[SuperHomeWidget Package] --> B[Config Parser]
    A --> C[Widget Builder]
    A --> D[Style Manager]
    A --> E[Native Bridge]
    
    B --> F[Config File]
    
    C --> G[Core Widget Layer]
    G --> H[BaseWidgetRender<br/>Abstract Base]
    H --> I[SmallWidget]
    H --> J[MediumWidget]
    H --> K[LargeWidget]
    
    D --> L[Widget Style Layer]
    L --> M[WidgetStyle<br/>Abstract Base]
    M --> N[DefaultStyle]
    M --> O[LiquidGlassStyle]
    
    L --> P[Style Config Layer]
    P --> Q[StyleConfig<br/>Abstract Base]
    Q --> R[DefaultStyleConfig]
    Q --> S[LiquidGlassStyleConfig]
    
    I -.->|Uses| N
    I -.->|Uses| O
    J -.->|Uses| N
    J -.->|Uses| O
    K -.->|Uses| N
    K -.->|Uses| O
    
    E --> T[iOS Widget Extension]
    T --> U[WidgetKit Timeline]
```

### Style-Widget Relationship

```mermaid
graph LR
    subgraph "Core Widget Structure"
        A[BaseWidgetRender]
        B[SmallWidget]
        C[MediumWidget]
        D[LargeWidget]
    end
    
    subgraph "Widget Style Structure"
        E[WidgetStyle]
        F[DefaultStyle]
        G[LiquidGlassStyle]
    end
    
    subgraph "Style Config Structure"
        H[StyleConfig]
        I[DefaultStyleConfig]
        J[LiquidGlassStyleConfig]
    end
    
    A -->|implements| B
    A -->|implements| C
    A -->|implements| D
    
    E -->|implements| F
    E -->|implements| G
    
    H -->|extends| I
    H -->|extends| J
    
    F -->|uses| I
    G -->|uses| J
    
    B -.->|composes| E
    C -.->|composes| E
    D -.->|composes| E
```

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  super_home_widget: ^1.0.0
```

Then run:

```bash
flutter pub get
```

> **Note:** Code generation is **NOT required**. This package uses manual JSON serialization. Just add the package and you're ready to go (after iOS setup).

## iOS Setup

### ⚠️ CRITICAL: Widget Extension Required

**You MUST create a Widget Extension target for the widget to appear on the iOS home screen.**

Without a Widget Extension target, the widget will NOT appear in the "Add Widget" screen.

**📖 Detailed setup guide:** [WIDGET_SETUP.md](WIDGET_SETUP.md)

**⚡ Quick start:**
1. Open `example/ios/Runner.xcworkspace` in Xcode
2. **File > New > Target** > Create **Widget Extension**
3. Add Swift files to Widget Extension target
4. Add App Group capability to both targets
5. Build and run

**See WIDGET_SETUP.md for detailed steps.**

### 1. Add Widget Extension Target

In Xcode, add a new Widget Extension target to your iOS app:

1. File → New → Target
2. Select "Widget Extension"
3. Name it (e.g., "SuperHomeWidgetExtension")

### 2. Configure App Groups

1. In your main app target, go to Signing & Capabilities
2. Add "App Groups" capability
3. Create a new group (e.g., `group.com.yourcompany.yourapp.widget`)
4. Add the same App Group to your Widget Extension target

### 3. Copy Swift Files

Copy the following files from the package's `ios/` folder to your Widget Extension:

- `Classes/WidgetTimelineProvider.swift`
- `Classes/WidgetView.swift`
- `Classes/StyleRenderer.swift`
- `WidgetExtension/WidgetBundle.swift`

### 4. Update App Group ID

In `WidgetBundle.swift`, update the `appGroupId`:

```swift
private let appGroupId = "group.com.yourcompany.yourapp.widget"
```

## Usage

### Basic Initialization

```dart
import 'package:super_home_widget/super_home_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the widget system
  await SuperHomeWidget.initialize(
    appGroupId: 'group.com.yourcompany.yourapp.widget',
  );
  
  runApp(MyApp());
}
```

### Update Widget Data

```dart
// Update data displayed in widgets
await SuperHomeWidget.updateData(WidgetData(
  title: 'Hello World',
  subtitle: 'Welcome to widgets',
  body: 'This is the main content',
  iconName: 'star.fill', // SF Symbol name
));
```

### Refresh Widgets

```dart
// Refresh all widgets
await SuperHomeWidget.refresh();

// Refresh specific widget size
await SuperHomeWidget.refresh(size: WidgetSize.small);
```

### Working with Styles

```dart
// Get style for a specific widget size
final style = SuperHomeWidget.getStyleForSize(WidgetSize.medium);

// Access style manager
final styleManager = SuperHomeWidget.styleManager;
final liquidGlass = styleManager?.liquidGlassStyle;
```

### Shared Data Storage

```dart
// Save data to shared container (accessible by widget extension)
await SuperHomeWidget.saveSharedData('user_name', 'John Doe');

// Read data from shared container
final name = await SuperHomeWidget.readSharedData('user_name');

// Delete data
await SuperHomeWidget.deleteSharedData('user_name');
```

### Listen for Widget Interactions

```dart
SuperHomeWidget.onWidgetClicked.listen((event) {
  print('Widget ${event.size} clicked!');
  print('Action: ${event.action}');
});
```

## Configuration

The widget system is configured via JSON. Default configuration is included, but you can customize it:

### Custom Configuration

```dart
await SuperHomeWidget.initialize(
  appGroupId: 'group.com.yourcompany.yourapp.widget',
  configPath: 'assets/custom_widget_config.json',
);
```

### Configuration Flow

```mermaid
sequenceDiagram
    participant App as Flutter App
    participant Asset as Asset Bundle
    participant Config as Config Parser
    participant Style as Style Manager
    participant Widget as Widget Builder
    participant Native as iOS Extension
    
    App->>Asset: Load config file from assets
    alt Custom config exists
        Asset->>Config: Provide custom JSON string
    else Custom config not found
        Asset-->>Config: File not found
        Config->>Config: Fall back to default package config
    end
    Config->>Config: Parse JSON
    Config->>Style: Initialize styles from config
    Style->>Style: Apply style rules from config
    App->>Widget: Build widget with config
    Widget->>Style: Get style properties from config
    Style->>Widget: Return style values
    Widget->>Native: Render widget with config
    Native->>Native: Apply visual effects from config
```

### Configuration Structure

```json
{
  "widget": {
    "id": "super_home_widget",
    "name": "Super Home Widget",
    "version": "1.0.0"
  },
  "styles": {
    "default": {
      "background": {
        "type": "solid",
        "color": "#FFFFFF",
        "opacity": 1.0
      },
      "cornerRadius": 16,
      "typography": {
        "fontFamily": "SF Pro",
        "titleSize": 20,
        "bodySize": 14,
        "captionSize": 12
      },
      "colors": {
        "primary": "#007AFF",
        "secondary": "#5856D6",
        "text": "#000000",
        "textSecondary": "#8E8E93"
      }
    },
    "liquidGlass": {
      "background": {
        "type": "frosted",
        "style": "systemMaterial",
        "opacity": 0.85,
        "blurRadius": 20
      },
      "cornerRadius": 20,
      "border": {
        "enabled": true,
        "width": 1.5,
        "color": "#FFFFFF",
        "opacity": 0.3
      },
      "gradient": {
        "enabled": true,
        "colors": ["#00D9FF20", "#FF6B9D20"],
        "angle": 135
      }
    }
  },
  "widgets": {
    "small": {
      "style": "default",
      "layout": "compact",
      "refreshInterval": 3600
    },
    "medium": {
      "style": "liquidGlass",
      "layout": "expanded",
      "refreshInterval": 1800
    },
    "large": {
      "style": "liquidGlass",
      "layout": "detailed",
      "refreshInterval": 900
    }
  }
}
```

## Widget Sizes

| Size | iPhone Dimensions | iPad Dimensions | Layout |
|------|-------------------|-----------------|--------|
| Small | 155×155 pt | 170×170 pt | Compact |
| Medium | 329×155 pt | 364×170 pt | Expanded |
| Large | 329×345 pt | 364×376 pt | Detailed |

```mermaid
graph TB
    A[iOS Widget Sizes] --> B[Small<br/>155x155pt]
    A --> C[Medium<br/>329x155pt]
    A --> D[Large<br/>329x345pt]
    
    B --> E[Compact Layout]
    C --> F[Expanded Layout]
    D --> G[Detailed Layout]
    
    E --> H[Minimal Content]
    F --> I[Moderate Content]
    G --> J[Rich Content]
```

## Design Styles

### Style Architecture

```mermaid
graph TB
    A[StyleConfig<br/>Abstract Base] --> B[Common Properties]
    B --> C[Background]
    B --> D[Corner Radius]
    B --> E[Padding]
    B --> F[Typography]
    B --> G[Colors]
    B --> H[Shadows]
    
    A --> I[DefaultStyleConfig]
    I --> J[Standard iOS Style]
    
    A --> K[LiquidGlassStyleConfig]
    K --> L[Base Properties]
    K --> M[Border Config]
    K --> N[Gradient Config]
    K --> O[Highlights Config]
    
    I --> P[DefaultStyle]
    K --> Q[LiquidGlassStyle]
    
    P --> R[Applied to Widgets]
    Q --> R
```

### Default Style

Clean, standard iOS widget appearance following Apple's Human Interface Guidelines:

- Solid backgrounds
- System fonts (SF Pro)
- Standard shadows
- 8pt grid system

### Liquid Glass Style

Modern glassmorphic effect with:

- Frosted glass background with blur
- Translucent layers
- Gradient overlays
- Reflective highlights
- Multi-layer shadows
- Subtle borders

### Style Comparison

```mermaid
graph TB
    A[WidgetStyle] --> B[DefaultStyle]
    A --> C[LiquidGlassStyle]
    
    B --> D[DefaultStyleConfig]
    D --> E[Solid Backgrounds]
    D --> F[Standard Shadows]
    D --> G[System Fonts]
    D --> H[Static Appearance]
    
    C --> I[LiquidGlassStyleConfig]
    I --> J[Base StyleConfig Properties]
    I --> K[Frosted Glass Background]
    I --> L[Multi-layer Shadows]
    I --> M[Border + Gradient + Highlights]
    
    B -.->|Applied to| N[Core Widgets]
    C -.->|Applied to| N
    N --> O[SmallWidget]
    N --> P[MediumWidget]
    N --> Q[LargeWidget]
```

## Data Flow

### Widget Update Flow

```mermaid
sequenceDiagram
    participant Timeline as Timeline Provider
    participant Config as Config Manager
    participant Data as Data Source
    participant Cache as Cache Manager
    participant Renderer as Widget Renderer
    
    Timeline->>Config: Request widget update
    Config->>Config: Get widget configuration
    Config->>Data: Fetch latest data
    Data->>Cache: Check cache validity
    alt Cache Valid
        Cache->>Renderer: Use cached data
    else Cache Invalid
        Data->>Data: Fetch new data
        Data->>Cache: Update cache
        Cache->>Renderer: Provide fresh data
    end
    Renderer->>Renderer: Apply style from config
    Renderer->>Timeline: Return widget view
```

### Data Sharing Architecture

```mermaid
graph TB
    A[Flutter App] -->|Write Data| B[App Group Container]
    B -->|Shared Storage| C[iOS Widget Extension]
    C -->|Read Data| D[Widget Timeline]
    D -->|Render| E[Widget View]
    
    F[Background Updates] -->|Fetch Data| G[Network/API]
    G -->|Store| B
    
    H[User Interaction] -->|Update Config| A
    A -->|Save Config| I[Config File]
    I -->|Load| C
```

## Technical Specifications

### Class Diagram

```mermaid
classDiagram
    class BaseWidgetRender {
        <<abstract>>
        +WidgetSize size
        +WidgetLayout layout
        +WidgetStyle style
        +WidgetData data
        +buildNativeConfig()
        +getDimensions()
    }
    
    class SmallWidget {
        +WidgetConfig config
        +buildContentConfig()
    }
    
    class MediumWidget {
        +WidgetConfig config
        +buildContentConfig()
    }
    
    class LargeWidget {
        +WidgetConfig config
        +buildContentConfig()
    }
    
    class WidgetStyle {
        <<abstract>>
        +StyleConfig config
        +String styleName
        +toNativeConfig()
        +getBackgroundConfig()
        +getTypographyConfig()
    }
    
    class DefaultStyle {
        +DefaultStyleConfig config
        +backgroundColor
        +cornerRadius
    }
    
    class LiquidGlassStyle {
        +LiquidGlassStyleConfig config
        +frostedBackground
        +blurRadius
        +border
        +gradient
    }
    
    class StyleConfig {
        <<abstract>>
        +BackgroundConfig background
        +double cornerRadius
        +PaddingConfig padding
        +TypographyConfig typography
        +ColorsConfig colors
    }
    
    class WidgetBuilder {
        +buildSmallWidget()
        +buildMediumWidget()
        +buildLargeWidget()
    }
    
    class StyleManager {
        +getStyle()
        +getStyleByName()
    }
    
    BaseWidgetRender <|-- SmallWidget
    BaseWidgetRender <|-- MediumWidget
    BaseWidgetRender <|-- LargeWidget
    
    WidgetStyle <|-- DefaultStyle
    WidgetStyle <|-- LiquidGlassStyle
    
    SmallWidget --> WidgetStyle : uses
    MediumWidget --> WidgetStyle : uses
    LargeWidget --> WidgetStyle : uses
    
    WidgetBuilder --> StyleManager : uses
    StyleManager --> WidgetStyle : creates
    WidgetBuilder --> BaseWidgetRender : creates
```

### iOS Requirements

- **Minimum iOS Version**: iOS 14.0+
- **Framework**: WidgetKit
- **App Groups**: Required for data sharing between app and widget extension
- **Capabilities**: 
  - Background Modes (Background fetch)
  - App Groups
  - Widget Extension target

### Flutter Integration

- **Platform Channels**: Method channels for Flutter-to-native communication
  - Method channel: `com.superhomewidget/widget`
  - Event channel: `com.superhomewidget/events`
- **Native Bridge**: `IOSBridge` class (singleton) handles all native communication
- **App Groups**: For data sharing with widget extension (UserDefaults with suite name)
- **No Code Generation Required**: All JSON serialization is manual (`fromJson`/`toJson`)

## Example

Check the `/example` folder for a complete implementation example.

## Requirements

- **iOS 14.0+** (WidgetKit minimum requirement)
- **Flutter SDK 3.10.4+**
- **Xcode 14+**

**Important**: Your app's iOS deployment target must be set to **iOS 14.0 or higher**:
- In `ios/Podfile`: `platform :ios, '14.0'`
- In Xcode project: `IPHONEOS_DEPLOYMENT_TARGET = 14.0`

## License

BSD 3-Clause License - see [LICENSE](LICENSE) for details.

## Author

Nurhayat Yurtaslan

## Contributing

Contributions are welcome! Please read our contributing guidelines before submitting a pull request.
