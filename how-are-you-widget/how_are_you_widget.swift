//
//  how_are_you_widget.swift
//  how-are-you-widget
//
//  Created by 이상현 on 3/15/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct how_are_you_widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            //Color(red: 28 / 255, green: 28 / 255, blue: 28 / 255)
            HStack {
                VStack(alignment: .leading) {
                    Text("최근 통화")
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                    
                    Text("어머니")
                        .fontWeight(.medium)
                        .font(.system(size: 24))
                    
                    Spacer()

                    Text("8일 전")
                        .fontWeight(.semibold)
                        .font(.system(size: 30))
                        .foregroundStyle(Color.red)
                }
                .padding(.vertical, 12)
                
                Spacer()
            }
        }
    }
}

struct how_are_you_widget: Widget {
    let kind: String = "how_are_you_widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            how_are_you_widgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    how_are_you_widget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
