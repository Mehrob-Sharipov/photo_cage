//
//  PhotoSliderViewController.swift
//  HW17.1
//
//  Created by Sharipov Mehrob on 28.06.2023.
//

import UIKit

final class ImageSliderViewController: UIViewController {
    
    @IBOutlet weak var slideShowView: UIView!
    @IBOutlet weak var slideTextFeild: UITextField!
    
    @IBOutlet weak var isLikedButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backButtonItem: UINavigationItem!
    
    
    //    let isLikedButton = UIButton(type: .roundedRect)
    
    var imageView = UIImageView()
    var viewArray = [UIImageView]()
    var currentImage :SlideImage? = nil
    let imageSliderModel = ImageSliderModel.shared
    
    var isLikedButtonObserver = false {
        didSet {
            if isLikedButtonObserver {
                UIView.animate(withDuration: 1) {
                    self.isLikedButton.tintColor = .red
                    self.currentImage?.isLiked = true
                }
            }else {
                UIView.animate(withDuration: 1) {
                    self.isLikedButton.tintColor = .systemBlue
                    self.currentImage?.isLiked = false
                }
            }
        }
    }
    
    
    var actionButtonObserver = false {
        didSet{
            let array = [slideTextFeild,
                         isLikedButton,
                         backButton,
                         nextButton,
                         deleteButton]
            
            if actionButtonObserver {
                array.forEach {
                    $0?.isEnabled = false
                }
                slideTextFeild.alpha = 0.5
            } else {
                array.forEach {
                    $0?.isEnabled = true
                }
                slideTextFeild.alpha = 1
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.removeObject(forKey: "imageArray")

        slideTextFeild.delegate = self
        setDefaultView()
        registerForKeyboardNotifications()
        saveButton()
    }
    
    func saveButton(){
        let image = UIImage(systemName: "chevron.backward")
       // let item = UIBarButtonItem(title: "back", image: image, target: self, action: #selector(itemAction))
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(itemAction))
        backButtonItem.leftBarButtonItem = item
    }
    
    @objc func itemAction(){
        let data = imageSliderModel.saveImageArray()
        UserDefaults.standard.set(encodable: data, forKey: "imageArray")
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func setDefaultView(){
        let width = slideShowView.frame.width
        let height = slideShowView.frame.height
        imageView = UIImageView(frame: .init(x: 0, y: 0, width: width , height: height))
        imageView.contentMode = .scaleAspectFit
        viewArray.append(imageView)
        imageView.backgroundColor = .orange
        slideShowView.addSubview(imageView)
    }
    
    
    
    func addView(action: Action){
        let width = CGFloat(self.view.frame.width)

        let imageModel = ImageSliderModel.shared.image(action: action)
        currentImage = imageModel
        
        let nameImage = imageModel.name
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = .init(width: slideShowView.frame.width, height: slideShowView.frame.height)
        imageView.frame.origin.y = 0
        isLikedButtonObserver = imageModel.isLiked
        switch action {
        case .next:
            imageView.frame.origin.x = width
            
            if let image = ImageManager.shared.loadImage(fileName: nameImage) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }

        case .back:
            imageView.frame.origin.x = -width
            
            if let image = ImageManager.shared.loadImage(fileName: nameImage) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
        
        viewArray.append(imageView)
        slideShowView.addSubview(imageView)
    }
    
    func moveView(){
        viewArray.forEach { imageView in
            if imageView.frame.origin.x != 0 {
                UIView.animate(withDuration: 0.7) {
                    imageView.frame.origin.x = 0
                    self.slideTextFeild.text = self.currentImage?.description ?? ""
                    self.nextButton.isUserInteractionEnabled = false
                    self.backButton.isUserInteractionEnabled = false
                }
            }
        }
    }
    
    
    func removeView(action:Action){
        var width: CGFloat = 0.0
        
        switch action {
        case .next:
            width -= CGFloat(self.view.frame.width)
        case .back:
            width = CGFloat(self.view.frame.width)
        }
        
        if viewArray.count != 1 {
            UIView.animate(withDuration: 0.7) {
                let view = self.viewArray[self.viewArray.startIndex]
                view.alpha = 0
                view.frame.origin.x = width
            } completion: { Bool in
                self.viewArray.removeFirst().removeFromSuperview()
                self.nextButton.isUserInteractionEnabled = true
                self.backButton.isUserInteractionEnabled = true
            }
        }
    }
    
    
    private func registerForKeyboardNotifications() {
        //Show
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //Hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            UIView.animate(withDuration: 1) {
                self.topConstraint.constant = 60
            }
        } else  {
            UIView.animate(withDuration: 1) {
                self.topConstraint.constant -= keyboardScreenEndFrame.height / 4
            }
        }
        
        view.needsUpdateConstraints()
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func isLikedButtonPressed(_ sender: UIButton) {
        isLikedButtonObserver = !isLikedButtonObserver
    }
    
    
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        imageSliderModel.deleteImageByName(currentName: currentImage!.name)
      //  imageSliderModel.deleteImage()
        ImageManager.shared.deleteImage(fileName: currentImage!.name)
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        actionButtonObserver = imageSliderModel.actionButtonObserver
        
        addView(action: .next)
        moveView()
        removeView(action: .next)
    }
    
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        actionButtonObserver = imageSliderModel.actionButtonObserver
        
        addView(action: .back)
        moveView()
        removeView(action: .back)
    }
 
}
