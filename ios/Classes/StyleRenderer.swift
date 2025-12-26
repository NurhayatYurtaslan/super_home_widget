import SwiftUI

/// Style renderer for converting configuration to visual styles
@available(iOS 14.0, *)
struct StyleRenderer {
    let config: StyleConfigModel
    
    init(config: StyleConfigModel) {
        self.config = config
    }
    
    // MARK: - Color Accessors
    
    var primaryColor: Color {
        Color(hex: config.primaryColor)
    }
    
    var secondaryColor: Color {
        Color(hex: config.secondaryColor)
    }
    
    var textColor: Color {
        Color(hex: config.textColor)
    }
    
    var textSecondaryColor: Color {
        Color(hex: config.textSecondaryColor)
    }
    
    var backgroundColor: Color {
        Color(hex: config.backgroundColor)
    }
    
    var borderColor: Color {
        Color(hex: config.borderColor)
    }
    
    // MARK: - Font Accessors
    
    var titleFont: Font {
        .system(size: config.titleSize, weight: .semibold, design: fontDesign)
    }
    
    var bodyFont: Font {
        .system(size: config.bodySize, weight: .regular, design: fontDesign)
    }
    
    var captionFont: Font {
        .system(size: config.captionSize, weight: .regular, design: fontDesign)
    }
    
    private var fontDesign: Font.Design {
        if config.fontFamily.lowercased().contains("rounded") {
            return .rounded
        } else if config.fontFamily.lowercased().contains("mono") {
            return .monospaced
        } else if config.fontFamily.lowercased().contains("serif") {
            return .serif
        }
        return .default
    }
    
    // MARK: - Layout Values
    
    var cornerRadius: CGFloat {
        CGFloat(config.cornerRadius)
    }
    
    var borderWidth: CGFloat {
        CGFloat(config.borderWidth)
    }
    
    var borderOpacity: Double {
        config.borderOpacity
    }
    
    // MARK: - Shadow
    
    var shadowColor: Color {
        Color.black.opacity(config.shadowOpacity)
    }
    
    var shadowRadius: CGFloat {
        CGFloat(config.shadowRadius)
    }
    
    // MARK: - Gradient
    
    var gradientColors: [Color] {
        config.gradientColors.map { Color(hex: $0) }
    }
    
    var gradientStartPoint: UnitPoint {
        angleToStartPoint(config.gradientAngle)
    }
    
    var gradientEndPoint: UnitPoint {
        angleToEndPoint(config.gradientAngle)
    }
    
    private func angleToStartPoint(_ angle: Double) -> UnitPoint {
        let radians = angle * .pi / 180
        let x = 0.5 - cos(radians) * 0.5
        let y = 0.5 - sin(radians) * 0.5
        return UnitPoint(x: x, y: y)
    }
    
    private func angleToEndPoint(_ angle: Double) -> UnitPoint {
        let radians = angle * .pi / 180
        let x = 0.5 + cos(radians) * 0.5
        let y = 0.5 + sin(radians) * 0.5
        return UnitPoint(x: x, y: y)
    }
    
    // MARK: - Style Application Methods
    
    /// Apply text style to a Text view
    func applyTitleStyle(_ text: Text) -> some View {
        text
            .font(titleFont)
            .foregroundColor(textColor)
    }
    
    func applyBodyStyle(_ text: Text) -> some View {
        text
            .font(bodyFont)
            .foregroundColor(textColor)
    }
    
    func applyCaptionStyle(_ text: Text) -> some View {
        text
            .font(captionFont)
            .foregroundColor(textSecondaryColor)
    }
    
    /// Create background view modifier
    @ViewBuilder
    func backgroundView() -> some View {
        if config.styleName == "liquidGlass" {
            liquidGlassBackground()
        } else {
            defaultBackground()
        }
    }
    
    @ViewBuilder
    private func defaultBackground() -> some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(backgroundColor.opacity(config.backgroundOpacity))
            .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: 2)
    }
    
    @ViewBuilder
    private func liquidGlassBackground() -> some View {
        ZStack {
            // Blur background
            if #available(iOS 15.0, *) {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .opacity(config.backgroundOpacity)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(backgroundColor.opacity(config.backgroundOpacity))
            }
            
            // Gradient overlay
            if config.gradientEnabled {
                LinearGradient(
                    gradient: Gradient(colors: gradientColors),
                    startPoint: gradientStartPoint,
                    endPoint: gradientEndPoint
                )
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            }
            
            // Highlight
            if config.highlightsEnabled {
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(config.highlightsOpacity),
                        Color.clear
                    ]),
                    center: .topLeading,
                    startRadius: 0,
                    endRadius: 200
                )
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            }
            
            // Border
            if config.borderEnabled {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(borderColor.opacity(borderOpacity), lineWidth: borderWidth)
            }
        }
        .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: 4)
    }
}

// MARK: - View Modifier

@available(iOS 14.0, *)
struct WidgetStyleModifier: ViewModifier {
    let renderer: StyleRenderer
    
    func body(content: Content) -> some View {
        content
            .background(renderer.backgroundView())
            .clipShape(RoundedRectangle(cornerRadius: renderer.cornerRadius, style: .continuous))
    }
}

@available(iOS 14.0, *)
extension View {
    func widgetStyle(using renderer: StyleRenderer) -> some View {
        modifier(WidgetStyleModifier(renderer: renderer))
    }
}

