//
//  PhotosVC.swift
//  Aqar
//
//  Created by heba isaa on 03/03/2022.
//

import UIKit

class PhotosVC: UIViewController {
    @IBOutlet var displayTable: UICollectionView!
    var stateType="car"

    var realStatePhotos:[String]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        // Do any additional setup after loading the view.
    }
    func setupTable(){
        displayTable.register(PhotoCell.self)
        displayTable.collectionViewLayout = createCompositionalLayout()
        displayTable.delegate=self
        displayTable.dataSource=self
    }

    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension PhotosVC: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realStatePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell:PhotoCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configureImage(realstateImage: realStatePhotos[indexPath.row])
        return cell
        
        
        
    }
    
    
}
extension PhotosVC{
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let fullPhotoItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2/3)))
        
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
   
        
        // Second type: Main with pair
        // 3
//        let mainItem = NSCollectionLayoutItem(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1/2),
//                heightDimension: .fractionalHeight(1.0)))
//
//        mainItem.contentInsets = NSDirectionalEdgeInsets(
//            top: 2,
//            leading: 2,
//            bottom: 2,
//            trailing: 2)
        
        // 2
        let twiceItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/2),
                heightDimension: .fractionalHeight(1.0)))
        
        twiceItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
     ////
        // Second type: Main with pair
        // 3
        let mainItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(2/3),
            heightDimension: .fractionalHeight(1.0)))

        mainItem.contentInsets = NSDirectionalEdgeInsets(
          top: 2,
          leading: 2,
          bottom: 2,
          trailing: 2)

        // 2
        let pairItem = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)))

        pairItem.contentInsets = NSDirectionalEdgeInsets(
          top: 2,
          leading: 2,
          bottom: 2,
          trailing: 2)

        let trailingGroup = NSCollectionLayoutGroup.vertical(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1.0)),
          subitem: pairItem,
          count: 2)

        // 1
        let mainWithPairGroup = NSCollectionLayoutGroup.horizontal(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(4/9)),
          subitems: [mainItem, trailingGroup])

        
        let twiceGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2/4)),
            subitems: [twiceItem, twiceItem])
        
      
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(16/9)),
            subitems: [
                fullPhotoItem,
                mainWithPairGroup,
                fullPhotoItem,
                
                
            ]
        )
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
      
        
        return layout
    }
    
    
    
    
}
extension PhotosVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

