//
//  SaveImageModel.swift
//  HW17.1
//
//  Created by Sharipov Mehrob on 04.07.2023.
//

import Foundation
import UIKit

class ImageManager {
   static let shared = ImageManager()
    private init (){}
    
    func saveImage(image: UIImage) -> String? {
            
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
            
            let fileName = UUID().uuidString
            let fileUrl = documentsDirectory.appendingPathComponent(fileName)
          //  let fileUrl = documentsDirectory.appending(path: fileName)
            guard let data = image.pngData() else {return nil}
            
            
            //Checks if file exists, removes it if so.
            if FileManager.default.fileExists(atPath: fileUrl.path) {
                do {
                    try FileManager.default.removeItem(atPath: fileUrl.path)
                    print("Removed old image")
                } catch let error {
                    print("couldn't remove file at path", error)
                }
            }
            
            //saving image
            
            do {
                try data.write(to: fileUrl)
                return fileName
            } catch let error {
                print ("error saving file with error", error)
                return nil
            }
        }
        
        
        
        
        
        func loadImage(fileName: String) -> UIImage? {
            
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let imageUrl = documentsDirectory.appendingPathComponent(fileName)
                let image = UIImage(contentsOfFile: imageUrl.path)
                
//                let imageUrl = documentsDirectory.appending(path: fileName)
//                let image = UIImage(contentsOfFile: imageUrl.path())
                
                return image
            }
            return nil
        }
    
    
    func deleteImage(fileName: String){
        
        guard FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first != nil else {return}
        
        let fileUrl = fileName
        let url = URL(string: fileUrl)
        
        
        
        if FileManager.default.fileExists(atPath: url!.path) {
            do {
                try FileManager.default.removeItem(atPath: (url?.path)!)
                print("Removed old image")
            } catch let error {
                print("couldn't remove file at path", error)
            }
        }
        
    }
}
