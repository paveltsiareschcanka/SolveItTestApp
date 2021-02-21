//
//  Lesson.swift
//  SolveIt.Test
//
//  Created by Pavel Tsiareschcanka on 21.02.21.
//

import Foundation

class Lesson: Codable {
    
    let id: Int
    let type: String
    let status: String
    let name: String
    let updateAt: Int
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.updateAt = try container.decodeIfPresent(Int.self, forKey: .updateAt) ?? 0
    }
}
