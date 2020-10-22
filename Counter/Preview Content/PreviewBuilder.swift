//
//  PreviewBuilder.swift
//  Counter
//
//  Created by Ilya on 22.10.20.
//

import Foundation

struct PreviewBuilder {
    
    static func getCounter() -> CounterResponse {
        return decode(jsonStr: response)
    }
    
    private static func decode<T: Codable>(jsonStr:String) -> T {
        let data = jsonStr.data(using: .utf8)!
        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            
            
            let obj = try jsonDecoder.decode(T.self, from: data)
            return obj
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    private static let response = """
    [{"organizationUnitId":30194,"personCount":15,"maxPersonCount":120}]
    """

}
