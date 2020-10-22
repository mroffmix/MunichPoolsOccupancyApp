//
//  ContentView.swift
//  watchApp Extension
//
//  Created by Ilya on 22.10.20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm: CounterVM
    private let placeholder = CounterResponseElement(organizationUnitID: 0, personCount: 0, maxPersonCount: 0)
    
    var body: some View {
        VStack (alignment: .center, spacing: 5) {
            Text("Bad Forstenrieder Park\nHallenbad")
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .font(.system(size: 12))
            Spacer().frame(height: 5, alignment: .center)
            
            ZStack {
                Ring(percent: .constant(vm.getPercents(for: vm.counters?.first ?? placeholder)), thickness: 8)
                    .padding()
                    .animation(.easeInOut)
                Text("\(vm.getPercentsLabel(for: vm.counters?.first ?? placeholder))%")
                    .font(.system(size: 20))
                    .foregroundColor(.green)
                    .bold()
                
            }
            .frame(width: 78, height: 70, alignment: .center)
            
            VStack {
                HStack {
                    Text("\(vm.counters?.first?.personCount ?? 0) /")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.green)
                        .animation(.easeInOut)
                    
                    Text("\(vm.counters?.first?.maxPersonCount ?? 0)")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.red)
                        .animation(.easeInOut)
                }
                Text("People in a pool")
                    .font(.system(size: 10))
            }
            
        }.onAppear {
            self.vm.onAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: CounterVM(service: MockCounterService()))
    }
}
