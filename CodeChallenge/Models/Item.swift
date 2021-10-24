//
//  Item.swift
//  CodeChallenge
//
//  Created by Tendai Maswaya on 10/21/21.
//

import Foundation

struct Item : Codable {
    let href:String
    let data:[Data]
    let links: [Link]
}
