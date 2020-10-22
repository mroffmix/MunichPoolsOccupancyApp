//
//  ContentView.swift
//  Counter
//
//  Created by Ilya on 22.10.20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm: CounterVM
    var body: some View {
        
        HStack {
            VStack (alignment: .leading) {
                Text("Bad Forstenrieder Park\nHallenbad")
                    .font(.title3)
                    .bold()
                HStack {
                        Text("\(vm.counter?.first?.personCount ?? 0)")
                            .font(.title)
                            .foregroundColor(.green)
                            .bold()
                            
                        
                        Text("\(vm.counter?.first?.maxPersonCount ?? 0)")
                            .font(.title)
                            .foregroundColor(.red)
                            .bold()
                }
            }
            Spacer()
            ZStack {
                Ring(percent: .constant(vm.getPercents()))
                    .padding()
                Text("\(vm.getPercentsLabel())%")
                    .font(.title3)
                    .foregroundColor(.green)
                    .bold()
                
            }
            .frame(width: 100, height: 100, alignment: .center)
        }.padding()
        
       
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: CounterVM(service: MockCounterService()))
    }
}
