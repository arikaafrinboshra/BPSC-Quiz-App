//
//  AboutViewController.swift
//  BPSCQuizApp
//
//  Created by Arika Afrin Boshra on 4/4/20.
//  Copyright © 2020 Arika Afrin Boshra. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource{
    @IBOutlet weak var developerCollectionView: UICollectionView!
    
    @IBOutlet weak var designerCollectionView: UICollectionView!
    
    let developerImage = [#imageLiteral(resourceName: "60102067_2292613044326506_5945719056886661120_n"),#imageLiteral(resourceName: "60102067_2292613044326506_5945719056886661120_n"),#imageLiteral(resourceName: "60102067_2292613044326506_5945719056886661120_n")]
    let developerName = ["Al Mustakim","Fahim Rahman","Arika Boshra"]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = false
        
        developerCollectionView.delegate = self
        developerCollectionView.dataSource = self
        designerCollectionView.delegate = self
        designerCollectionView.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return developerImage.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
     //   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "developer", for: indexPath)
        
      //  if collectionView.tag == 0{
            
          let cell = developerCollectionView.dequeueReusableCell(withReuseIdentifier: "developer", for: indexPath) as! DeveloperCollectionViewCell
            cell.DeveloperImageView.image = developerImage[indexPath.row]
            cell.DeveloperNameLabel.text = developerName[indexPath.row]
            
     //   }
//        else{
//           let  cell = designerCollectionView.dequeueReusableCell(withReuseIdentifier: "designer", for: indexPath) as! DesignerCollectionViewCell
//            cell.DesignerImageView.image = developerImage[indexPath.row]
//            cell.designerNameLabel.text = developerName[indexPath.row]
//
//        }
        
          
        
        
          return cell
      }
      


}
