//
//  CounterResponse.swift
//  Counter
//
//  Created by Ilya on 22.10.20.
//

import Foundation

// MARK: - CounterResponseElement
struct CounterResponseElement: Codable, Hashable {
    
    static func == (lhs: CounterResponseElement, rhs: CounterResponseElement) -> Bool {
        return lhs.organizationUnitID == rhs.organizationUnitID
    }
    
    var organizationUnitID, personCount, maxPersonCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case organizationUnitID = "organizationUnitId"
        case personCount, maxPersonCount
    }
    
    init(organizationUnitID: Int?, personCount: Int?, maxPersonCount: Int?) {
        self.organizationUnitID = organizationUnitID
        self.personCount = personCount
        self.maxPersonCount = maxPersonCount
    }
}

typealias CounterResponse = [CounterResponseElement]
