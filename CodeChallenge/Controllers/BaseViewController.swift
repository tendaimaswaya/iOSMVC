//
//  BaseViewController.swift
//  CodeChallenge
//
//  Created by Tendai Maswaya on 10/21/21.
//

import Foundation
import UIKit


class BaseViewController : UIViewController{
    
    func alert(_ heading :String? = "Error", _ msg:String, execFunc actionClosure: @escaping () -> Void){
        let alert = UIAlertController(title: heading, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in actionClosure()})
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
    }
    
}
