//
//  CounterWidget.swift
//  CounterWidget
//
//  Created by Ilya on 22.10.20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), counter: CounterResponse())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
        let urlStr = "https://functions.api.ticos-systems.cloud/api/gates/counter?organizationUnitIds=30194"
        guard let url = URL(string: urlStr) else {
            _ = URLError(.badURL)
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        
        request.httpMethod = "GET"
        let authHandler: AuthHandlerType = AuthHandler(tenantId: "69")
        authHandler.setHeaders(to: &request)
        
        let session = URLSession.shared
        
        session.dataTask(with: request) {  (data, response, error) in
            guard let data = data else {
                return
            }
            
            if let dataParse = try? JSONDecoder().decode(CounterResponse.self, from: data) {
                let entry = SimpleEntry(date: Date(), counter: dataParse)
                completion(entry)
            } else {
                completion(SimpleEntry(date: Date(), counter: CounterResponse()))
            }
        }.resume()
        
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        
        let entryDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        
        
        let urlStr = "https://functions.api.ticos-systems.cloud/api/gates/counter?organizationUnitIds=30194"
        guard let url = URL(string: urlStr) else {
            _ = URLError(.badURL)
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        
        request.httpMethod = "GET"
        let authHandler: AuthHandlerType = AuthHandler(tenantId: "69")
        authHandler.setHeaders(to: &request)
        
        let session = URLSession.shared
        
        session.dataTask(with: request) {  (data, response, error) in
            guard let data = data else {
                return
            }
            
            if let dataParse = try? JSONDecoder().decode(CounterResponse.self, from: data) {
                let entry = SimpleEntry(date: entryDate, counter: dataParse)
                entries.append(entry)
                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)
            } else {
                return
            }
        }.resume()
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var counter: CounterResponse
}

struct CounterWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    @ViewBuilder
    var body: some View {
        
        switch family {
        case .systemSmall:
            SmallCounterWidgetView(vm: WidgetCounterVM(entry.counter))
        case .systemLarge:
            CounterWidgetView(vm: WidgetCounterVM(entry.counter))
        default:
            CounterWidgetView(vm: WidgetCounterVM(entry.counter))
        }
        
    }
}

@main
struct CounterWidget: Widget {
    let kind: String = "CounterWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CounterWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}



struct CounterWidget_Previews: PreviewProvider {
    static var previews: some View {
        CounterWidgetEntryView(entry: SimpleEntry(date: Date(), counter: PreviewBuilder.getCounter()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
