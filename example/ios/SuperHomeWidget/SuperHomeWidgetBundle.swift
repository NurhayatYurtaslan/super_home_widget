import WidgetKit
import SwiftUI

/// Super Home Widget Bundle
/// This file should be added to the Widget Extension target in the host app
@available(iOS 14.0, *)
@main
struct SuperHomeWidgetBundle: WidgetBundle {
    var body: some Widget {
        SuperHomeWidget()
    }
}

/// Main Widget Definition
@available(iOS 14.0, *)
struct SuperHomeWidget: Widget {
    let kind: String = "SuperHomeWidget"
    
    // IMPORTANT: Replace with your actual App Group ID
    private let appGroupId = "group.com.example.superhomewidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: SuperHomeWidgetTimelineProvider(
                appGroupId: appGroupId,
                widgetSize: .systemMedium
            )
        ) { entry in
            SuperHomeWidgetView(entry: entry)
        }
        .configurationDisplayName("Super Home Widget")
        .description("A customizable home screen widget")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

/// Preview Provider for SwiftUI Canvas
@available(iOS 14.0, *)
struct SuperHomeWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Small widget preview
            SuperHomeWidgetView(entry: previewEntry(size: .systemSmall))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDisplayName("Small Widget")
            
            // Medium widget preview
            SuperHomeWidgetView(entry: previewEntry(size: .systemMedium))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .previewDisplayName("Medium Widget")
            
            // Large widget preview
            SuperHomeWidgetView(entry: previewEntry(size: .systemLarge))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .previewDisplayName("Large Widget")
        }
    }
    
    static func previewEntry(size: WidgetFamily) -> SuperHomeWidgetEntry {
        SuperHomeWidgetEntry(
            date: Date(),
            widgetData: WidgetDataModel(from: [
                "title": "Hello World",
                "subtitle": "Welcome to Super Home Widget",
                "body": "This is a preview of the widget content.",
                "iconName": "star.fill"
            ]),
            styleConfig: StyleConfigModel.defaultStyle,
            size: size
        )
    }
}
