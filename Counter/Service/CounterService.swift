//
//  CounterService.swift
//  Counter
//
//  Created by Ilya on 22.10.20.
//

import Foundation
import Combine


protocol WebServiceType {
    func get<T: Codable>(ids: [String]) -> AnyPublisher<T, Error>
}


class CounterService: WebServiceType {
    private let serviceUrl: String
    private let authHandler: AuthHandlerType = AuthHandler(tenantId: "69")
    private let decoder = JSONDecoder()
    init(for path:String) {
        /* https://functions.api.ticos-systems.cloud/api/gates/counter?organizationUnitIds=30194
         */
        
        self.serviceUrl = "https://functions.api.ticos-systems.cloud" + path
        // "/api/gates/counter"
        decoder.dateDecodingStrategy = .iso8601
        
    }
    
    func get<T>(ids: [String]) -> AnyPublisher<T, Error> where T : Decodable, T : Encodable {
        let params = "?organizationUnitIds=" + ids.joined(separator: "&organizationUnitIds=")
        //?organizationUnitIds=
        guard let url = URL(string: serviceUrl + params) else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        var request: URLRequest = URLRequest(url: url)
        
        request.httpMethod = "GET"
        authHandler.setHeaders(to: &request)
        // request.addValue("application/json", forHTTPHeaderField: "Accept")
        // request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map() {
                $0.data
            }
            .decode(type: T.self, decoder: decoder)
            .catch { error in
                Fail(error: error).eraseToAnyPublisher()
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
