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
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(vm.counters ?? [], id: \.self) { element in
                        GroupBox {
                            HStack {
                                VStack (alignment: .leading) {
                                    Text(Pools.getTitle(for: String(element.organizationUnitID!)))
                                        .font(.system(size:20))
                                        .bold()
                                    HStack(spacing:5) {
                                        Text("\(element.personCount ?? 0)")
                                            .font(.system(size:25))
                                            .foregroundColor(.red)
                                            .bold()
                                        Text("/")
                                            .font(.system(size:20))
                                        //.bold()
                                        
                                        Text("\(element.maxPersonCount ?? 0)")
                                            .font(.system(size:25))
                                            .foregroundColor(.green)
                                            .bold()
                                    }
                                }
                                Spacer()
                                ZStack {
                                    Ring(percent: .constant(vm.getPercents(for: element)), thickness: 10)
                                        .padding()
                                    Text("\(vm.getPercentsLabel(for: element))%")
                                        .font(.title3)
                                        .foregroundColor(.red)
                                        .bold()
                                    
                                }
                                .frame(width: 100, height: 100, alignment: .center)
                            }
                        }.padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Pools in Munich")
        }
        .onAppear {
            vm.onAppear()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: CounterVM(service: MockCounterService()))
    }
}
