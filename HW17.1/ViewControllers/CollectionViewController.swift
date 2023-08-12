//
//  SecondViewController.swift
//  HW17.1
//
//  Created by Sharipov Mehrob on 28.06.2023.
//

import UIKit

final class CollectionViewController: UIViewController {

    
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var photoSliderButton: UIButton!
    
    var collectionView: UICollectionView!
    var collectionViewFlowLayout: UICollectionViewFlowLayout!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        //navigationItem.leftBarButtonItem?.isHidden = true
        //navigationItem.leftBarButtonItem?.isEnabled = true
        if let data = UserDefaults.standard.value([SlideImage].self, forKey: "imageArray") {
            ImageSliderModel.shared.loadImageArray(data: data)
            //UserDefaults.standard.removeObject(forKey: "imageArray")
        }
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
  
      
        
        
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        collectionView.reloadData()
        print(ImageSliderModel.shared.ImageArrayCount())

    }
    
    
    func configCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        let itemSize = view.frame.size.width / 2.5
        layout.itemSize = .init(width: itemSize, height: itemSize)

        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            ImageSliderModel.shared.ImageArrayCount()
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotoCollectionViewCell else {return UICollectionViewCell()}
        cell.configCell(indexPath: indexPath)
        return cell
    }
    
    
    

}
