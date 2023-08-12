//
//  ThirdViewController.swift
//  HW17.1
//
//  Created by Sharipov Mehrob on 28.06.2023.
//

import UIKit
import PhotosUI

final class ThirdViewController: UIViewController {
    
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var boardConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var backButtonItem: UINavigationItem!
    
    
    let imageSliderModel = ImageSliderModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.removeObject(forKey: "imageArray")

        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        thirdTextField.delegate = self
        saveButton()
    }
    
    
    //saveButton
    
    func saveButton(){
        let image = UIImage(systemName: "chevron.backward")
        //let item = UIBarButtonItem(title: "back", image: image, target: self, action: #selector(itemAction))
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(itemAction))
        backButtonItem.leftBarButtonItem = item
    }
    
    @objc func itemAction(){
        print("save")
        let data = self.imageSliderModel.saveImageArray()
        UserDefaults.standard.set(encodable: data, forKey: "imageArray")
        

        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func showKeyboard(notification:Notification){
        
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        
        
        if notification.name == UIResponder.keyboardWillHideNotification {
                self.boardConstraint.constant = 0

        } else {
            self.boardConstraint.constant = -(keyboardFrame.size.height - (self.view.frame.height/4))
        }
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    func phPiker(){
        let pickerConfiguration = PHPickerConfiguration()
        let pickerViewController = PHPickerViewController(configuration: pickerConfiguration)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
    }
    

    
    @IBAction func ImageButtonPressed(_ sender: Any) {
        phPiker()
        thirdTextField.text = ""
    }
}

extension ThirdViewController : PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else {return}
                DispatchQueue.main.async {
                    self.thirdImageView.image = image
                }
                
                DispatchQueue.global().async {
                    guard let nameImage = ImageManager.shared.saveImage(image: image) else {return}
                    self.imageSliderModel.addImage(name: nameImage)
                   print(self.imageSliderModel.ImageArrayCount())
                }
            }
        }
        picker.dismiss(animated: true)
    }
}

extension ThirdViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        thirdTextField.resignFirstResponder()
        
        imageSliderModel.addImage(name: self.thirdTextField.text ?? "")
        return true
    }
    
    
}
