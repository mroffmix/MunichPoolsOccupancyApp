//
//  MockCounterService.swift
//  Counter
//
//  Created by Ilya on 22.10.20.
//

import Foundation
import Combine

class MockCounterService: WebServiceType {

    enum AppError: Error {
        case impossible
    }
    
    func get<T>(id: String) -> AnyPublisher<T, Error> where T : Decodable, T : Encodable {
        return Just(PreviewBuilder.getCounter() as! T)
            .mapError({ _ in  AppError.impossible })
            .eraseToAnyPublisher()
    }
}
