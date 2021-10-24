//
//  StringExt.swift
//  CodeChallenge
//
//  Created by Tendai Maswaya on 10/22/21.
//

import Foundation
import UIKit


extension String{
    func convertDateToFriendly() -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

        guard let oldDate = olDateFormatter.date(from: self) else {
             return self
        }

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "dd MMM, yyyy"

        return convertDateFormatter.string(from: oldDate)
    }
}
