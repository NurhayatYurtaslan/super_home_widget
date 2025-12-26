import SwiftUI
import WidgetKit

/// Main widget view for Super Home Widget
@available(iOS 14.0, *)
struct SuperHomeWidgetView: View {
    let entry: SuperHomeWidgetEntry
    
    var body: some View {
        Group {
            switch entry.size {
            case .systemSmall:
                SmallWidgetView(entry: entry)
            case .systemMedium:
                MediumWidgetView(entry: entry)
            case .systemLarge:
                LargeWidgetView(entry: entry)
            default:
                MediumWidgetView(entry: entry)
            }
        }
    }
}

/// Small widget view (155x155 points)
@available(iOS 14.0, *)
struct SmallWidgetView: View {
    let entry: SuperHomeWidgetEntry
    
    var body: some View {
        let style = entry.styleConfig
        let data = entry.widgetData
        
        ZStack {
            // Background
            WidgetBackground(style: style)
            
            VStack(spacing: 8) {
                // Icon
                if let iconName = data.iconName {
                    Image(systemName: iconName)
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(Color(hex: style.primaryColor))
                }
                
                Spacer()
                
                // Title
                if let title = data.title, !title.isEmpty {
                    Text(title)
                        .font(.system(size: style.titleSize, weight: .semibold))
                        .foregroundColor(Color(hex: style.textColor))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
                
                // Subtitle
                if let subtitle = data.subtitle, !subtitle.isEmpty {
                    Text(subtitle)
                        .font(.system(size: style.captionSize))
                        .foregroundColor(Color(hex: style.textSecondaryColor))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
            }
            .padding(style.cornerRadius > 16 ? 16 : 12)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))
        .shadow(
            color: Color.black.opacity(style.shadowEnabled ? style.shadowOpacity : 0),
            radius: style.shadowRadius,
            x: 0,
            y: 2
        )
    }
}

/// Medium widget view (329x155 points)
@available(iOS 14.0, *)
struct MediumWidgetView: View {
    let entry: SuperHomeWidgetEntry
    
    var body: some View {
        let style = entry.styleConfig
        let data = entry.widgetData
        
        ZStack {
            // Background
            WidgetBackground(style: style)
            
            HStack(spacing: 16) {
                // Left section with icon/image
                VStack {
                    if let iconName = data.iconName {
                        Image(systemName: iconName)
                            .font(.system(size: 40, weight: .medium))
                            .foregroundColor(Color(hex: style.primaryColor))
                    }
                }
                .frame(width: 80)
                
                // Right section with text content
                VStack(alignment: .leading, spacing: 6) {
                    if let title = data.title, !title.isEmpty {
                        Text(title)
                            .font(.system(size: style.titleSize, weight: .semibold))
                            .foregroundColor(Color(hex: style.textColor))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    
                    if let subtitle = data.subtitle, !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.system(size: style.bodySize))
                            .foregroundColor(Color(hex: style.textSecondaryColor))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    
                    if let body = data.body, !body.isEmpty {
                        Text(body)
                            .font(.system(size: style.captionSize))
                            .foregroundColor(Color(hex: style.textSecondaryColor))
                            .lineLimit(2)
                            .minimumScaleFactor(0.7)
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .padding(16)
        }
        .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))
        .shadow(
            color: Color.black.opacity(style.shadowEnabled ? style.shadowOpacity : 0),
            radius: style.shadowRadius,
            x: 0,
            y: 4
        )
    }
}

/// Large widget view (329x345 points)
@available(iOS 14.0, *)
struct LargeWidgetView: View {
    let entry: SuperHomeWidgetEntry
    
    var body: some View {
        let style = entry.styleConfig
        let data = entry.widgetData
        
        ZStack {
            // Background
            WidgetBackground(style: style)
            
            VStack(alignment: .leading, spacing: 12) {
                // Header
                HStack {
                    if let iconName = data.iconName {
                        Image(systemName: iconName)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(Color(hex: style.primaryColor))
                    }
                    
                    if let title = data.title {
                        Text(title)
                            .font(.system(size: style.titleSize, weight: .bold))
                            .foregroundColor(Color(hex: style.textColor))
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    // Timestamp
                    Text(Date(), style: .time)
                        .font(.system(size: style.captionSize))
                        .foregroundColor(Color(hex: style.textSecondaryColor))
                }
                
                Divider()
                    .background(Color(hex: style.textSecondaryColor).opacity(0.3))
                
                // Main content
                VStack(alignment: .leading, spacing: 8) {
                    if let body = data.body, !body.isEmpty {
                        Text(body)
                            .font(.system(size: style.bodySize))
                            .foregroundColor(Color(hex: style.textColor))
                            .lineLimit(4)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                Spacer()
                
                // Footer
                if let subtitle = data.subtitle, !subtitle.isEmpty {
                    Text(subtitle)
                        .font(.system(size: style.captionSize))
                        .foregroundColor(Color(hex: style.textSecondaryColor))
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)
                }
            }
            .padding(20)
        }
        .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))
        .shadow(
            color: Color.black.opacity(style.shadowEnabled ? style.shadowOpacity : 0),
            radius: style.shadowRadius,
            x: 0,
            y: 4
        )
    }
}

/// Widget background view
@available(iOS 14.0, *)
struct WidgetBackground: View {
    let style: StyleConfigModel
    
    var body: some View {
        ZStack {
            // Base background
            if style.styleName == "liquidGlass" {
                // Frosted glass effect
                if #available(iOS 15.0, *) {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .opacity(style.backgroundOpacity)
                } else {
                    Rectangle()
                        .fill(Color(hex: style.backgroundColor).opacity(style.backgroundOpacity))
                        .blur(radius: style.blurRadius ?? 20)
                }
                
                // Gradient overlay
                if style.gradientEnabled && !style.gradientColors.isEmpty {
                    LinearGradient(
                        gradient: Gradient(colors: style.gradientColors.map { Color(hex: $0) }),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
                
                // Highlight effect
                if style.highlightsEnabled {
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(style.highlightsOpacity),
                            Color.clear
                        ]),
                        center: .topLeading,
                        startRadius: 0,
                        endRadius: 200
                    )
                }
                
                // Border
                if style.borderEnabled {
                    RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                        .stroke(
                            Color(hex: style.borderColor).opacity(style.borderOpacity),
                            lineWidth: style.borderWidth
                        )
                }
            } else {
                // Default solid background
                Rectangle()
                    .fill(Color(hex: style.backgroundColor).opacity(style.backgroundOpacity))
            }
        }
    }
}

// MARK: - Color Extension

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

