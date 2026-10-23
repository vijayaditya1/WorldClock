//
//  widget.swift
//  widget
//
//  Created by Aditya on 10/22/26.
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

struct TimeZoneCard: View {
    let city: String
    let code: String
    let timeZoneID: String
    let date: Date

    var body: some View {
        HStack(alignment: .center) {
            // First Column: City and Timezone code
            VStack(alignment: .leading, spacing: 1) {
                Text(city)
                    .font(.system(size: 13, weight: .bold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                Text(code)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            
            Spacer(minLength: 4)
            
            // Second Column: Large Time
            Text(formattedTime(for: date, in: timeZoneID))
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .minimumScaleFactor(0.8)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    func formattedTime(for date: Date, in identifier: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" // 24-hour format
        formatter.timeZone = TimeZone(identifier: identifier)
        return formatter.string(from: date)
    }
}

struct widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 12) {
                TimeZoneCard(city: "New Delhi", code: "IST", timeZoneID: "Asia/Kolkata", date: entry.date)
                TimeZoneCard(city: "New York", code: "EST", timeZoneID: "America/New_York", date: entry.date)
            }
            Divider()
            HStack(spacing: 12) {
                TimeZoneCard(city: "London", code: "GMT", timeZoneID: "Europe/London", date: entry.date)
                TimeZoneCard(city: "Los Angeles", code: "PST", timeZoneID: "America/Los_Angeles", date: entry.date)
            }
        }
        .padding(.horizontal, 2)
    }
}

struct widget: Widget {
    let kind: String = "widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            widgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}
