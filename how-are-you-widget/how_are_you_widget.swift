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
    
    // 하루에 한번 업데이트가 발생하도록 하는 타임라인의 정책
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<Entry> {
        var entries: [Entry] = []

        let currentDate = Date()
        let nextUpdateDate = getNextUpdateDate()

        entries.append(Entry(date: currentDate, configuration: configuration))

        let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
        return timeline
    }
    
    private func getNextUpdateDate() -> Date {
        let currentDate = Date()
        let calendar = Calendar.current
        
        // 다음 날 자정의 시간을 계산한다.
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        dateComponents.day! += 1
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        let nextUpdateDate = calendar.date(from: dateComponents)!
        
        return nextUpdateDate
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct how_are_you_widgetEntryView: View {
    var entry: Provider.Entry
    
    @Environment(\.colorScheme) var colorScheme

    private enum FontConstants {
        static let titleFontSize: CGFloat = 12
        static let nameFontSize: CGFloat = 24
        static let daysAgoFontSize: CGFloat = 30
        static let verticalPadding: CGFloat = 12
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("최근 통화")
                    .font(.system(size: FontConstants.titleFontSize))
                    .foregroundStyle(.secondary)
                Text("어머니")
                    .fontWeight(.medium)
                    .font(.system(size: FontConstants.nameFontSize))

                Spacer()
                
                Text("8일 전")
                    .fontWeight(.semibold)
                    .font(.system(size: FontConstants.daysAgoFontSize))
                    .foregroundStyle(Color.red)

            }
            .padding(.vertical, FontConstants.verticalPadding)
            
            Spacer()
        }
        .padding()
    }
}

extension Color {
    static let lightColorGrade: Double = 240
    static let darkColorGrade: Double = 28
    static let lightBackground = Color(red: lightColorGrade / 255, green: lightColorGrade / 255, blue: lightColorGrade / 255)
    static let darkBackground = Color(red: darkColorGrade / 255, green: darkColorGrade / 255, blue: darkColorGrade / 255)
}
 
struct how_are_you_widget: Widget {
    let kind: String = "how_are_you_widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            how_are_you_widgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("위젯!")
        .description("예시 위젯입니다.")
        .contentMarginsDisabled()
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
