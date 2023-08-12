//
//  User.swift
//  HW17.1
//
//  Created by Sharipov Mehrob on 05.07.2023.
//

import Foundation

class User: Codable {
    
    var login: String
    var password: String
    var registration: Bool
    
    init(login: String, password: String, registration: Bool) {
        self.login = login
        self.password = password
        self.registration = registration
    }
    
    
    
    public enum CodingKeys: String, CodingKey {
        case login, password, registration
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.login = try container.decode(String.self, forKey: .login)
        self.password = try container.decode(String.self, forKey: .password)
        self.registration = try container.decode(Bool.self, forKey: .registration)
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.login, forKey: .login)
        try container.encode(self.password, forKey: .password)
        try container.encode (self.registration, forKey: .registration)
    }
    
}
