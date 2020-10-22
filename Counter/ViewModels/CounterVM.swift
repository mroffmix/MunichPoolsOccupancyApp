//
//  CounterVM.swift
//  Counter
//
//  Created by Ilya on 22.10.20.
//

import Foundation
import SwiftUI
import Combine

protocol PCounterVM {
    var counters: CounterResponse? { get set }
}

class CounterVM: PCounterVM, ObservableObject {
    
    private var service: WebServiceType
    @Published var counters: CounterResponse?
    private var publisher: AnyPublisher<CounterResponse, Error>?
    private var subscriptions = Set<AnyCancellable>()
    
    internal init(service: WebServiceType) {
        self.service = service
        publisher = service.get(ids: Pools.ids)
        
        publisher?.sink(receiveCompletion: { (error) in
            print("Request failed: \(String(describing: error))")
            
        }, receiveValue: { [self] (result) in
            print(result)
            self.counters = result
        }).store(in: &subscriptions)
    }
    
    func onAppear() {
        publisher = service.get(ids: Pools.ids)
        
        publisher?.sink(receiveCompletion: { (error) in
            print("Request failed: \(String(describing: error))")
            
        }, receiveValue: { [self] (result) in
            print(result)
            self.counters = result
        }).store(in: &subscriptions)
    }
    
    func getPercentsLabel(for element: CounterResponseElement) -> String {
        let formattedPercent = String(format: "%.f", CGFloat(self.getPercents(for: element)))
        return formattedPercent
    }
    
    func getPercents(for element: CounterResponseElement) -> Double {
        
        return Double((element.personCount ?? 0) * 100 / (element.maxPersonCount ?? 0))
        //max*current/100
    }
    
}

class WidgetCounterVM: PCounterVM, ObservableObject {
    
    @Published var counters: CounterResponse?
    
    init(_ counter: CounterResponse) {
        self.counters = counter
    }
    
    func getPercentsLabel() -> String {
        let formattedPercent = String(format: "%.f", CGFloat(self.getPercents()))
        return formattedPercent
    }
    
    func getPercents() -> Double {
        if let el = self.counters?.first {
            return Double((el.personCount ?? 0) * 100 / (el.maxPersonCount ?? 0))
        }
        return 0
    }
}



