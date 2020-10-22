//
//  AuthHandler.swift
//  Counter
//
//  Created by Ilya on 22.10.20.
//

import Foundation

protocol AuthHandlerType {
    func setHeaders(to request: inout URLRequest)
}

class AuthHandler: AuthHandlerType {
    private var headers: [String:String]
    
    init(tenantId:String) {
        headers = [
            "Abp-TenantId": tenantId,
            "Abp.TenantId": tenantId
        ]
    }
    
    func setHeaders(to request: inout URLRequest) {
        let _ = headers.map {
            request.addValue($1, forHTTPHeaderField: $0)
        }
    }
    
}
