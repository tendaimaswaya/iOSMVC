//
//  ApiResponse.swift
//  CodeChallenge
//
//  Created by Tendai Maswaya on 10/21/21.
//

import Foundation

struct Collection : Codable{ //not the best name, Collection refers to other things - rename once done
    let version,
        href: String
    var items:[Item]
    let metadata : Metadata
    var links : [Link]
    
    static var `default`: Collection{
        .init(version: "", href: "", items: [], metadata: Metadata.init(total_hits: 0), links: [])
    }
}


