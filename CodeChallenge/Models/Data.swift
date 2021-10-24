//
//  Data.swift
//  CodeChallenge
//
//  Created by Tendai Maswaya on 10/21/21.
//

import Foundation

struct Data : Codable {
    let center,
        title,
        photographer,
        nasa_id,
        media_type,
        date_created,
        description: String?
    let keywords: [String]?

}
