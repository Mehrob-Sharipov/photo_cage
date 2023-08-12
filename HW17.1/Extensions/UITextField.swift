//
//  slideTextFeild.swift
//  HW17.1
//
//  Created by Sharipov Mehrob on 02.07.2023.
//

import Foundation
import UIKit


extension ImageSliderViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        currentImage?.description = slideTextFeild.text
        slideTextFeild.resignFirstResponder()
        return true
    }
}
