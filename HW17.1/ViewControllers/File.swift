

/*
 //
 //  PhotoSliderViewController.swift
 //  HW17.1
 //
 //  Created by Sharipov Mehrob on 28.06.2023.
 //

 import UIKit

 class ImageSliderViewController: UIViewController {
     
     @IBOutlet weak var slideShowView: UIView!
     @IBOutlet weak var slideTextFeild: UITextField!
     
     let isLikedButton = UIButton(type: .roundedRect)

     var imageView = UIImageView()
     var viewArray = [UIImageView]()
     
     var currentImage :Image? = nil
     
     
     var isLiked: Bool = false {
         didSet {
             if isLiked {
                 isLikedButton.tintColor = .red
                 currentImage?.isLiked = true
             } else {
                 isLikedButton.tintColor = .white
                 currentImage?.isLiked = false
             }
         }
     }
     
     
     override func viewDidLoad() {
         super.viewDidLoad()
         setDefaultView()
         setisLikedButton(buttonSyze: 30)
     }
     
     
     func setDefaultView(){
         let width = slideShowView.frame.width
         let height = slideShowView.frame.height
         imageView = UIImageView(frame: .init(x: 0, y: 0, width: width , height: height))
         viewArray.append(imageView)
         imageView.backgroundColor = .orange
         slideShowView.addSubview(imageView)
     }
     
     
     func setisLikedButton(buttonSyze:Int){
         var configuration = UIButton.Configuration.plain()
         let imageConfiguration = UIImage.SymbolConfiguration(pointSize: CGFloat(buttonSyze))
         configuration.preferredSymbolConfigurationForImage = imageConfiguration
         configuration.image = UIImage(systemName: "heart.fill")
         
         //isLikedButton.tintColor = .white
         
         // if currentImage?.isLiked is true than button color is red else white

         isLikedButton.addTarget(self, action: #selector(likedButtonPressed), for: .touchUpInside)
         isLikedButton.configuration = configuration
         slideShowView.addSubview(isLikedButton)
         
         isLikedButton.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             isLikedButton.topAnchor.constraint(equalTo: slideShowView.topAnchor, constant: 16),
             isLikedButton.trailingAnchor.constraint(equalTo: slideShowView.trailingAnchor, constant: -16),
             isLikedButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonSyze)),
             isLikedButton.widthAnchor.constraint(equalToConstant: CGFloat(buttonSyze))
         ])
     }
     
     func addView(action: Action){
         let width = CGFloat(self.view.frame.width)
         
         let imageModel = ImageSliderModel.shared.imageName(action: action)
         currentImage = imageModel
         
         let imageView = UIImageView()
         imageView.frame.size = .init(width: slideShowView.frame.width, height: slideShowView.frame.height)
         imageView.backgroundColor = randomColor()
         imageView.frame.origin.y = 0

         switch action {
         case .next:
             imageView.frame.origin.x = width
             imageView.image = UIImage(named: imageModel.name)
         case .back:
             imageView.frame.origin.x = -width
             imageView.image = UIImage(named: imageModel.name)
         }
         
         viewArray.append(imageView)
         slideShowView.addSubview(imageView)
     }
     
     func moveView(){
         viewArray.forEach { imageView in
             if imageView.frame.origin.x != 0 {
                 UIView.animate(withDuration: 1) {
                     imageView.frame.origin.x = 0
                     
                     //self.slideTextFeild.text = self.currentImage?.description ?? "Nothing"
                     self.slideTextFeild.text = String(describing: self.currentImage?.isLiked)
                     self.isLikedButton.removeFromSuperview()
                     self.setisLikedButton(buttonSyze: 30)
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
             UIView.animate(withDuration: 1) {
                 self.viewArray[self.viewArray.startIndex].frame.origin.x = width
             }completion: { Bool in
                 self.viewArray.removeFirst().removeFromSuperview()
                 
                 
             }
         }
     }
     
     
     
     
     @objc func likedButtonPressed(_ sender: Any) {
      
         isLiked = !isLiked
        // isLiked = isLikedButton.isSelected
       
     }
     
     
     
     
     @IBAction func nextButtonPressed(_ sender: Any) {
         //createViewsNext()
         addView(action: .next)
         moveView()
         removeView(action: .next)
     }
     
     
     
     @IBAction func backButtonPressed(_ sender: Any) {
         addView(action: .back)
         moveView()
         removeView(action: .back)
       
     }
     
     func randomColor() -> UIColor {
         let r = CGFloat.random(in: 0...1)
         let g = CGFloat.random(in: 0...1)
         let b = CGFloat.random(in: 0...1)
         let alfa = CGFloat.random(in: 0...1)
         return UIColor(red: r, green: g, blue: b, alpha: alfa)
     }
     
     
     
     
 }

*/
