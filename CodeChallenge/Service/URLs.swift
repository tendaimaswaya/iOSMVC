//
//  URLs.swift
//  CodeChallenge
//
//  Created by Tendai Maswaya on 10/21/21.
//

import Foundation

extension URL{
    static private let baseUrl = "https://images-api.nasa.gov/"
    
    static func fetchNasaContent() -> URL{
        URL(string: "\(baseUrl)search?q=%22%22")!
    }
}
