//
//  CommonExtension.swift
//  MyNotes
//
//  Created by Mohanraj on 31/03/23.
//

import Foundation
import UIKit


extension UIViewController{
    func displayAlertMessage(parentView: UIViewController, title: String, message: String , buttonAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: buttonAction))
        parentView.present(alert, animated: true, completion: nil)
    }
}
