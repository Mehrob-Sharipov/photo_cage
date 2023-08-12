//
//  PhotoModel.swift
//  HW17.1
//
//  Created by Sharipov Mehrob on 29.06.2023.
//

import Foundation
import UIKit

class SlideImage: Codable {
    let name: String
    var description: String?
    var isLiked: Bool
    
    init(name: String, isLiked: Bool, description: String?) {
        self.name = name
        self.isLiked = isLiked
        self.description = description
    }
    
    
    public enum CodingKeys: String, CodingKey {
        case name, description, isLiked
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.isLiked = try container.decode(Bool.self, forKey: .isLiked)
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encode (self.isLiked, forKey: .isLiked)
    }
}



