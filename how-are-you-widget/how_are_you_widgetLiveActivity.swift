//
//  how_are_you_widgetLiveActivity.swift
//  how-are-you-widget
//
//  Created by 이상현 on 3/15/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct how_are_you_widgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct how_are_you_widgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: how_are_you_widgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension how_are_you_widgetAttributes {
    fileprivate static var preview: how_are_you_widgetAttributes {
        how_are_you_widgetAttributes(name: "World")
    }
}

extension how_are_you_widgetAttributes.ContentState {
    fileprivate static var smiley: how_are_you_widgetAttributes.ContentState {
        how_are_you_widgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: how_are_you_widgetAttributes.ContentState {
         how_are_you_widgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: how_are_you_widgetAttributes.preview) {
   how_are_you_widgetLiveActivity()
} contentStates: {
    how_are_you_widgetAttributes.ContentState.smiley
    how_are_you_widgetAttributes.ContentState.starEyes
}
