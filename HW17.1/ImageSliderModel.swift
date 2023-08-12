//
//  Model.swift
//  HW17.1
//
//  Created by Sharipov Mehrob on 28.06.2023.
//

import Foundation

enum Action {
    case next, back
}

class ImageSliderModel {
    static let shared = ImageSliderModel()
    private init(){}
    
    private var index = 0
    private var slideImageArray: [SlideImage] = []
    
    var actionButtonObserver = false
    
    //ImageArrayCount
    func ImageArrayCount() -> Int {
        return slideImageArray.count
    }
    
    
    //saveImageArray
    func saveImageArray() -> [SlideImage] {
        return slideImageArray
    }
    
    //loadImageArray
    func loadImageArray(data: [SlideImage]) {
        slideImageArray = data
    }

    //addImage
    func addImage(name: String , isLiked: Bool = false, description: String? = nil){
        let image = SlideImage(name: name, isLiked: isLiked, description: description)
        slideImageArray.append(image)
        print(slideImageArray.count)
        print(index)
    }
    
    //deleteImage
    func deleteImage(){
        if slideImageArray[safe: index] != nil {
            print(index)
            print(slideImageArray.count)
            slideImageArray.remove(at: index)
        }
    }
    
    //deleteImage
    func deleteImageByName(currentName: String){
        if slideImageArray[safe: index] != nil {
            if slideImageArray[self.index].name == currentName {
                print(index)
                print(slideImageArray.count)
                slideImageArray.remove(at: index)
            }
        }
    }
    
    func image(action: Action) -> SlideImage {
        var image: SlideImage? = nil
        
        if slideImageArray.count > 0 {
            switch action {
            case .next:
                if index < slideImageArray.count - 1 {
                    index += 1
                } else {
                    index = 0
                }
            case .back:
                if index > 0 {
                    index -= 1
                } else {
                    index = slideImageArray.count - 1
                }
            }
            actionButtonObserver = false
            image = slideImageArray[index]
        }else {
            actionButtonObserver = true
            image = SlideImage(name: "nosign", isLiked: false, description: nil)
        }
        
        return image!
    }
}


extension Collection {
    /// Returns the element at the specified index if it exists, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
