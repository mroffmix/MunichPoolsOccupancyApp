//
//  SmallCounterWidgetView.swift
//  CounterWidgetExtension
//
//  Created by Ilya on 22.10.20.
//

import SwiftUI
import WidgetKit

struct SmallCounterWidgetView: View {
    
    @ObservedObject var vm: WidgetCounterVM
    var body: some View {
        VStack {
            ZStack {
                Ring(percent: .constant(vm.getPercents()), thickness: 5)
                    .padding()
                Text("\(vm.getPercentsLabel())%")
                    .font(.body)
                    .foregroundColor(.red)
                    .bold()
                
            }
            .frame(width: 100, height: 80, alignment: .center)
            
            Text("Bad Forstenrieder Park\nHallenbad")
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .font(.system(size: 13))
        }
    }
}

struct SmallCounterWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SmallCounterWidgetView(vm: WidgetCounterVM(PreviewBuilder.getCounter()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
