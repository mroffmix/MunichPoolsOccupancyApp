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
    var counter: CounterResponse? { get set }
}

class CounterVM: PCounterVM, ObservableObject {
    
    private var service: WebServiceType
    @Published var counter: CounterResponse?
    private var publisher: AnyPublisher<CounterResponse, Error>?
    private var subscriptions = Set<AnyCancellable>()
    
    internal init(service: WebServiceType) {
        self.service = service
        publisher = service.get(id: "30194")
        
        publisher?.sink(receiveCompletion: { (error) in
            print("Request failed: \(String(describing: error))")
            
        }, receiveValue: { [self] (result) in
            print(result)
            self.counter = result
        }).store(in: &subscriptions)
    }
    
    func getPercentsLabel() -> String {
        let formattedPercent = String(format: "%.f", CGFloat(self.getPercents()))
        return formattedPercent
    }
    
    func getPercents() -> Double {
        if let el = self.counter?.first {
            return Double((el.maxPersonCount ?? 0) * (el.personCount ?? 0) / 100)
        }
        return 0
        //max*current/100
    }
    
}


class WidgetCounterVM: PCounterVM, ObservableObject {
    
    @Published var counter: CounterResponse?
    
    init(_ counter: CounterResponse) {
        self.counter = counter
    }
    
    func getPercentsLabel() -> String {
        let formattedPercent = String(format: "%.f", CGFloat(self.getPercents()))
        return formattedPercent
    }
    
    func getPercents() -> Double {
        if let el = self.counter?.first {
            return Double((el.maxPersonCount ?? 0) * (el.personCount ?? 0) / 100)
        }
        return 0
    }
}



